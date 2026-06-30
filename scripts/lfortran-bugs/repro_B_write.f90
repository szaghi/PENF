! Companion: binary (B) OUTPUT edit descriptor on internal write.
program repro_bstr
  use iso_fortran_env, only : int8
  implicit none
  integer(int8) :: buffer(8)
  character(64) :: s
  ! bytes of real64 1.0, little-endian: 00 00 00 00 00 00 F0 3F
  buffer = [0_int8, 0_int8, 0_int8, 0_int8, 0_int8, 0_int8, -16_int8, 63_int8]
  write(s, '(8B8.8)') buffer
  print '(A)', 'B-write : '//trim(s)
  print '(A)', 'expected: 0000000000000000000000000000000000000000000000001111000000111111'
end program repro_bstr
