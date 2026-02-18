---
title: Features
---

# Features

## Kind Parameters

### Real kinds

| Parameter | Precision | Range | Size |
|-----------|-----------|-------|------|
| `R16P` | 33 digits | $[10^{-4931},\ 10^{+4931}-1]$ | 128 bit |
| `R8P` | 15 digits | $[10^{-307},\ 10^{+307}-1]$ | 64 bit |
| `R4P` | 6 digits | $[10^{-37},\ 10^{+37}-1]$ | 32 bit |

### Integer kinds

| Parameter | Range | Size |
|-----------|-------|------|
| `I8P` | $[-2^{63},\ +2^{63}-1]$ | 64 bit |
| `I4P` | $[-2^{31},\ +2^{31}-1]$ | 32 bit |
| `I2P` | $[-2^{15},\ +2^{15}-1]$ | 16 bit |
| `I1P` | $[-2^{7},\ +2^{7}-1]$ | 8 bit |

## Format Strings

Each kind has a matching format string for `print` / `write` statements:

| Kind | Format string | Example output |
|------|--------------|----------------|
| `R16P` | `FR16P = '(E42.33E4)'` | `-0.100000000000000000000000000000000E+0001` |
| `R8P` | `FR8P = '(E23.15E3)'` | `-0.100000000000000E+001` |
| `R4P` | `FR4P = '(E13.6E2)'` | `-0.100000E+01` |
| `I8P` | `FI8P = '(I20)'` | `                  -1` |
| `I4P` | `FI4P = '(I11)'` | `         -1` |
| `I2P` | `FI2P = '(I6)'` | `    -1` |
| `I1P` | `FI1P = '(I4)'` | `  -1` |

```fortran
use penf
call penf_init

real(R8P)    :: x = -1.0_R8P
integer(I4P) :: n = 42_I4P

print FR8P, x !  -0.100000000000000E+001
print FI4P, n !          42
```

## Modules

PENF is composed of four modules that build upon each other:

- **penf_global_parameters_variables** — all portable kind parameters, format strings, and character kinds
- **penf_b_size** — `bit_size()` and `byte_size()` extended to reals and characters
- **penf_stringify** — comprehensive number↔string conversions: `str()`, `strz()`, `cton()`, `bstr()`, `bcton()`
- **penf_allocatable_memory** — allocatable memory utilities: `allocate_variable()`, `assign_allocatable()`, memory tracking
- **penf** — main module, re-exports everything and provides `check_endian()`, `digit()`, `penf_init()`, `penf_print()`

Any feature request is welcome — open an issue on
[GitHub](https://github.com/szaghi/PENF/issues).
