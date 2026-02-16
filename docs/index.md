---
layout: home

hero:
  name: PENF
  text: Portability Environment for Fortran Poor People
  tagline: A KISS library for portable, parametrized numerical types in modern Fortran (2003+)
  actions:
    - theme: brand
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

## What is PENF?

Fortran is the most popular language for scientific computing, and its programs must be **portable**: the same code must give the same numerical results on every computer architecture. Controlling finite-precision errors requires knowing exactly which precision is associated with each variable.

PENF provides an effective KISS library to achieve this portability. Using the kind-selection functions introduced in Fortran 90/95, PENF lets the programmer accurately control and name numeric precisions in a portable, parametric way — and provides a rich set of utilities to work with those parametrized numbers.

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

---

## Number → String: `str()`

`str()` converts any scalar or 1D array to a trimmed string. Kind is inferred automatically from the argument.

### Scalars

```fortran
use penf

print "(A)", str(n=-1._R16P)   ! -0.100000000000000000000000000000000E+0001
print "(A)", str(n=-1._R8P)    ! -0.100000000000000E+001
print "(A)", str(n=-1._R4P)    ! -0.100000E+01

print "(A)", str(n=-1_I8P)     ! -1
print "(A)", str(n=-1_I4P)     ! -1
print "(A)", str(n=-1_I2P)     ! -1
print "(A)", str(n=-1_I1P)     ! -1
```

### Explicit format

Pass a format string directly when you need full-width output:

```fortran
use penf

print "(A)", str(fm=FI8P, n=1_I8P)   !                    1
print "(A)", str(fm=FI4P, n=1_I4P)   !           1
print "(A)", str(fm=FI1P, n=1_I1P)   !    1
```

### Drop the sign

```fortran
use penf

print "(A)", str(n=-1._R8P, no_sign=.true.)   ! 0.100000000000000E+001
print "(A)", str(n=-1_I4P,  no_sign=.true.)   ! 1
```

### Arrays with delimiters

```fortran
use penf

print "(A)", str(n=[1._R8P, -2._R8P], delimiters=['(', ')'])
! (+0.100000000000000E+001,-0.200000000000000E+001)

print "(A)", str(n=[1._R4P, -2._R4P], delimiters=['(', ')'])
! (+0.100000E+01,-0.200000E+01)
```

---

## Zero-padded integers: `strz()`

`strz()` formats an integer with leading zeros, useful for file-name generation and indices.

```fortran
use penf

print "(A)", strz(n=1_I8P)            ! 0000000000000000001  (19 digits)
print "(A)", strz(n=1_I4P)            ! 0000000001           (10 digits)
print "(A)", strz(n=1_I8P, nz_pad=5)  ! 00001                (custom width)
```

> **Tip:** Use `strz` to build zero-padded filenames in loops:
> ```fortran
> filename = 'output_'//strz(n=step_I4P, nz_pad=6)//'.dat'
> ! → output_000042.dat
> ```

---

## String → Number: `cton()`

`cton()` parses a string into a number of the requested kind (passed as a dummy `knd` argument):

```fortran
use penf

print FR16P, cton(str='-1.0', knd=1._R16P)   ! -0.100000000000000000000000000000000E+0001
print FR8P,  cton(str='-1.0', knd=1._R8P)    ! -0.100000000000000E+001
print FR4P,  cton(str='-1.0', knd=1._R4P)    ! -0.100000E+01

print FI8P, cton(str='-1', knd=1_I8P)        !                   -1
print FI4P, cton(str='-1', knd=1_I4P)        !          -1
print FI2P, cton(str='-1', knd=1_I2P)        !    -1
```

> **Tip:** The `knd` argument is only used to select the right overload — its value is irrelevant. Use `1._R8P`, `0_I4P`, etc.

---

## Binary string representation: `bstr()` / `bcton()`

`bstr()` returns the raw IEEE bit pattern of a number as a string of `0`/`1` characters:

```fortran
use penf

print "(A)", bstr(n=1._R8P)
! 0000000000000000000000000000000000000000000000001111000000111111

print "(A)", bstr(n=1._R4P)
! 00000000000000001000000000111111

print "(A)", bstr(n=1_I4P)
! 00000000000000000000000000000001
```

Round-trip back to a number with `bcton()`:

```fortran
use penf

real(R8P) :: x
x = bcton(bstr(n=1._R8P), knd=1._R8P)
print FR8P, x   ! 0.100000000000000E+001
```

---

## Bit and byte sizes: `bit_size()` / `byte_size()`

PENF extends the intrinsic `bit_size()` to work with **reals and characters** too:

```fortran
use penf

print FI2P, bit_size(1._R16P)   !  128
print FI1P, bit_size(1._R8P)    !   64
print FI1P, bit_size(1._R4P)    !   32
print FI4P, bit_size('ab')      !   16  (2 characters × 8 bits)

print FI1P, byte_size(1._R16P)  !   16
print FI1P, byte_size(1._R8P)   !    8
print FI1P, byte_size(1._R4P)   !    4
print FI1P, byte_size(1_I8P)    !    8
print FI1P, byte_size('ab')     !    2
```

