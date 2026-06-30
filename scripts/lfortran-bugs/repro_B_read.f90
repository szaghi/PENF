! Minimal reproducer: internal READ with binary (B) edit descriptor decodes to zero.
! Expected (per gfortran/ifx): the 64-char bit-string is parsed into 8 bytes whose
! reinterpretation as a real64 yields 1.0.  LFortran 0.63.0 reads all-zero bytes.
program repro_bcton
  use iso_fortran_env, only : int8, real64
  implicit none
  character(64) :: s
  integer(int8) :: buffer(8)
  real(real64)  :: n
  integer       :: i

  s = '0000000000000000000000000000000000000000000000001111000000111111'
  read(s, '(8B8.8)') buffer
  print '(A,8(1x,I4))', 'buffer bytes:', (buffer(i), i=1,8)
  n = transfer(buffer, n)
  print '(A,ES23.15)', 'as real64   :', n
  print '(A)', merge('PASS', 'FAIL', abs(n - 1.0_real64) < 1.0e-12_real64)
end program repro_bcton
