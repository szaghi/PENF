---
layout: home

hero:
  name: PENF
  text: Portability Environment for Fortran Poor People
  tagline: A KISS library for portable, parametrized numerical types in modern Fortran (2003+)
  actions:
    - theme: brand
      text: Guide
      link: /guide/
    - theme: alt
      text: API Reference
      link: /api/
    - theme: alt
      text: View on GitHub
      link: https://github.com/szaghi/PENF

features:
  - icon: 🔢
    title: Portable Kind Parameters
    details: Integer and real kind parameters for 1, 2, 4, 8, and 16-byte representations — guaranteed portable across compilers and architectures.
  - icon: 🔄
    title: Number ↔ String Conversion
    details: Comprehensive str(), strz(), cton(), bstr() and bcton() procedures for casting between numbers and strings, including binary representations.
  - icon: 📐
    title: Format Definitions & Limits
    details: Ready-made format strings (FI*P, FR*P) and min/max representable values for every supported kind parameter.
  - icon: 🖥️
    title: Endianness Detection
    details: Built-in check_endian() procedure to detect big- or little-endian byte ordering at runtime.
  - icon: 🧩
    title: Fortran 2003+ Compliant
    details: Fully standard-compliant library. Tested with GNU (≥ 4.9.2) and Intel (≥ 12.x) compilers.
  - icon: 🆓
    title: Free & Open Source
    details: Multi-licensed — GPLv3 for FOSS projects, BSD 2/3-Clause or MIT for commercial use. Any contributor is welcome.
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

## Authors

- Stefano Zaghi — [@szaghi](https://github.com/szaghi)

Contributions are welcome — see the [Contributing](contributing) page.

## Copyrights

PENF is distributed under a multi-licensing system:

- **FOSS projects**: [GPL v3](http://www.gnu.org/licenses/gpl-3.0.html)
- **Closed source / commercial**: [BSD 2-Clause](http://opensource.org/licenses/BSD-2-Clause), [BSD 3-Clause](http://opensource.org/licenses/BSD-3-Clause), or [MIT](http://opensource.org/licenses/MIT)

Anyone interested in using, developing, or contributing to PENF is welcome — pick the license that best fits your needs.
