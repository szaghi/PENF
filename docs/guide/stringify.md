---
title: String Conversions
---

# String Conversions

## Number → String: `str()`

`str()` converts any scalar or 1D array to a trimmed string. Kind is inferred automatically from the argument.

### Scalars

```fortran
use penf

print "(A)", str(n=-1._R16P)   ! -0.100000000000000000000000000000000000E+0001
print "(A)", str(n=-1._R8P)    ! -0.10000000000000000E+001
print "(A)", str(n=-1._R4P)    ! -0.100000000E+01

print "(A)", str(n=-1_I8P)     ! -1
print "(A)", str(n=-1_I4P)     ! -1
print "(A)", str(n=-1_I2P)     ! -1
print "(A)", str(n=-1_I1P)     ! -1
```

### Reals are exact

For real numbers `str()` returns a string that is **read back exactly**: `cton(str(n=x), knd=x) == x` for every finite
`x`. By default the string has the fixed width of the ready-made formats `FR4P`, `FR8P`, `FR16P`, that write 9, 17 and 36
significant digits, the digits always sufficient for an exact read back.

```fortran
use penf

print "(A)", str(n=0.1_R8P)            ! +0.10000000000000001E+000
print "(A)", str(n=huge(1._R8P))       ! +0.17976931348623157E+309
```

### Compact reals

With `compact=.true.` the string returned is the **shortest one that is read back exactly**: the number of significant
digits is increased until the number read back is equal to the input one.

```fortran
use penf

print "(A)", str(n=0.1_R8P, compact=.true.)            ! +0.1
print "(A)", str(n=1._R8P/3._R8P, compact=.true.)      ! +0.3333333333333333
print "(A)", str(n=huge(1._R8P), compact=.true.)       ! +1.7976931348623157E+308
print "(A)", str(n=1.e20_R8P, compact=.true.)          ! +1.0E+20
```

The plain decimal notation is used for decimal exponents in the range [-5, 15], the scientific one otherwise. `NaN` and
`Infinity` are returned as written by the compiler.

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

print "(A)", str(n=-1._R8P, no_sign=.true.)   ! 0.10000000000000000E+001
print "(A)", str(n=-1_I4P,  no_sign=.true.)   ! 1
```

### Arrays with delimiters

```fortran
use penf

print "(A)", str(n=[1._R8P, -2._R8P], delimiters=['(', ')'])
! (+0.10000000000000000E+001,-0.20000000000000000E+001)

print "(A)", str(n=[1._R4P, -2._R4P], separator='|', compact=.true.)
! +1.0|-2.0
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

print FR16P, cton(str='-1.0', knd=1._R16P)   ! -0.100000000000000000000000000000000000E+0001
print FR8P,  cton(str='-1.0', knd=1._R8P)    ! -0.10000000000000000E+001
print FR4P,  cton(str='-1.0', knd=1._R4P)    ! -0.100000000E+01

print FI8P, cton(str='-1', knd=1_I8P)        !                   -1
print FI4P, cton(str='-1', knd=1_I4P)        !          -1
print FI2P, cton(str='-1', knd=1_I2P)        !    -1
```

> **Tip:** The `knd` argument is only used to select the right overload — its value is irrelevant. Use `1._R8P`, `0_I4P`, etc.

---

## Binary string representation: `bstr()` / `bcton()`

`bstr()` returns the raw IEEE bit pattern of a number as a string of `0`/`1` characters, most significant bit first on
all architectures (the string does not depend on the endianness):

```fortran
use penf

print "(A)", bstr(n=1._R8P)
! 0011111111110000000000000000000000000000000000000000000000000000

print "(A)", bstr(n=1._R4P)
! 00111111100000000000000000000000

print "(A)", bstr(n=1_I4P)
! 00000000000000000000000000000001
```

Round-trip back to a number with `bcton()`:

```fortran
use penf

real(R8P) :: x
x = bcton(bstr(n=1._R8P), knd=1._R8P)
print FR8P, x   ! 0.10000000000000000E+001
```
