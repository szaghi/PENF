# Getting Started

## What is PENF?

Fortran is the most popular language for scientific computing, and its programs must be **portable**: the same code must give the same numerical results on every computer architecture. Controlling finite-precision errors requires knowing exactly which precision is associated with each variable.

PENF provides an effective KISS library to achieve this portability. Using the kind-selection functions introduced in Fortran 90/95, PENF lets the programmer accurately control and name numeric precisions in a portable, parametric way — and provides a rich set of utilities to work with those parametrized numbers.

---

## Installation

### FPM (recommended)

Add to your `fpm.toml`:

```toml
[dependencies]
PENF = { git = "https://github.com/szaghi/PENF" }
```

### CMake

```bash
cmake -B build && cmake --build build
```

### FoBiS

```bash
FoBiS.py build -mode static-gnu    # static library
FoBiS.py build -mode shared-gnu    # shared library
```

### Makefile

```bash
make              # static library
make TESTS=yes    # build and run tests
```

---

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

### Format strings

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

print FR8P, x   !  -0.100000000000000E+001
print FI4P, n   !          42
```

---

## Quick Start

### Initialization

Always call `penf_init` at the start of your program to initialize internal variables (byte-size counters, endianness):

```fortran
use penf
call penf_init
```

> **Tip:** `penf_init` is idempotent — safe to call multiple times. Call `penf_print(unit)` to dump a complete summary of the PENF environment to any I/O unit.
