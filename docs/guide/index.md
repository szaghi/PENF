---
title: About PENF
---

# About PENF

PENF (Portability Environment for Fortran poor people) is a KISS library for achieving
portable codes in modern Fortran.

Fortran is the most popular language for scientific computing, and its programs must be
**portable**: the same code must give the same numerical results on every computer
architecture. Controlling finite-precision errors requires knowing exactly which
precision is associated with each variable.

PENF provides an effective KISS library to achieve this portability. Using the
kind-selection functions introduced in Fortran 90/95, PENF lets the programmer
accurately control and name numeric precisions in a portable, parametric way — and
provides a rich set of utilities to work with those parametrised numbers.

## Authors

- Stefano Zaghi — [@szaghi](https://github.com/szaghi)

Contributions are welcome — see the [Contributing](contributing) page.

## Copyrights

PENF is distributed under a multi-licensing system:

| Use case | License |
|---|---|
| FOSS projects | [GPL v3](http://www.gnu.org/licenses/gpl-3.0.html) |
| Closed source / commercial | [BSD 2-Clause](http://opensource.org/licenses/BSD-2-Clause) |
| Closed source / commercial | [BSD 3-Clause](http://opensource.org/licenses/BSD-3-Clause) |
| Closed source / commercial | [MIT](http://opensource.org/licenses/MIT) |
