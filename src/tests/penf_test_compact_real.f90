!< PENF's testing program.
program penf_test_compact_real
!< PENF's testing program.
!<
!<### Usage
!<```bash
!< ./penf_test_compact_real
!<```
use penf
use, intrinsic :: iso_fortran_env, only : stdout=>output_unit

implicit none
logical :: test_passed(3) !< List of passed tests.

call penf_init

test_passed = .false.

test_passed(1) = trim(str(n=1._R8P, compact=.true.))=='+0.1E+1'
print "(A,L1)", 'Compact 1.0: '//trim(str(n=1._R8P, compact=.true.))//', is correct? ', test_passed(1)

test_passed(2) = trim(str(n=1._R4P/3._R4P, compact=.true.))=='+0.333333E+0'
print "(A,L1)", 'Compact 1.0/3.0: '//trim(str(n=1._R4P/3._R4P, compact=.true.))//', is correct? ', test_passed(2)

test_passed(3) = trim(str(n=1._R16P/4._R16P, compact=.true.))=='+0.25E+0'
print "(A,L1)", 'Compact 1.0/4.0: '//trim(str(n=1._R16P/4._R16P, compact=.true.))//', is correct? ', test_passed(3)

write(stdout, "(A,L1)") new_line('a')//'Are all tests passed? ', all(test_passed)
endprogram penf_test_compact_real
