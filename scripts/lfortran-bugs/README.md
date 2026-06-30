# LFortran reproducer: binary `B` input edit descriptor decodes to zero

**Compiler:** LFortran 0.63.0 (alpha), LLVM 19.1.1, x86_64-conda-linux-gnu
**Oracle:** gfortran (and per the standard) — produces the correct result.

## One-line summary

An internal `READ` using the binary edit descriptor `B` (e.g. `'(8B8.8)'`)
reads **all-zero** bytes instead of decoding the bit-string. The matching
`WRITE` with the same `B` descriptor is **correct**, so the defect is isolated
to *binary input editing*, not the descriptor parser in general.

## Origin

This is the single root cause behind 6 failing PENF doctests
(`bcton`/`bstr`-roundtrip family in `penf_stringify`). PENF's `bctor_R8P`:

```fortran
read(bstr, '(8B8.8)') buffer      ! <-- reads zeros under lfortran
n = transfer(buffer, n)           ! transfer is fine; it faithfully reinterprets the (zero) bytes
```

With a zeroed buffer the reinterpreted real is `0.0` (or, when the buffer is
left uninitialized, denormal garbage such as `0.6E-309`).

## Reproduce

```bash
# the bug — B on READ:
lfortran repro_B_read.f90  -o r && ./r     # prints FAIL, bytes all 0
gfortran repro_B_read.f90  -o r && ./r     # prints PASS

# the control — B on WRITE works:
lfortran repro_B_write.f90 -o w && ./w     # correct bit-string
gfortran repro_B_write.f90 -o w && ./w     # correct bit-string
```

(LFortran links via its default `clang` driver — clang must be on PATH.)

## Standard conformance

Both programs are conforming Fortran 2023, accepted with **zero diagnostics** by
two independent front ends in their strictest standard modes — including LFortran
itself, which still miscompiles the READ:

| command                              | READ result | WRITE result |
|--------------------------------------|-------------|--------------|
| `gfortran -std=f2023 -pedantic -Wall`| PASS        | correct      |
| `lfortran --std=f23`                 | **FAIL**    | correct      |

So the reproducer is not a dialect/extension artifact: LFortran in its own
`--std=f23` conformance mode accepts the code and produces the wrong answer.
(gfortran here is 16.0.1; `B`/`O`/`Z` are data edit descriptors valid on both
input and output, and `.m` in `Bw.m` is simply ignored on input — clause 13.7.)

## Observed vs expected (repro_B_read.f90)

| compiler        | buffer bytes                | as real64            | verdict |
|-----------------|-----------------------------|----------------------|---------|
| gfortran        | `0 0 0 0 0 0 -16 63`        | `1.000000000000E+00` | PASS    |
| lfortran 0.63.0 | `0 0 0 0 0 0   0  0`        | `0.000000000000E+00` | FAIL    |

## Not bugs (excluded after analysis)

The other 13 PENF doctest failures under LFortran are **not** compiler bugs:

- 8 are R16P-width output expectations (`...E+0001`, 33 significant digits).
  PENF is built without `-D_R16P` because LFortran returns kind `-1` for
  `selected_real_kind(33,4931)`; the value correctly falls back to R8P width.
- 4–5 are `bit_size`/`byte_size` of `1._R16P` expecting 128/16 — again a
  consequence of R16P→R8P fallback (64/8 is correct for that build).

Only the binary-`B`-read defect above is a genuine LFortran miscompile.
