# PENF

**Portability Environment for Fortran Poor People** — a KISS library for portable, parametrized numerical types in modern Fortran (2003+).

- Portable kind parameters for integers and reals (1, 2, 4, 8, 16-byte representations)
- Comprehensive number ↔ string conversion: `str()`, `strz()`, `cton()`, `bstr()`, `bcton()`
- Ready-made format strings (`FI*P`, `FR*P`) and min/max representable values
- Endianness detection and allocatable memory management utilities
- Fortran 2003+ standard compliant — tested with GNU ≥ 4.9.2 and Intel ≥ 12.x

**[Documentation](https://szaghi.github.io/PENF/)** | **[API Reference](https://szaghi.github.io/PENF/api/)**

---

## Copyrights

PENF is an open source project distributed under a multi-licensing system:

- **FOSS projects**: [GPL v3](http://www.gnu.org/licenses/gpl-3.0.html)
- **Closed source / commercial**: [BSD 2-Clause](http://opensource.org/licenses/BSD-2-Clause), [BSD 3-Clause](http://opensource.org/licenses/BSD-3-Clause), or [MIT](http://opensource.org/licenses/MIT)

Anyone interested in using, developing, or contributing to PENF is welcome — pick the license that best fits your needs.

---

## Table of Contents

- [What is PENF?](#what-is-penf)
- [Installation](#installation)
- [Kind Parameters](#kind-parameters)
- [Quick Start](#quick-start)
- [Number → String: `str()`](#number--string-str)
- [Zero-padded integers: `strz()`](#zero-padded-integers-strz)
- [String → Number: `cton()`](#string--number-cton)
- [Binary representation: `bstr()` / `bcton()`](#binary-representation-bstr--bcton)
- [Bit and byte sizes: `bit_size()` / `byte_size()`](#bit-and-byte-sizes-bit_size--byte_size)
- [Utilities](#utilities)
- [Character kinds](#character-kinds-str_ascii--str_ucs4)
- [Allocatable memory management](#allocatable-memory-management)
- [Contributing & releasing](#contributing--releasing)
- [Copyrights](#copyrights)

---

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
| `I8P` | `FI8P = '(I20)'` | `-1` (right-aligned in 20 chars) |
| `I4P` | `FI4P = '(I11)'` | `-1` (right-aligned in 11 chars) |
| `I2P` | `FI2P = '(I6)'` | `-1` (right-aligned in 6 chars) |
| `I1P` | `FI1P = '(I4)'` | `-1` (right-aligned in 4 chars) |

---

## Quick Start

Always call `penf_init` at the start of your program to initialize internal variables:

```fortran
use penf
call penf_init

real(R8P)    :: x = -1.0_R8P
integer(I4P) :: n = 42_I4P

print FR8P, x   !  -0.100000000000000E+001
print FI4P, n   !          42
```

> **Tip:** `penf_init` is idempotent — safe to call multiple times. Call `penf_print(unit)` to dump a full summary of the PENF environment to any I/O unit.

---

## Number → String: `str()`

`str()` converts any scalar or 1D array to a trimmed string. Kind is inferred automatically.

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

Pass a format string when you need full fixed-width output:

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

`strz()` formats an integer with leading zeros — useful for filenames and index strings.

```fortran
use penf

print "(A)", strz(n=1_I8P)            ! 0000000000000000001  (19 digits)
print "(A)", strz(n=1_I4P)            ! 0000000001           (10 digits)
print "(A)", strz(n=1_I8P, nz_pad=5)  ! 00001                (custom width)
```

> **Tip:** Build zero-padded filenames in loops:
> ```fortran
> filename = 'output_'//strz(n=step, nz_pad=6)//'.dat'
> ! → output_000042.dat
> ```

---

## String → Number: `cton()`

`cton()` parses a string into a number of the requested kind, passed as a dummy `knd` argument:

```fortran
use penf

print FR16P, cton(str='-1.0', knd=1._R16P)   ! -0.100000000000000000000000000000000E+0001
print FR8P,  cton(str='-1.0', knd=1._R8P)    ! -0.100000000000000E+001
print FR4P,  cton(str='-1.0', knd=1._R4P)    ! -0.100000E+01

print FI8P, cton(str='-1', knd=1_I8P)        !                   -1
print FI4P, cton(str='-1', knd=1_I4P)        !          -1
print FI2P, cton(str='-1', knd=1_I2P)        !    -1
```

> **Tip:** The `knd` argument is only used to select the right overload — its value is irrelevant. Passing `1._R8P` or `0._R8P` are equivalent.

---

## Binary representation: `bstr()` / `bcton()`

`bstr()` returns the raw IEEE bit pattern of a number as a `'0'`/`'1'` character string:

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

PENF extends the intrinsic `bit_size()` to work with **reals and characters** in addition to integers:

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

PENF provides conversion helpers between `ASCII`, `UCS4` (Unicode), and default character kinds:

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
integer(I4P) :: bounds_2d(2,2) = reshape([1,1, 1,200],      [2,2])
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

PENF uses [Conventional Commits](https://www.conventionalcommits.org/) so that `CHANGELOG.md` can be generated automatically:

| Prefix | When to use | Changelog section |
|--------|-------------|-------------------|
| `feat:` | New feature or capability | **New features** |
| `fix:` | Bug fix | **Bug fixes** |
| `perf:` | Performance improvement | **Performance** |
| `refactor:` | Code restructuring, no behaviour change | **Refactoring** |
| `docs:` | Documentation only | **Documentation** |
| `test:` | Adding or fixing tests | **Testing** |
| `build:` | Build system changes | **Build system** |
| `ci:` | CI/CD changes | **CI/CD** |
| `chore:` | Maintenance, dependency updates | **Miscellaneous** |

Append `!` after the prefix for breaking changes (`feat!:`, `fix!:`). Reference issues with `#123` — they are auto-linked in the changelog.

```
feat: add R32P kind parameter
fix: correct byte_size for character arrays (#42)
docs: improve str() examples in landing page
feat!: rename check_endian to init_endian
```

### Creating a release

Releases are fully automated. The only command you need is:

```bash
# Install git-cliff (once)
npx git-cliff@latest

# Bump version, regenerate CHANGELOG.md, commit, tag and push
scripts/bump.sh patch   # v1.2.3 → v1.2.4
scripts/bump.sh minor   # v1.2.3 → v1.3.0
scripts/bump.sh major   # v1.2.3 → v2.0.0
scripts/bump.sh v2.1.0  # explicit version
```

`bump.sh` will:
1. Regenerate `CHANGELOG.md` from the git log via [git-cliff](https://git-cliff.org/)
2. Commit with `chore(release): vX.Y.Z`
3. Create an annotated tag
4. Push commit + tag → triggers the GitHub Actions release workflow

The release workflow then automatically:
- Runs the full test suite and uploads coverage to Codecov
- Builds the VitePress documentation and deploys it to GitHub Pages
- Packages a versioned tarball `PENF-vX.Y.Z.tar.gz`
- Publishes a GitHub release with the changelog section as release notes
