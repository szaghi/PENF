!< PENF's testing program.
program penf_test_all
!< PENF's testing program.
!<
!<### Usage
!<```bash
!< ./penf_test_all
!<```
use penf
use, intrinsic :: iso_fortran_env, only : stdout=>output_unit

implicit none

call penf_init
call penf_print(unit=stdout)
print "(A)", ''
print "(A)", 'Testing PENF tools'
print "(A)", ASCII_'Casting string_default-to-string_ascii: '//str_ascii('I was DEFAULT kind')
print "(A)", ASCII_'Casting string_ascii-to-string_ascii: '//str_ascii(ASCII_'I was ASCII kind')
print "(A)", ASCII_'Casting string_ucs4-to-string_ascii: '//str_ascii(UCS4_'I was UCS4 kind')
print "(A)", UCS4_'Casting string_default-to-string_ucs4: '//str_ucs4('I was DEFAULT kind')
print "(A)", UCS4_'Casting string_ascii-to-string_ucs4: '//str_ucs4(ASCII_'I was ASCII kind')
print "(A)", UCS4_'Casting string_ucs4-to-string_ucs4: '//str_ucs4(UCS4_'I was UCS4 kind')
print "(A)", 'Casting real-to-string: '//str(n=1._R8P)
print "(A)", 'Casting integer-to-string: '//str(n=11_I8P)
print "(A,"//FR8P//")", 'Casting string-to-real: ', cton(str='2.2d0', knd=1._R8P)
print "(A,"//FI4P//")", 'Casting integer-to-string: ', cton(str='43', knd=1_I4P)
print "(A)", 'Casting integer-to-string with zero padding: '//trim(strz(nz_pad=3, n=34_I8P))
#ifndef __GFORTRAN__
print "(A)", 'Casting real-to-bit_string: '//bstr(n=1._R4P)
#endif
print "(A)", 'Casting integer-to-bit_string: '//bstr(n=1_I4P)
#ifndef __GFORTRAN__
print "(A,"//FR4P//")", 'Casting bit_string-to-real: ', bcton(bstr='00111111100000000000000000000000', knd=1._R4P)
#endif
print "(A,"//FI4P//")", 'Casting bit_string-to-integer: ', bcton(bstr='00000000000000000000000000000001', knd=1_I4P)
print "(A)", 'Number of digit of 1023: '//str(n=digit(1023_I4P))
write(stdout, "(A,L1)") new_line('a')//'Are all tests passed? ', .true.
endprogram penf_test_all
