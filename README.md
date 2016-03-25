<a name="top"></a>

# PENF [![GitHub tag](https://img.shields.io/github/tag/szaghi/PENF.svg)]()

[![License](https://img.shields.io/badge/license-GNU%20GeneraL%20Public%20License%20v3%20,%20GPLv3-blue.svg)]()
[![License](https://img.shields.io/badge/license-BSD2-red.svg)]()
[![License](https://img.shields.io/badge/license-BSD3-red.svg)]()
[![License](https://img.shields.io/badge/license-MIT-red.svg)]()

[![Status](https://img.shields.io/badge/status-stable-brightgreen.svg)]()
[![Build Status](https://travis-ci.org/szaghi/PENF.svg?branch=master)](https://travis-ci.org/szaghi/PENF)
[![Coverage Status](https://img.shields.io/codecov/c/github/szaghi/PENF.svg)](http://codecov.io/github/szaghi/PENF?branch=master)

### PENF, Portability Environment for Fortran poor people
A KISS library for exploiting codes portability for modern (2003+) Fortran projects.

+ PENF is a pure Fortran (KISS) library for achieving portable codes for modern Fortran projects;
+ PENF provides many number-to-string and `viceversa` facilities;
+ PENF is Fortran 2003+ standard compliant;
+ PENF is a Free, Open Source Project.

#### Table of Contents

- [What is PENF?](#what-is-penf?)
- [Main features](#main-features)
- [Copyrights](#copyrights)
- [Documentation](#documentation)
	- [A Taste of PENF](#a-taste-of-penf)

#### Issues

[![GitHub issues](https://img.shields.io/github/issues/szaghi/PENF.svg)]()
[![Ready in backlog](https://badge.waffle.io/szaghi/PENF.png?label=ready&title=Ready)](https://waffle.io/szaghi/PENF)
[![In Progress](https://badge.waffle.io/szaghi/PENF.png?label=in%20progress&title=In%20Progress)](https://waffle.io/szaghi/PENF)
[![Open bugs](https://badge.waffle.io/szaghi/PENF.png?label=bug&title=Open%20Bugs)](https://waffle.io/szaghi/PENF)

#### Compiler Support

[![Compiler](https://img.shields.io/badge/GNU-v4.9.2+-brightgreen.svg)]()
[![Compiler](https://img.shields.io/badge/Intel-v12.x+-brightgreen.svg)]()
[![Compiler](https://img.shields.io/badge/IBM%20XL-not%20tested-yellow.svg)]()
[![Compiler](https://img.shields.io/badge/g95-not%20tested-yellow.svg)]()
[![Compiler](https://img.shields.io/badge/NAG-not%20tested-yellow.svg)]()
[![Compiler](https://img.shields.io/badge/PGI-not%20tested-yellow.svg)]()

## What is PENF?

Fortran is the most popular programming language for scientific computing. With Fortran it is quite simple obtain fast code and manage large multidimensional array. Because Fortran permits the achievement of high performance it is also used on great range of different computer-architectures, and often on the fastest supercomputer in the world. Therefore Fortran programs must be _portable_: portability means that the code will give the same results on every different computer-architectures. One of the most important goal of the numeric code is to control the numeric error due to finite precision of numerical operations. Fortran uses the __IEEE__ representations. Integers and reals (floating point) are represented with a finite precision. So when the code computes an operation it has a truncation error due to the truncation of the numerical finite representations. For numerical and more in general scientific applications this source of errors must be controlled. The programmer must know which is the precision associated to the code variables. Before the standard Fortran 90/95 there are not any way to select the precision of the numerical variables in a portable fashion.

Modern Fortran standards (2003+) have introduced better support for codes portability. With the possibility to specify a kind parameter for variables, the standard Fortran 90+ makes available useful functions to select the kind precision in a portable parametric way. Using these functions the programmer can accurately control the precision of its own variables in a portable manner.

PENF module provides an effective KISS library to achieve portability and concurrently it provides many tools to handles parametrized numbers.

Go to [Top](#top)

## Main features

The library provides portable kind-parameters and many useful procedures to deal with them:

* [X] integer and reals parameters for 1,2,4,8,16 bytes-like representations;
* [X] integer and real formats definitions for all parameters;
* [X] integer and real minimum maximum representable numbers;
* [X] number-to-string and string-to-number casting procedures;
* [X] endianism procedures checking.

Any feature request is welcome.

Go to [Top](#top)

## Copyrights

PENF is an open source project, it is distributed under a multi-licensing system:

+ for FOSS projects:
  - [GPL v3](http://www.gnu.org/licenses/gpl-3.0.html);
+ for closed source/commercial projects:
  - [BSD 2-Clause](http://opensource.org/licenses/BSD-2-Clause);
  - [BSD 3-Clause](http://opensource.org/licenses/BSD-3-Clause);
  - [MIT](http://opensource.org/licenses/MIT).

Anyone is interest to use, to develop or to contribute to PENF is welcome, feel free to select the license that best matches your soul!

More details can be found on [wiki](https://github.com/szaghi/PENF/wiki/Copyrights).

Go to [Top](#top)

## Documentation

Besides this README file the PENF documentation is contained into its own [wiki](https://github.com/szaghi/PENF/wiki). Detailed documentation of the API is contained into the [GitHub Pages](http://szaghi.github.io/PENF/index.html) that can also be created locally by means of [ford tool](https://github.com/cmacmackin/ford).

### A Taste of PENF

To be written.

Go to [Top](#top)
