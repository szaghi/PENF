=======
IR\_Precision
==========

The IR\_Precision is a Fortran (standard 2003) module useful to achieve portable codes.

The module makes available portable kind-parameters and some useful procedures to deal with them.

It provides variables that contain the minimum and maximum representable values, smallest real values and smallest representable differences by the running calculator.

Finally the module provides procedures to convert a string to number and vice versa, a function to check the _endianism_ of the running calculator and a procedure to print all the aboves values.

----------
Introduction

Fortran is the most popular programming language for scientific computing. With Fortran it is quite simple obtain fast code and manage large multidimensional array. Because Fortran permits the achievement of high performance it is also used on great range of different computer-architectures, and often on the fastest supercomputer in the world. Therefore Fortran programs must be _portable_: portability means that the code will give the same results on every different computer-architectures. One of the most important goal of the numeric code is to control the numeric error due to finite precision of numerical operations. Fortran uses the __IEEE__ representations. Integers and reals (floating point) are represented with a finite precision. So when the code computes an operation it has a truncation error due to the truncation of the numerical finite representations. For numerical and more in general scientific applications this source of errors must be controlled. The programmer must know which is the precision associated to the code variables. Before the standard Fortran 90/95 there are not any way to select the precision of the numerical variables in a portable fashion.

With the possibility to specify a kind parameter for variables, the standard Fortran 90/95 makes available two useful functions to select the kind precision of integers and reals selected\_int\_kind(p) and selected\_real\_kind(p,r). The result, kind\_id, is a scalar of type default integer. For selected\_real\_kind(p,r) the result has a value equal to a value of the kind parameter of a real data type with decimal precision, as returned by the function __precision__, of at least _p_ digits and a decimal exponent range, as returned by the function __range__, of at least r. For selected\_int\_kind(p) the result has a value equal to the value of the kind parameter of the integer data type that represents all values n in the range of about values n with \f$-10^p < n < 10^p\f$.

Using these two functions the programmer can accurately control the precision of its own variables in a portable manner. Note that specifying the kind precision without using these two functions is not portable: real(8) means different precisions on different architectures. Parametrizing the kind of all numerical variables using these two functions makes the code portable.


The IR\_Precision module is an open source project, it is distributed under the [GPL v3](http://www.gnu.org/licenses/gpl-3.0.html). Anyone is interest to use, to develop or to contribute to IR\_Precision is welcome.

Detailed documentation can be found on the [GitHub pages](http://szaghi.github.com/IR_Precision/index.html) of the project.
