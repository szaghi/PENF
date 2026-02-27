# PENF

>#### Portability Environment for Fortran Poor People
> A KISS pure Fortran 2003+ library for portable, parametrized numerical types — kind parameters, format strings, number ↔ string conversions, and more.

[![GitHub tag](https://img.shields.io/github/v/tag/szaghi/PENF)](https://github.com/szaghi/PENF/tags)
[![GitHub issues](https://img.shields.io/github/issues/szaghi/PENF)](https://github.com/szaghi/PENF/issues)
[![CI](https://github.com/szaghi/PENF/actions/workflows/ci.yml/badge.svg)](https://github.com/szaghi/PENF/actions/workflows/ci.yml)
[![coverage](https://img.shields.io/endpoint?url=https://szaghi.github.io/PENF/coverage.json)](https://github.com/szaghi/PENF/actions/workflows/ci.yml)

| 🔢 **Kind Parameters**<br>Integers `I1P`–`I8P` and reals `R4P`/`R8P`/`R16P`, portable across compilers | 🔄 **Number ↔ String**<br>`str()`, `strz()`, `cton()`, `bstr()`, `bcton()` — full round-trips | 📐 **Format Strings & Limits**<br>Ready-made `FI*P` / `FR*P` formats and min/max values for every kind | 📏 **Bit & Byte Sizes**<br>`bit_size()` / `byte_size()` extended to reals, integers, and characters |
|:---:|:---:|:---:|:---:|
| ⚡ **Pure Fortran 2003+**<br>No C, no external deps — tested with gfortran ≥ 4.9.2 and ifort ≥ 12.x | 🔓 **Multi-licensed**<br>GPL v3 · BSD 2/3-Clause · MIT | 📦 **Multiple build systems**<br>fpm, FoBiS.py, CMake, Makefile | 📖 **Documented & Tested**<br>API reference + doctests for all type variants |

For full documentation (guide, API reference, examples, etc.) see the [PENF website](https://szaghi.github.io/PENF/).

---

## Authors

- Stefano Zaghi — [@szaghi](https://github.com/szaghi)

Contributions are welcome — see the [Contributing](/guide/contributing) page.

## Copyrights

This project is distributed under a multi-licensing system:

- **FOSS projects**: [GPL v3](http://www.gnu.org/licenses/gpl-3.0.html)
- **Closed source / commercial**: [BSD 2-Clause](http://opensource.org/licenses/BSD-2-Clause), [BSD 3-Clause](http://opensource.org/licenses/BSD-3-Clause), or [MIT](http://opensource.org/licenses/MIT)

> Anyone interested in using, developing, or contributing to this project is welcome — pick the license that best fits your needs.

---

## Quick start

```fortran
use penf
call penf_init

real(R8P)    :: x = -1.0_R8P
integer(I4P) :: n = 42_I4P

print FR8P, x !  -0.100000000000000E+001
print FI4P, n !          42
```

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

## Install

### FoBiS.py

**Standalone** — clone, build, and install in one command:

```bash
FoBiS.py install szaghi/PENF -mode static-gnu
FoBiS.py install szaghi/PENF -mode static-gnu --prefix /path/to/prefix
```

**As a project dependency** — declare PENF in your `fobos` and run `fetch`:

```ini
[dependencies]
deps_dir = src/third_party
PENF     = https://github.com/szaghi/PENF
```

```bash
FoBiS.py fetch           # fetch and build
FoBiS.py fetch --update  # re-fetch and rebuild
```

### fpm

Add to your `fpm.toml`:

```toml
[dependencies]
PENF = { git = "https://github.com/szaghi/PENF" }
```

### CMake

```bash
cmake -B build && cmake --build build
```

### Makefile

```bash
make              # static library
make TESTS=yes    # build and run tests
```
