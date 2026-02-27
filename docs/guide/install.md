---
title: Installation
---

# Installation

## Requirements

A modern Fortran compiler with Fortran 2003+ support.

Tested with GNU (gfortran), Intel (ifort/ifx), IBM XL, and PGI compilers.

## Option 1 — FoBiS.py

[FoBiS.py](https://github.com/szaghi/FoBiS) is a Fortran build system that reads a
`fobos` configuration file and handles inter-module dependencies automatically.

```bash
pip install FoBiS.py
```

### Standalone installation

Use `FoBiS.py install` to clone PENF from GitHub, build it, and install it to a prefix
in one command — no manual `git clone` needed:

```bash
# Build and install to ~/.local (default prefix)
FoBiS.py install szaghi/PENF -mode static-gnu

# Install to a custom prefix
FoBiS.py install szaghi/PENF -mode static-gnu --prefix /path/to/prefix

# Clone only, skip building
FoBiS.py install szaghi/PENF --no-build
```

Replace `static-gnu` with `shared-gnu` for a shared library, or `gnu` with `intel` for
the Intel compiler.

### As a project dependency

Use `FoBiS.py fetch` to clone and build PENF alongside your own project. It can be
invoked directly from the command line or configured as a rule inside your `fobos` file.

First, declare PENF in the `[dependencies]` section of your project's `fobos`:

```ini
[dependencies]
deps_dir = src/third_party        # where dependencies are cloned
PENF     = https://github.com/szaghi/PENF
```

**Via the CLI** — run `fetch` directly whenever you need to (re-)install dependencies:

```bash
FoBiS.py fetch           # fetch and build all declared dependencies
FoBiS.py fetch --update  # re-fetch (git pull) and rebuild
FoBiS.py fetch --no-build  # clone only, skip build
```

**Via a fobos rule** — embed `fetch` as a named rule so the whole team uses the same
command and flags without remembering CLI options:

```ini
[rule-deps]
help = Fetch and build all project dependencies
rule = FoBiS.py fetch
```

Then anyone working on the project runs:

```bash
FoBiS.py rule -ex deps
```

### Building the library from source

```bash
# Static library
FoBiS.py build -mode static-gnu

# Shared library
FoBiS.py build -mode shared-gnu

# Debug variants
FoBiS.py build -mode static-gnu-debug
FoBiS.py build -mode shared-gnu-debug
```

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

## Option 2 — fpm

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

## Option 3 — CMake

```bash
cmake -B build && cmake --build build

# With tests
cmake -B build -DBUILD_TESTING=ON
cmake --build build
ctest --test-dir build
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