---

## Utilities

### Count digits: `digit()`

```fortran
use penf

print FI4P, digit(100_I8P)    !   3
print FI4P, digit(100_I4P)    !   3
print FI4P, digit(100_I2P)    !   3
print FI4P, digit(-999_I4P)   !   3  (sign not counted)
```

### Endianness: `check_endian()`

```fortran
use penf

call check_endian
print *, endian   ! 1 = little endian (x86), 0 = big endian
```

> **Tip:** The result is stored in the module variable `endian`. Compare against the exported constants `endianL` (little) and `endianB` (big).

---

## Character kinds: `str_ascii()` / `str_ucs4()`

PENF provides conversion helpers between the `ASCII`, `UCS4` (Unicode), and default character kinds:

```fortran
use penf

character(len=:, kind=ASCII), allocatable :: s_ascii
character(len=:, kind=UCS4),  allocatable :: s_ucs4

s_ascii = str_ascii('Default kind → ASCII')
s_ascii = str_ascii(UCS4_'Unicode → ASCII')

s_ucs4 = str_ucs4('Default kind → UCS4')
s_ucs4 = str_ucs4(ASCII_'ASCII → UCS4')
```

---

## Allocatable memory management

`allocate_variable()` allocates arrays with explicit lower/upper bounds and optional logging:

```fortran
use penf

real(R8P), allocatable :: field_1d(:)
real(R8P), allocatable :: field_2d(:,:)
real(R8P), allocatable :: field_3d(:,:,:)

integer(I4P) :: bounds_1d(2)   = [1, 100]
integer(I4P) :: bounds_2d(2,2) = reshape([1,1, 1,200], [2,2])
integer(I4P) :: bounds_3d(2,3) = reshape([1,1, 1,200, 1,300], [2,3])

call allocate_variable(field_1d, bounds_1d)
call allocate_variable(field_2d, bounds_2d)
call allocate_variable(field_3d, bounds_3d)

print *, allocated(field_1d), allocated(field_2d), allocated(field_3d)   ! T T T
```

`assign_allocatable()` safely reallocates and copies an array:

```fortran
use penf

real(R8P), allocatable :: a(:,:), b(:,:)

allocate(b(1:10, 1:20))
b = 0._R8P

call assign_allocatable(a, b)   ! a is allocated and filled from b
print *, allocated(a)           ! T
```

> **Tip:** Pass `file_unit` and `verbose=.true.` to `allocate_variable()` to log every allocation with size and bounds — handy for tracking memory usage in large simulations.

---

## Contributing & releasing

### Commit style

PENF uses [Conventional Commits](https://www.conventionalcommits.org/) so that `CHANGELOG.md` is generated automatically from the git log:

| Prefix | Purpose | Changelog section |
|--------|---------|-------------------|
| `feat:` | New feature or capability | New features |
| `fix:` | Bug fix | Bug fixes |
| `perf:` | Performance improvement | Performance |
| `refactor:` | Code restructuring | Refactoring |
| `docs:` | Documentation only | Documentation |
| `test:` | Tests | Testing |
| `build:` | Build system | Build system |
| `ci:` | CI/CD pipeline | CI/CD |
| `chore:` | Maintenance | Miscellaneous |

Append `!` for breaking changes (`feat!:`, `fix!:`). Reference issues with `#123` — they are auto-linked.

```
feat: add R32P kind parameter
fix: correct byte_size for character arrays (#42)
feat!: rename check_endian to init_endian
```

### Creating a release

Releases are fully automated via `scripts/bump.sh` and GitHub Actions. The only steps needed are:

```bash
# Install git-cliff once
npx git-cliff@latest

# Then, to release:
scripts/bump.sh patch   # v1.2.3 → v1.2.4
scripts/bump.sh minor   # v1.2.3 → v1.3.0
scripts/bump.sh major   # v1.2.3 → v2.0.0
scripts/bump.sh v2.1.0  # explicit version
```

`bump.sh` will ask for confirmation, then:

1. Regenerate `CHANGELOG.md` from the git log via [git-cliff](https://git-cliff.org/)
2. Commit with `chore(release): vX.Y.Z`
3. Create an annotated git tag
4. Push commit + tag

Pushing the tag triggers the GitHub Actions release workflow, which automatically:
- Runs the full test suite and uploads coverage to Codecov
- Builds this documentation site and deploys it to GitHub Pages
- Packages a versioned tarball `PENF-vX.Y.Z.tar.gz`
- Publishes a GitHub release with the changelog section as release notes

---

## Copyrights

PENF is distributed under a multi-licensing system:

- **FOSS projects**: [GPL v3](http://www.gnu.org/licenses/gpl-3.0.html)
- **Closed source / commercial**: [BSD 2-Clause](http://opensource.org/licenses/BSD-2-Clause), [BSD 3-Clause](http://opensource.org/licenses/BSD-3-Clause), or [MIT](http://opensource.org/licenses/MIT)

Anyone interested in using, developing, or contributing to PENF is welcome — pick the license that best fits your needs.
