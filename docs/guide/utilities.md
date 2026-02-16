# Utilities

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

## Count digits: `digit()`

```fortran
use penf

print FI4P, digit(100_I8P)    !   3
print FI4P, digit(100_I4P)    !   3
print FI4P, digit(100_I2P)    !   3
print FI4P, digit(-999_I4P)   !   3  (sign not counted)
```

---

## Endianness: `check_endian()`

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
