---
title: Installation
---

# Installation

## Requirements

A modern Fortran compiler with Fortran 2003+ support.

Tested with GNU (gfortran), Intel (ifort/ifx), IBM XL, and PGI compilers.

## Option 1 — fpm (recommended)

With [Fortran Package Manager](https://fpm.fortran-lang.org) no manual setup is needed.

Add to your `fpm.toml`:

```toml
[dependencies]
PENF = { git = "https://github.com/szaghi/PENF" }
```

Then build:

```bash
fpm build
fpm test
```

## Option 2 — CMake

```bash
cmake -B build && cmake --build build

# With tests
cmake -B build -DBUILD_TESTING=ON
cmake --build build
ctest --test-dir build
```

## Option 3 — FoBiS.py

[FoBiS.py](https://github.com/szaghi/FoBiS) reads the `fobos` file at the repository
root and handles all inter-module dependencies automatically.

```bash
pip install FoBiS.py

git clone https://github.com/szaghi/PENF
cd PENF
```

### Building the library

```bash
# Static library
FoBiS.py build -mode static-gnu

# Shared library
FoBiS.py build -mode shared-gnu

# Debug variants
FoBiS.py build -mode static-gnu-debug
FoBiS.py build -mode shared-gnu-debug
```

Replace `gnu` with `intel` for the Intel compiler.

### Building and running the tests

```bash
FoBiS.py build -mode tests-gnu
```

### Coverage analysis

```bash
FoBiS.py rule -ex makecoverage
```

### Generating API documentation

Requires [Ford](https://github.com/cmacmackin/ford):

```bash
pip install ford
FoBiS.py rule -ex makedoc
```

## Option 4 — Makefile

```bash
make              # static library
make TESTS=yes    # build and run tests
make clean        # remove objects and modules
make cleanall     # remove everything
```

## Quick Start

Always call `penf_init` at the start of your program to initialise internal variables
(byte-size counters, endianness):

```fortran
use penf
call penf_init
```

> **Tip:** `penf_init` is idempotent — safe to call multiple times. Call `penf_print(unit)` to dump a complete summary of the PENF environment to any I/O unit.
