LFortran reads the binary (`B`) edit descriptor as all-zero bytes instead of decoding the bit-string. The same descriptor writes correctly. The control program below shows the write working, so the defect sits in binary input editing.

## The bug: `B` on READ

```fortran
program repro_b_read
  use iso_fortran_env, only : int8, real64
  implicit none
  character(64) :: s
  integer(int8) :: buffer(8)
  real(real64)  :: n
  integer       :: i

  s = '0000000000000000000000000000000000000000000000001111000000111111'
  read(s, '(8B8.8)') buffer
  print '(A,8(1x,I4))', 'buffer bytes:', (buffer(i), i=1,8)
  n = transfer(buffer, n)
  print '(A,ES23.15)', 'as real64   :', n
  print '(A)', merge('PASS', 'FAIL', abs(n - 1.0_real64) < 1.0e-12_real64)
end program repro_b_read
```

```console
$ lfortran repro_b_read.f90 && ./a.out
buffer bytes:    0    0    0    0    0    0    0    0
as real64   :  0.000000000000000E+00
FAIL
```

```console
$ gfortran repro_b_read.f90 && ./a.out
buffer bytes:    0    0    0    0    0    0  -16   63
as real64   :  1.000000000000000E+00
PASS
```

The read fills `buffer` with zeros. The `transfer` after it does its job and reinterprets those zero bytes faithfully, so `n` comes out as `0.0`.

## The control: `B` on WRITE (works on both)

```fortran
program repro_b_write
  use iso_fortran_env, only : int8
  implicit none
  integer(int8) :: buffer(8)
  character(64) :: s
  buffer = [0_int8, 0_int8, 0_int8, 0_int8, 0_int8, 0_int8, -16_int8, 63_int8]
  write(s, '(8B8.8)') buffer
  print '(A)', 'B-write : '//trim(s)
end program repro_b_write
```

```console
$ lfortran repro_b_write.f90 && ./a.out
B-write : 0000000000000000000000000000000000000000000000001111000000111111

$ gfortran repro_b_write.f90 && ./a.out
B-write : 0000000000000000000000000000000000000000000000001111000000111111
```

## Standard conformance

Both programs are conforming Fortran 2023. Two independent front ends accept them with zero diagnostics in their strictest standard modes, and LFortran still miscompiles the read in its own conformance mode:

| command                               | READ     | WRITE   |
|---------------------------------------|----------|---------|
| `gfortran -std=f2023 -pedantic -Wall` | PASS     | correct |
| `lfortran --std=f23`                  | **FAIL** | correct |

This rules out a dialect or extension explanation. With `--std=f23` LFortran accepts the code and computes the wrong answer.

## Environment

```
LFortran version: 0.63.0
Status: alpha
Platform: Linux
LLVM: 19.1.1
Default target: x86_64-conda-linux-gnu
```
gfortran reference: 16.0.1.

## Context

I hit this building the [PENF](https://github.com/szaghi/PENF) library with LFortran. PENF's `bcton` bit-string-to-number routines run `read(bstr, '(8B8.8)') buffer; n = transfer(buffer, n)`, which reduces to the program above.
