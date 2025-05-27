!< PENF allocatable memory facility.

module penf_allocatable_memory
!< PENF allocatable memory facility.
!< Wrap allocatable arrays routines providing extra information about memory handling.

use, intrinsic :: iso_fortran_env, only : stdout=>output_unit
use penf_global_parameters_variables
use penf_stringify

implicit none
save
private
public :: allocate_variable
public :: assign_allocatable
public :: get_memory_info
public :: save_memory_status

interface allocate_variable
!< Allocate CPU variable with memory checking.
module procedure                   &
#if defined _R16P
                 alloc_var_R16P_1D,&
                 alloc_var_R16P_2D,&
                 alloc_var_R16P_3D,&
                 alloc_var_R16P_4D,&
                 alloc_var_R16P_5D,&
                 alloc_var_R16P_6D,&
                 alloc_var_R16P_7D,&
#endif
                 alloc_var_R8P_1D, &
                 alloc_var_R8P_2D, &
                 alloc_var_R8P_3D, &
                 alloc_var_R8P_4D, &
                 alloc_var_R8P_5D, &
                 alloc_var_R8P_6D, &
                 alloc_var_R8P_7D, &
                 alloc_var_R4P_1D, &
                 alloc_var_R4P_2D, &
                 alloc_var_R4P_3D, &
                 alloc_var_R4P_4D, &
                 alloc_var_R4P_5D, &
                 alloc_var_R4P_6D, &
                 alloc_var_R4P_7D, &
                 alloc_var_I8P_1D, &
                 alloc_var_I8P_2D, &
                 alloc_var_I8P_3D, &
                 alloc_var_I8P_4D, &
                 alloc_var_I8P_5D, &
                 alloc_var_I8P_6D, &
                 alloc_var_I8P_7D, &
                 alloc_var_I4P_1D, &
                 alloc_var_I4P_2D, &
                 alloc_var_I4P_3D, &
                 alloc_var_I4P_4D, &
                 alloc_var_I4P_5D, &
                 alloc_var_I4P_6D, &
                 alloc_var_I4P_7D, &
                 alloc_var_I2P_1D, &
                 alloc_var_I2P_2D, &
                 alloc_var_I2P_3D, &
                 alloc_var_I2P_4D, &
                 alloc_var_I2P_5D, &
                 alloc_var_I2P_6D, &
                 alloc_var_I2P_7D, &
                 alloc_var_I1P_1D, &
                 alloc_var_I1P_2D, &
                 alloc_var_I1P_3D, &
                 alloc_var_I1P_4D, &
                 alloc_var_I1P_5D, &
                 alloc_var_I1P_6D, &
                 alloc_var_I1P_7D
endinterface allocate_variable

interface assign_allocatable
!< Assign CPU variable with memory checking.
module procedure                            &
#if defined _R16P
                 assign_allocatable_R16P_1D,&
                 assign_allocatable_R16P_2D,&
                 assign_allocatable_R16P_3D,&
                 assign_allocatable_R16P_4D,&
                 assign_allocatable_R16P_5D,&
                 assign_allocatable_R16P_6D,&
                 assign_allocatable_R16P_7D,&
#endif
                 assign_allocatable_R8P_1D, &
                 assign_allocatable_R8P_2D, &
                 assign_allocatable_R8P_3D, &
                 assign_allocatable_R8P_4D, &
                 assign_allocatable_R8P_5D, &
                 assign_allocatable_R8P_6D, &
                 assign_allocatable_R8P_7D, &
                 assign_allocatable_R4P_1D, &
                 assign_allocatable_R4P_2D, &
                 assign_allocatable_R4P_3D, &
                 assign_allocatable_R4P_4D, &
                 assign_allocatable_R4P_5D, &
                 assign_allocatable_R4P_6D, &
                 assign_allocatable_R4P_7D, &
                 assign_allocatable_I8P_1D, &
                 assign_allocatable_I8P_2D, &
                 assign_allocatable_I8P_3D, &
                 assign_allocatable_I8P_4D, &
                 assign_allocatable_I8P_5D, &
                 assign_allocatable_I8P_6D, &
                 assign_allocatable_I8P_7D, &
                 assign_allocatable_I4P_1D, &
                 assign_allocatable_I4P_2D, &
                 assign_allocatable_I4P_3D, &
                 assign_allocatable_I4P_4D, &
                 assign_allocatable_I4P_5D, &
                 assign_allocatable_I4P_6D, &
                 assign_allocatable_I4P_7D, &
                 assign_allocatable_I2P_1D, &
                 assign_allocatable_I2P_2D, &
                 assign_allocatable_I2P_3D, &
                 assign_allocatable_I2P_4D, &
                 assign_allocatable_I2P_5D, &
                 assign_allocatable_I2P_6D, &
                 assign_allocatable_I2P_7D, &
                 assign_allocatable_I1P_1D, &
                 assign_allocatable_I1P_2D, &
                 assign_allocatable_I1P_3D, &
                 assign_allocatable_I1P_4D, &
                 assign_allocatable_I1P_5D, &
                 assign_allocatable_I1P_6D, &
                 assign_allocatable_I1P_7D
endinterface assign_allocatable

contains
   ! allocate variable
   ! R16P
   subroutine alloc_var_R16P_1D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R16P, rank 1).
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:)
   !< integer(I4P)            :: ulb(2)=[1,1]
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: var(:)              !< Varibale to be allocate on CPU.
   integer(I4P),            intent(in)           :: ulb(2)              !< Upper/lower bounds of variable.
   integer(I4P),            intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),            intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                  :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                     :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                       :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                  :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_, '(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1):ulb(2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R16P_1D

   subroutine alloc_var_R16P_2D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R16P, rank 2).
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:,:)
   !< integer(I4P)            :: ulb(2,2)=reshape([1,1, &
   !<                                              1,2],&
   !<                                             [2,2])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: var(:,:)            !< Varibale to be allocate on CPU.
   integer(I4P),            intent(in)           :: ulb(2,2)            !< Upper/lower bounds of variable.
   integer(I4P),            intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),            intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                  :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                     :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                       :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                  :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R16P_2D

   subroutine alloc_var_R16P_3D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R16P, rank 3).
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:,:,:)
   !< integer(I4P)            :: ulb(2,3)=reshape([1,1, &
   !<                                              1,2, &
   !<                                              1,3],&
   !<                                             [2,3])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: var(:,:,:)          !< Varibale to be allocate on CPU.
   integer(I4P),            intent(in)           :: ulb(2,3)            !< Upper/lower bounds of variable.
   integer(I4P),            intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),            intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                  :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                     :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                       :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                  :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R16P_3D

   subroutine alloc_var_R16P_4D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R16P, rank 4).
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:,:,:,:)
   !< integer(I4P)            :: ulb(2,4)=reshape([1,1, &
   !<                                              1,2, &
   !<                                              1,3, &
   !<                                              1,4],&
   !<                                             [2,4])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: var(:,:,:,:)        !< Varibale to be allocate on CPU.
   integer(I4P),            intent(in)           :: ulb(2,4)            !< Upper/lower bounds of variable.
   integer(I4P),            intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),            intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                  :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                     :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                       :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                  :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R16P_4D

   subroutine alloc_var_R16P_5D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R16P, rank 5).
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:,:,:,:,:)
   !< integer(I4P)            :: ulb(2,5)=reshape([1,1, &
   !<                                              1,2, &
   !<                                              1,3, &
   !<                                              1,4, &
   !<                                              1,5],&
   !<                                             [2,5])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: var(:,:,:,:,:)      !< Varibale to be allocate on CPU.
   integer(I4P),            intent(in)           :: ulb(2,5)            !< Upper/lower bounds of variable.
   integer(I4P),            intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),            intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                  :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                     :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                       :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                  :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R16P_5D

   subroutine alloc_var_R16P_6D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R16P, rank 6).
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:,:,:,:,:,:)
   !< integer(I4P)            :: ulb(2,6)=reshape([1,1, &
   !<                                              1,2, &
   !<                                              1,3, &
   !<                                              1,4, &
   !<                                              1,5, &
   !<                                              1,6],&
   !<                                             [2,6])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: var(:,:,:,:,:,:)    !< Varibale to be allocate on CPU.
   integer(I4P),            intent(in)           :: ulb(2,6)            !< Upper/lower bounds of variable.
   integer(I4P),            intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),            intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                  :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                     :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                       :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                  :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R16P_6D

   subroutine alloc_var_R16P_7D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R16P, rank 6).
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:,:,:,:,:,:,:)
   !< integer(I4P)            :: ulb(2,7)=reshape([1,1, &
   !<                                              1,2, &
   !<                                              1,3, &
   !<                                              1,4, &
   !<                                              1,5, &
   !<                                              1,6, &
   !<                                              1,7],&
   !<                                             [2,7])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: var(:,:,:,:,:,:,:)  !< Varibale to be allocate on CPU.
   integer(I4P),            intent(in)           :: ulb(2,7)            !< Upper/lower bounds of variable.
   integer(I4P),            intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),            intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                  :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                     :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                       :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                  :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6), &
                ulb(1,7):ulb(2,7)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R16P_7D

   ! R8P
   subroutine alloc_var_R8P_1D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R8P, rank 1).
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:)
   !< integer(I4P)           :: ulb(2)=[1,1]
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: var(:)              !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2)              !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1):ulb(2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R8P_1D

   subroutine alloc_var_R8P_2D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R8P, rank 2).
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:,:)
   !< integer(I4P)           :: ulb(2,2)=reshape([1,1, &
   !<                                             1,2],&
   !<                                            [2,2])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: var(:,:)            !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2,2)            !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R8P_2D

   subroutine alloc_var_R8P_3D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R8P, rank 3).
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:,:,:)
   !< integer(I4P)           :: ulb(2,3)=reshape([1,1, &
   !<                                             1,2, &
   !<                                             1,3],&
   !<                                            [2,3])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: var(:,:,:)          !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2,3)            !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R8P_3D

   subroutine alloc_var_R8P_4D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R8P, rank 4).
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:,:,:,:)
   !< integer(I4P)           :: ulb(2,4)=reshape([1,1, &
   !<                                             1,2, &
   !<                                             1,3, &
   !<                                             1,4],&
   !<                                            [2,4])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: var(:,:,:,:)        !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2,4)            !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R8P_4D

   subroutine alloc_var_R8P_5D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R8P, rank 5).
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:,:,:,:,:)
   !< integer(I4P)           :: ulb(2,5)=reshape([1,1, &
   !<                                             1,2, &
   !<                                             1,3, &
   !<                                             1,4, &
   !<                                             1,5],&
   !<                                            [2,5])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: var(:,:,:,:,:)      !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2,5)            !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R8P_5D

   subroutine alloc_var_R8P_6D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R8P, rank 6).
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:,:,:,:,:,:)
   !< integer(I4P)           :: ulb(2,6)=reshape([1,1, &
   !<                                             1,2, &
   !<                                             1,3, &
   !<                                             1,4, &
   !<                                             1,5, &
   !<                                             1,6],&
   !<                                            [2,6])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: var(:,:,:,:,:,:)    !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2,6)            !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R8P_6D

   subroutine alloc_var_R8P_7D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R8P, rank 6).
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:,:,:,:,:,:,:)
   !< integer(I4P)           :: ulb(2,7)=reshape([1,1, &
   !<                                             1,2, &
   !<                                             1,3, &
   !<                                             1,4, &
   !<                                             1,5, &
   !<                                             1,6, &
   !<                                             1,7],&
   !<                                            [2,7])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: var(:,:,:,:,:,:,:)  !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2,7)            !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6), &
                ulb(1,7):ulb(2,7)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R8P_7D

   ! R4P
   subroutine alloc_var_R4P_1D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R4P, rank 1).
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:)
   !< integer(I4P)           :: ulb(2)=[1,1]
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: var(:)              !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2)              !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1):ulb(2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R4P_1D

   subroutine alloc_var_R4P_2D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R4P, rank 2).
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:,:)
   !< integer(I4P)           :: ulb(2,2)=reshape([1,1, &
   !<                                             1,2],&
   !<                                            [2,2])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: var(:,:)            !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2,2)            !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R4P_2D

   subroutine alloc_var_R4P_3D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R4P, rank 3).
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:,:,:)
   !< integer(I4P)           :: ulb(2,3)=reshape([1,1, &
   !<                                             1,2, &
   !<                                             1,3],&
   !<                                            [2,3])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: var(:,:,:)          !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2,3)            !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R4P_3D

   subroutine alloc_var_R4P_4D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R4P, rank 4).
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:,:,:,:)
   !< integer(I4P)           :: ulb(2,4)=reshape([1,1, &
   !<                                             1,2, &
   !<                                             1,3, &
   !<                                             1,4],&
   !<                                            [2,4])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: var(:,:,:,:)        !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2,4)            !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R4P_4D

   subroutine alloc_var_R4P_5D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R4P, rank 5).
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:,:,:,:,:)
   !< integer(I4P)           :: ulb(2,5)=reshape([1,1, &
   !<                                             1,2, &
   !<                                             1,3, &
   !<                                             1,4, &
   !<                                             1,5],&
   !<                                            [2,5])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: var(:,:,:,:,:)      !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2,5)            !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R4P_5D

   subroutine alloc_var_R4P_6D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R4P, rank 6).
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:,:,:,:,:,:)
   !< integer(I4P)           :: ulb(2,6)=reshape([1,1, &
   !<                                             1,2, &
   !<                                             1,3, &
   !<                                             1,4, &
   !<                                             1,5, &
   !<                                             1,6],&
   !<                                            [2,6])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: var(:,:,:,:,:,:)    !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2,6)            !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R4P_6D

   subroutine alloc_var_R4P_7D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind R4P, rank 6).
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:,:,:,:,:,:,:)
   !< integer(I4P)           :: ulb(2,7)=reshape([1,1, &
   !<                                             1,2, &
   !<                                             1,3, &
   !<                                             1,4, &
   !<                                             1,5, &
   !<                                             1,6, &
   !<                                             1,7],&
   !<                                            [2,7])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: var(:,:,:,:,:,:,:)  !< Varibale to be allocate on CPU.
   integer(I4P),           intent(in)           :: ulb(2,7)            !< Upper/lower bounds of variable.
   integer(I4P),           intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                 :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                    :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                      :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                 :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6), &
                ulb(1,7):ulb(2,7)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_R4P_7D

   ! I8P
   subroutine alloc_var_I8P_1D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I8P, rank 1).
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:)
   !< integer(I4P)              :: ulb(2)=[1,1]
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: var(:)              !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2)              !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1):ulb(2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I8P_1D

   subroutine alloc_var_I8P_2D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I8P, rank 2).
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:,:)
   !< integer(I4P)              :: ulb(2,2)=reshape([1,1, &
   !<                                                1,2],&
   !<                                               [2,2])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: var(:,:)            !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,2)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I8P_2D

   subroutine alloc_var_I8P_3D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I8P, rank 3).
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:,:,:)
   !< integer(I4P)              :: ulb(2,3)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3],&
   !<                                               [2,3])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: var(:,:,:)          !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,3)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I8P_3D

   subroutine alloc_var_I8P_4D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I8P, rank 4).
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:,:,:,:)
   !< integer(I4P)              :: ulb(2,4)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4],&
   !<                                               [2,4])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: var(:,:,:,:)        !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,4)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I8P_4D

   subroutine alloc_var_I8P_5D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I8P, rank 5).
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:,:,:,:,:)
   !< integer(I4P)              :: ulb(2,5)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4, &
   !<                                                1,5],&
   !<                                               [2,5])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: var(:,:,:,:,:)      !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,5)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I8P_5D

   subroutine alloc_var_I8P_6D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I8P, rank 6).
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:,:,:,:,:,:)
   !< integer(I4P)              :: ulb(2,6)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4, &
   !<                                                1,5, &
   !<                                                1,6],&
   !<                                               [2,6])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: var(:,:,:,:,:,:)    !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,6)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I8P_6D

   subroutine alloc_var_I8P_7D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I8P, rank 7).
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:,:,:,:,:,:,:)
   !< integer(I4P)              :: ulb(2,7)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4, &
   !<                                                1,5, &
   !<                                                1,6, &
   !<                                                1,7],&
   !<                                               [2,7])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: var(:,:,:,:,:,:,:)  !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,7)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6), &
                ulb(1,7):ulb(2,7)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I8P_7D

   ! I4P
   subroutine alloc_var_I4P_1D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I4P, rank 1).
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:)
   !< integer(I4P)              :: ulb(2)=[1,1]
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: var(:)              !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2)              !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1):ulb(2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I4P_1D

   subroutine alloc_var_I4P_2D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I4P, rank 2).
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:,:)
   !< integer(I4P)              :: ulb(2,2)=reshape([1,1, &
   !<                                                1,2],&
   !<                                               [2,2])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: var(:,:)            !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,2)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I4P_2D

   subroutine alloc_var_I4P_3D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I4P, rank 3).
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:,:,:)
   !< integer(I4P)              :: ulb(2,3)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3],&
   !<                                               [2,3])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: var(:,:,:)          !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,3)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I4P_3D

   subroutine alloc_var_I4P_4D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I4P, rank 4).
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:,:,:,:)
   !< integer(I4P)              :: ulb(2,4)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4],&
   !<                                               [2,4])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: var(:,:,:,:)        !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,4)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I4P_4D

   subroutine alloc_var_I4P_5D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I4P, rank 5).
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:,:,:,:,:)
   !< integer(I4P)              :: ulb(2,5)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4, &
   !<                                                1,5],&
   !<                                               [2,5])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: var(:,:,:,:,:)      !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,5)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I4P_5D

   subroutine alloc_var_I4P_6D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I4P, rank 6).
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:,:,:,:,:,:)
   !< integer(I4P)              :: ulb(2,6)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4, &
   !<                                                1,5, &
   !<                                                1,6],&
   !<                                               [2,6])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: var(:,:,:,:,:,:)    !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,6)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I4P_6D

   subroutine alloc_var_I4P_7D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I4P, rank 7).
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:,:,:,:,:,:,:)
   !< integer(I4P)              :: ulb(2,7)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4, &
   !<                                                1,5, &
   !<                                                1,6, &
   !<                                                1,7],&
   !<                                               [2,7])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: var(:,:,:,:,:,:,:)  !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,7)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6), &
                ulb(1,7):ulb(2,7)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I4P_7D

   ! I2P
   subroutine alloc_var_I2P_1D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I2P, rank 1).
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:)
   !< integer(I4P)              :: ulb(2)=[1,1]
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: var(:)              !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2)              !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1):ulb(2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I2P_1D

   subroutine alloc_var_I2P_2D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I2P, rank 2).
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:,:)
   !< integer(I4P)              :: ulb(2,2)=reshape([1,1, &
   !<                                                1,2],&
   !<                                               [2,2])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: var(:,:)            !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,2)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I2P_2D

   subroutine alloc_var_I2P_3D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I2P, rank 3).
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:,:,:)
   !< integer(I4P)              :: ulb(2,3)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3],&
   !<                                               [2,3])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: var(:,:,:)          !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,3)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I2P_3D

   subroutine alloc_var_I2P_4D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I2P, rank 4).
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:,:,:,:)
   !< integer(I4P)              :: ulb(2,4)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4],&
   !<                                               [2,4])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: var(:,:,:,:)        !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,4)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I2P_4D

   subroutine alloc_var_I2P_5D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I2P, rank 5).
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:,:,:,:,:)
   !< integer(I4P)              :: ulb(2,5)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4, &
   !<                                                1,5],&
   !<                                               [2,5])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: var(:,:,:,:,:)      !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,5)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I2P_5D

   subroutine alloc_var_I2P_6D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I2P, rank 6).
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:,:,:,:,:,:)
   !< integer(I4P)              :: ulb(2,6)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4, &
   !<                                                1,5, &
   !<                                                1,6],&
   !<                                               [2,6])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: var(:,:,:,:,:,:)    !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,6)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I2P_6D

   subroutine alloc_var_I2P_7D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I2P, rank 7).
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:,:,:,:,:,:,:)
   !< integer(I4P)              :: ulb(2,7)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4, &
   !<                                                1,5, &
   !<                                                1,6, &
   !<                                                1,7],&
   !<                                               [2,7])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: var(:,:,:,:,:,:,:)  !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,7)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6), &
                ulb(1,7):ulb(2,7)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I2P_7D

   ! I1P
   subroutine alloc_var_I1P_1D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I1P, rank 1).
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:)
   !< integer(I4P)              :: ulb(2)=[1,1]
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: var(:)              !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2)              !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1):ulb(2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I1P_1D

   subroutine alloc_var_I1P_2D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I1P, rank 2).
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:,:)
   !< integer(I4P)              :: ulb(2,2)=reshape([1,1, &
   !<                                                1,2],&
   !<                                               [2,2])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: var(:,:)            !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,2)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I1P_2D

   subroutine alloc_var_I1P_3D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I1P, rank 3).
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:,:,:)
   !< integer(I4P)              :: ulb(2,3)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3],&
   !<                                               [2,3])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: var(:,:,:)          !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,3)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I1P_3D

   subroutine alloc_var_I1P_4D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I1P, rank 4).
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:,:,:,:)
   !< integer(I4P)              :: ulb(2,4)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4],&
   !<                                               [2,4])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: var(:,:,:,:)        !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,4)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I1P_4D

   subroutine alloc_var_I1P_5D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I1P, rank 5).
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:,:,:,:,:)
   !< integer(I4P)              :: ulb(2,5)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4, &
   !<                                                1,5],&
   !<                                               [2,5])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: var(:,:,:,:,:)      !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,5)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I1P_5D

   subroutine alloc_var_I1P_6D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I1P, rank 6).
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:,:,:,:,:,:)
   !< integer(I4P)              :: ulb(2,6)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4, &
   !<                                                1,5, &
   !<                                                1,6],&
   !<                                               [2,6])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: var(:,:,:,:,:,:)    !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,6)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I1P_6D

   subroutine alloc_var_I1P_7D(var, ulb, file_unit, msg, verbose)
   !< Allocate CPU variable with memory checking (kind I1P, rank 7).
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:,:,:,:,:,:,:)
   !< integer(I4P)              :: ulb(2,7)=reshape([1,1, &
   !<                                                1,2, &
   !<                                                1,3, &
   !<                                                1,4, &
   !<                                                1,5, &
   !<                                                1,6, &
   !<                                                1,7],&
   !<                                               [2,7])
   !< open(unit=666, file='doctest-mem.log')
   !< call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
   !< close(666, status='delete')
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: var(:,:,:,:,:,:,:)  !< Varibale to be allocate on CPU.
   integer(I4P),              intent(in)           :: ulb(2,7)            !< Upper/lower bounds of variable.
   integer(I4P),              intent(in), optional :: file_unit           !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                 !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose             !< Flag to activate verbose mode.
   integer(I4P)                                    :: file_unit_          !< File unit for verbose output, local var.
   character(:), allocatable                       :: msg_                !< Message to be printed in verbose mode, local var.
   logical                                         :: verbose_            !< Flag to activate verbose mode, local var.
   integer(I8P)                                    :: mem_free, mem_total !< CPU memory.

   file_unit_ = stdout  ; if (present(file_unit)) file_unit_ = file_unit
   msg_       = ''      ; if (present(msg    ))   msg_       = msg
   verbose_   = .false. ; if (present(verbose))   verbose_   = verbose
   if (allocated(var)) deallocate(var)
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory BEFORE allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   allocate(var(ulb(1,1):ulb(2,1), ulb(1,2):ulb(2,2), ulb(1,3):ulb(2,3), ulb(1,4):ulb(2,4), ulb(1,5):ulb(2,5), ulb(1,6):ulb(2,6), &
                ulb(1,7):ulb(2,7)))
   if (verbose_) then
      call get_memory_info(mem_total, mem_free)
      write(file_unit_,'(A)') msg_//'free/total memory AFTER  allocate:'//trim(str([mem_free,mem_total]))//'[bytes]'
   endif
   endsubroutine alloc_var_I1P_7D

   ! assign_allocatable
   ! R16P
   subroutine assign_allocatable_R16P_1D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R16P, rank 1).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:), b(:)
   !< allocate(b(1:1))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: lhs(:)    !< Left hand side of assignement.
   real(R16P), allocatable, intent(in)           :: rhs(:)    !< Right hand side of assignement.
   integer(I4P),            intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),            intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)>0) then
         call allocate_variable(var=lhs, ulb=[lbound(rhs,dim=1),ubound(rhs,dim=1)], file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R16P_1D

   subroutine assign_allocatable_R16P_2D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R16P, rank 2).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:,:), b(:,:)
   !< allocate(b(1:1,1:2))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: lhs(:,:)  !< Left hand side of assignement.
   real(R16P), allocatable, intent(in)           :: rhs(:,:)  !< Right hand side of assignement.
   integer(I4P),            intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),            intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2)],[2,2]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R16P_2D

   subroutine assign_allocatable_R16P_3D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R16P, rank 3).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:,:,:), b(:,:,:)
   !< allocate(b(1:1,1:2,1:3))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: lhs(:,:,:) !< Left hand side of assignement.
   real(R16P), allocatable, intent(in)           :: rhs(:,:,:) !< Right hand side of assignement.
   integer(I4P),            intent(in), optional :: file_unit  !< File unit for verbose output.
   character(*),            intent(in), optional :: msg        !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose    !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3)],[2,3]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R16P_3D

   subroutine assign_allocatable_R16P_4D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R16P, rank 4).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:,:,:,:), b(:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: lhs(:,:,:,:) !< Left hand side of assignement.
   real(R16P), allocatable, intent(in)           :: rhs(:,:,:,:) !< Right hand side of assignement.
   integer(I4P),            intent(in), optional :: file_unit    !< File unit for verbose output.
   character(*),            intent(in), optional :: msg          !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose      !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4)],[2,4]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R16P_4D

   subroutine assign_allocatable_R16P_5D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R16P, rank 5).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: lhs(:,:,:,:,:) !< Left hand side of assignement.
   real(R16P), allocatable, intent(in)           :: rhs(:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),            intent(in), optional :: file_unit      !< File unit for verbose output.
   character(*),            intent(in), optional :: msg            !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose        !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5)],[2,5]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R16P_5D

   subroutine assign_allocatable_R16P_6D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R16P, rank 6).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:) !< Left hand side of assignement.
   real(R16P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),            intent(in), optional :: file_unit        !< File unit for verbose output.
   character(*),            intent(in), optional :: msg              !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose          !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)*size(rhs, dim=6)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6)],[2,6]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R16P_6D

   subroutine assign_allocatable_R16P_7D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R16P, rank 7).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R16P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R16P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:,:) !< Left hand side of assignement.
   real(R16P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),            intent(in), optional :: file_unit          !< File unit for verbose output.
   character(*),            intent(in), optional :: msg                !< Message to be printed in verbose mode.
   logical,                 intent(in), optional :: verbose            !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs,dim=1)*size(rhs,dim=2)*size(rhs,dim=3)*size(rhs,dim=4)*size(rhs,dim=5)*size(rhs,dim=6)*size(rhs,dim=7)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6),         &
                                             lbound(rhs,dim=7),ubound(rhs,dim=7)],[2,7]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R16P_7D

   ! R8P
   subroutine assign_allocatable_R8P_1D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R8P, rank 1).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:), b(:)
   !< allocate(b(1:1))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: lhs(:)    !< Left hand side of assignement.
   real(R8P), allocatable, intent(in)           :: rhs(:)    !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),           intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)>0) then
         call allocate_variable(var=lhs, ulb=[lbound(rhs,dim=1),ubound(rhs,dim=1)], file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R8P_1D

   subroutine assign_allocatable_R8P_2D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R8P, rank 2).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:,:), b(:,:)
   !< allocate(b(1:1,1:2))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: lhs(:,:)  !< Left hand side of assignement.
   real(R8P), allocatable, intent(in)           :: rhs(:,:)  !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),           intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2)],[2,2]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R8P_2D

   subroutine assign_allocatable_R8P_3D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R8P, rank 3).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:,:,:), b(:,:,:)
   !< allocate(b(1:1,1:2,1:3))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: lhs(:,:,:) !< Left hand side of assignement.
   real(R8P), allocatable, intent(in)           :: rhs(:,:,:) !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit  !< File unit for verbose output.
   character(*),           intent(in), optional :: msg        !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose    !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3)],[2,3]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R8P_3D

   subroutine assign_allocatable_R8P_4D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R8P, rank 4).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:,:,:,:), b(:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: lhs(:,:,:,:) !< Left hand side of assignement.
   real(R8P), allocatable, intent(in)           :: rhs(:,:,:,:) !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit    !< File unit for verbose output.
   character(*),           intent(in), optional :: msg          !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose      !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4)],[2,4]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R8P_4D

   subroutine assign_allocatable_R8P_5D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R8P, rank 5).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: lhs(:,:,:,:,:) !< Left hand side of assignement.
   real(R8P), allocatable, intent(in)           :: rhs(:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit      !< File unit for verbose output.
   character(*),           intent(in), optional :: msg            !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose        !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5)],[2,5]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R8P_5D

   subroutine assign_allocatable_R8P_6D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R8P, rank 6).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:) !< Left hand side of assignement.
   real(R8P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit        !< File unit for verbose output.
   character(*),           intent(in), optional :: msg              !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose          !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)*size(rhs, dim=6)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6)],[2,6]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R8P_6D

   subroutine assign_allocatable_R8P_7D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R8P, rank 7).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R8P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:,:) !< Left hand side of assignement.
   real(R8P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit          !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose            !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs,dim=1)*size(rhs,dim=2)*size(rhs,dim=3)*size(rhs,dim=4)*size(rhs,dim=5)*size(rhs,dim=6)*size(rhs,dim=7)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6),         &
                                             lbound(rhs,dim=7),ubound(rhs,dim=7)],[2,7]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R8P_7D

   ! R4P
   subroutine assign_allocatable_R4P_1D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R4P, rank 1).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:), b(:)
   !< allocate(b(1:1))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: lhs(:)    !< Left hand side of assignement.
   real(R4P), allocatable, intent(in)           :: rhs(:)    !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),           intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)>0) then
         call allocate_variable(var=lhs, ulb=[lbound(rhs,dim=1),ubound(rhs,dim=1)], file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R4P_1D

   subroutine assign_allocatable_R4P_2D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R4P, rank 2).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:,:), b(:,:)
   !< allocate(b(1:1,1:2))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: lhs(:,:)  !< Left hand side of assignement.
   real(R4P), allocatable, intent(in)           :: rhs(:,:)  !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),           intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2)],[2,2]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R4P_2D

   subroutine assign_allocatable_R4P_3D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R4P, rank 3).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:,:,:), b(:,:,:)
   !< allocate(b(1:1,1:2,1:3))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: lhs(:,:,:) !< Left hand side of assignement.
   real(R4P), allocatable, intent(in)           :: rhs(:,:,:) !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit  !< File unit for verbose output.
   character(*),           intent(in), optional :: msg        !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose    !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3)],[2,3]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R4P_3D

   subroutine assign_allocatable_R4P_4D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R4P, rank 4).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:,:,:,:), b(:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: lhs(:,:,:,:) !< Left hand side of assignement.
   real(R4P), allocatable, intent(in)           :: rhs(:,:,:,:) !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit    !< File unit for verbose output.
   character(*),           intent(in), optional :: msg          !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose      !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4)],[2,4]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R4P_4D

   subroutine assign_allocatable_R4P_5D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R4P, rank 5).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: lhs(:,:,:,:,:) !< Left hand side of assignement.
   real(R4P), allocatable, intent(in)           :: rhs(:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit      !< File unit for verbose output.
   character(*),           intent(in), optional :: msg            !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose        !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5)],[2,5]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R4P_5D

   subroutine assign_allocatable_R4P_6D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R4P, rank 6).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:) !< Left hand side of assignement.
   real(R4P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit        !< File unit for verbose output.
   character(*),           intent(in), optional :: msg              !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose          !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)*size(rhs, dim=6)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6)],[2,6]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R4P_6D

   subroutine assign_allocatable_R4P_7D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind R4P, rank 7).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< real(R4P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   real(R4P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:,:) !< Left hand side of assignement.
   real(R4P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),           intent(in), optional :: file_unit          !< File unit for verbose output.
   character(*),           intent(in), optional :: msg                !< Message to be printed in verbose mode.
   logical,                intent(in), optional :: verbose            !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs,dim=1)*size(rhs,dim=2)*size(rhs,dim=3)*size(rhs,dim=4)*size(rhs,dim=5)*size(rhs,dim=6)*size(rhs,dim=7)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6),         &
                                             lbound(rhs,dim=7),ubound(rhs,dim=7)],[2,7]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_R4P_7D

   ! I8P
   subroutine assign_allocatable_I8P_1D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I8P, rank 1).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:), b(:)
   !< allocate(b(1:1))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: lhs(:)    !< Left hand side of assignement.
   integer(I8P), allocatable, intent(in)           :: rhs(:)    !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),              intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)>0) then
         call allocate_variable(var=lhs, ulb=[lbound(rhs,dim=1),ubound(rhs,dim=1)], file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I8P_1D

   subroutine assign_allocatable_I8P_2D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I8P, rank 2).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:,:), b(:,:)
   !< allocate(b(1:1,1:2))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: lhs(:,:)  !< Left hand side of assignement.
   integer(I8P), allocatable, intent(in)           :: rhs(:,:)  !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),              intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2)],[2,2]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I8P_2D

   subroutine assign_allocatable_I8P_3D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I8P, rank 3).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:,:,:), b(:,:,:)
   !< allocate(b(1:1,1:2,1:3))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: lhs(:,:,:) !< Left hand side of assignement.
   integer(I8P), allocatable, intent(in)           :: rhs(:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit  !< File unit for verbose output.
   character(*),              intent(in), optional :: msg        !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose    !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3)],[2,3]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I8P_3D

   subroutine assign_allocatable_I8P_4D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I8P, rank 4).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:,:,:,:), b(:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: lhs(:,:,:,:) !< Left hand side of assignement.
   integer(I8P), allocatable, intent(in)           :: rhs(:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit    !< File unit for verbose output.
   character(*),              intent(in), optional :: msg          !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose      !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4)],[2,4]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I8P_4D

   subroutine assign_allocatable_I8P_5D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I8P, rank 5).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: lhs(:,:,:,:,:) !< Left hand side of assignement.
   integer(I8P), allocatable, intent(in)           :: rhs(:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit      !< File unit for verbose output.
   character(*),              intent(in), optional :: msg            !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose        !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5)],[2,5]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I8P_5D

   subroutine assign_allocatable_I8P_6D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I8P, rank 6).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:) !< Left hand side of assignement.
   integer(I8P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit        !< File unit for verbose output.
   character(*),              intent(in), optional :: msg              !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose          !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)*size(rhs, dim=6)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6)],[2,6]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I8P_6D

   subroutine assign_allocatable_I8P_7D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I8P, rank 7).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I8P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I8P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:,:) !< Left hand side of assignement.
   integer(I8P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit          !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose            !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs,dim=1)*size(rhs,dim=2)*size(rhs,dim=3)*size(rhs,dim=4)*size(rhs,dim=5)*size(rhs,dim=6)*size(rhs,dim=7)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6),         &
                                             lbound(rhs,dim=7),ubound(rhs,dim=7)],[2,7]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I8P_7D

   ! I4P
   subroutine assign_allocatable_I4P_1D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I4P, rank 1).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:), b(:)
   !< allocate(b(1:1))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: lhs(:)    !< Left hand side of assignement.
   integer(I4P), allocatable, intent(in)           :: rhs(:)    !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),              intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)>0) then
         call allocate_variable(var=lhs, ulb=[lbound(rhs,dim=1),ubound(rhs,dim=1)], file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I4P_1D

   subroutine assign_allocatable_I4P_2D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I4P, rank 2).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:,:), b(:,:)
   !< allocate(b(1:1,1:2))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: lhs(:,:)  !< Left hand side of assignement.
   integer(I4P), allocatable, intent(in)           :: rhs(:,:)  !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),              intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2)],[2,2]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I4P_2D

   subroutine assign_allocatable_I4P_3D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I4P, rank 3).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:,:,:), b(:,:,:)
   !< allocate(b(1:1,1:2,1:3))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: lhs(:,:,:) !< Left hand side of assignement.
   integer(I4P), allocatable, intent(in)           :: rhs(:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit  !< File unit for verbose output.
   character(*),              intent(in), optional :: msg        !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose    !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3)],[2,3]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I4P_3D

   subroutine assign_allocatable_I4P_4D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I4P, rank 4).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:,:,:,:), b(:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: lhs(:,:,:,:) !< Left hand side of assignement.
   integer(I4P), allocatable, intent(in)           :: rhs(:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit    !< File unit for verbose output.
   character(*),              intent(in), optional :: msg          !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose      !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4)],[2,4]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I4P_4D

   subroutine assign_allocatable_I4P_5D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I4P, rank 5).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: lhs(:,:,:,:,:) !< Left hand side of assignement.
   integer(I4P), allocatable, intent(in)           :: rhs(:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit      !< File unit for verbose output.
   character(*),              intent(in), optional :: msg            !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose        !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5)],[2,5]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I4P_5D

   subroutine assign_allocatable_I4P_6D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I4P, rank 6).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:) !< Left hand side of assignement.
   integer(I4P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit        !< File unit for verbose output.
   character(*),              intent(in), optional :: msg              !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose          !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)*size(rhs, dim=6)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6)],[2,6]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I4P_6D

   subroutine assign_allocatable_I4P_7D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I4P, rank 7).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I4P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I4P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:,:) !< Left hand side of assignement.
   integer(I4P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit          !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose            !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs,dim=1)*size(rhs,dim=2)*size(rhs,dim=3)*size(rhs,dim=4)*size(rhs,dim=5)*size(rhs,dim=6)*size(rhs,dim=7)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6),         &
                                             lbound(rhs,dim=7),ubound(rhs,dim=7)],[2,7]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I4P_7D

   ! I2P
   subroutine assign_allocatable_I2P_1D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I2P, rank 1).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:), b(:)
   !< allocate(b(1:1))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: lhs(:)    !< Left hand side of assignement.
   integer(I2P), allocatable, intent(in)           :: rhs(:)    !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),              intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)>0) then
         call allocate_variable(var=lhs, ulb=[lbound(rhs,dim=1),ubound(rhs,dim=1)], file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I2P_1D

   subroutine assign_allocatable_I2P_2D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I2P, rank 2).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:,:), b(:,:)
   !< allocate(b(1:1,1:2))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: lhs(:,:)  !< Left hand side of assignement.
   integer(I2P), allocatable, intent(in)           :: rhs(:,:)  !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),              intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2)],[2,2]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I2P_2D

   subroutine assign_allocatable_I2P_3D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I2P, rank 3).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:,:,:), b(:,:,:)
   !< allocate(b(1:1,1:2,1:3))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: lhs(:,:,:) !< Left hand side of assignement.
   integer(I2P), allocatable, intent(in)           :: rhs(:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit  !< File unit for verbose output.
   character(*),              intent(in), optional :: msg        !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose    !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3)],[2,3]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I2P_3D

   subroutine assign_allocatable_I2P_4D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I2P, rank 4).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:,:,:,:), b(:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: lhs(:,:,:,:) !< Left hand side of assignement.
   integer(I2P), allocatable, intent(in)           :: rhs(:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit    !< File unit for verbose output.
   character(*),              intent(in), optional :: msg          !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose      !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4)],[2,4]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I2P_4D

   subroutine assign_allocatable_I2P_5D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I2P, rank 5).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: lhs(:,:,:,:,:) !< Left hand side of assignement.
   integer(I2P), allocatable, intent(in)           :: rhs(:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit      !< File unit for verbose output.
   character(*),              intent(in), optional :: msg            !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose        !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5)],[2,5]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I2P_5D

   subroutine assign_allocatable_I2P_6D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I2P, rank 6).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:) !< Left hand side of assignement.
   integer(I2P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit        !< File unit for verbose output.
   character(*),              intent(in), optional :: msg              !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose          !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)*size(rhs, dim=6)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6)],[2,6]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I2P_6D

   subroutine assign_allocatable_I2P_7D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I2P, rank 7).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I2P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I2P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:,:) !< Left hand side of assignement.
   integer(I2P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit          !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose            !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs,dim=1)*size(rhs,dim=2)*size(rhs,dim=3)*size(rhs,dim=4)*size(rhs,dim=5)*size(rhs,dim=6)*size(rhs,dim=7)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6),         &
                                             lbound(rhs,dim=7),ubound(rhs,dim=7)],[2,7]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I2P_7D

   ! I1P
   subroutine assign_allocatable_I1P_1D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I1P, rank 1).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:), b(:)
   !< allocate(b(1:1))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: lhs(:)    !< Left hand side of assignement.
   integer(I1P), allocatable, intent(in)           :: rhs(:)    !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),              intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)>0) then
         call allocate_variable(var=lhs, ulb=[lbound(rhs,dim=1),ubound(rhs,dim=1)], file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I1P_1D

   subroutine assign_allocatable_I1P_2D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I1P, rank 2).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:,:), b(:,:)
   !< allocate(b(1:1,1:2))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: lhs(:,:)  !< Left hand side of assignement.
   integer(I1P), allocatable, intent(in)           :: rhs(:,:)  !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit !< File unit for verbose output.
   character(*),              intent(in), optional :: msg       !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose   !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2)],[2,2]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I1P_2D

   subroutine assign_allocatable_I1P_3D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I1P, rank 3).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:,:,:), b(:,:,:)
   !< allocate(b(1:1,1:2,1:3))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: lhs(:,:,:) !< Left hand side of assignement.
   integer(I1P), allocatable, intent(in)           :: rhs(:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit  !< File unit for verbose output.
   character(*),              intent(in), optional :: msg        !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose    !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3)],[2,3]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I1P_3D

   subroutine assign_allocatable_I1P_4D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I1P, rank 4).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:,:,:,:), b(:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: lhs(:,:,:,:) !< Left hand side of assignement.
   integer(I1P), allocatable, intent(in)           :: rhs(:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit    !< File unit for verbose output.
   character(*),              intent(in), optional :: msg          !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose      !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4)],[2,4]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I1P_4D

   subroutine assign_allocatable_I1P_5D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I1P, rank 5).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: lhs(:,:,:,:,:) !< Left hand side of assignement.
   integer(I1P), allocatable, intent(in)           :: rhs(:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit      !< File unit for verbose output.
   character(*),              intent(in), optional :: msg            !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose        !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5)],[2,5]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I1P_5D

   subroutine assign_allocatable_I1P_6D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I1P, rank 6).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:) !< Left hand side of assignement.
   integer(I1P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit        !< File unit for verbose output.
   character(*),              intent(in), optional :: msg              !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose          !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs, dim=1)*size(rhs, dim=2)*size(rhs, dim=3)*size(rhs, dim=4)*size(rhs, dim=5)*size(rhs, dim=6)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6)],[2,6]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I1P_6D

   subroutine assign_allocatable_I1P_7D(lhs, rhs, file_unit, msg, verbose)
   !< Assign CPU variable with memory checking (kind I1P, rank 7).
   !< Variable is returned not allocated if right hand side is not allocated.
   !<
   !<```fortran
   !< use penf
   !< integer(I1P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
   !< allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
   !< call assign_allocatable(a, b)
   !< print*, allocated(a)
   !<```
   !=> T <<<
   integer(I1P), allocatable, intent(inout)        :: lhs(:,:,:,:,:,:,:) !< Left hand side of assignement.
   integer(I1P), allocatable, intent(in)           :: rhs(:,:,:,:,:,:,:) !< Right hand side of assignement.
   integer(I4P),              intent(in), optional :: file_unit          !< File unit for verbose output.
   character(*),              intent(in), optional :: msg                !< Message to be printed in verbose mode.
   logical,                   intent(in), optional :: verbose            !< Flag to activate verbose mode.

   if (allocated(lhs)) deallocate(lhs)
   if (allocated(rhs)) then
      if (size(rhs,dim=1)*size(rhs,dim=2)*size(rhs,dim=3)*size(rhs,dim=4)*size(rhs,dim=5)*size(rhs,dim=6)*size(rhs,dim=7)>0) then
         call allocate_variable(var=lhs,                                                  &
                                ulb=reshape([lbound(rhs,dim=1),ubound(rhs,dim=1),         &
                                             lbound(rhs,dim=2),ubound(rhs,dim=2),         &
                                             lbound(rhs,dim=3),ubound(rhs,dim=3),         &
                                             lbound(rhs,dim=4),ubound(rhs,dim=4),         &
                                             lbound(rhs,dim=5),ubound(rhs,dim=5),         &
                                             lbound(rhs,dim=6),ubound(rhs,dim=6),         &
                                             lbound(rhs,dim=7),ubound(rhs,dim=7)],[2,7]), &
                                file_unit=file_unit, msg=msg, verbose=verbose)
         lhs = rhs
      endif
   endif
   endsubroutine assign_allocatable_I1P_7D

   ! memory status
   subroutine get_memory_info(mem_free, mem_total)
   !< Get the current CPU-memory status.
   !< @NOTE Currently implemented only per Unix/Linux based systems. Return -1 if failing.
   !<```fortran
   !< use penf
   !< real(R8P), allocatable :: a(:,:,:)
   !< integer(I8P)           :: mem_free_1, mem_free_2, mem_total
   !< logical                :: is_present
   !< integer(I4P)           :: n, i, j, k
   !< call get_memory_info(mem_free_1, mem_total)
   !< inquire(file='/proc/meminfo', exist=is_present)
   !< if (is_present) then
   !<    n = 800
   !<    allocate(a(1:n,1:n,1:n))
   !< else
   !<    print*, .true.
   !<    stop
   !< endif
   !< a = 1._R8P
   !< do k=2, n
   !< do j=2, n
   !< do i=2, n
   !<    a(i,j,k) = 1._R8P / 2._R8P * exp(a(i-1,j,k)) - a(i-1,j,k)
   !< enddo
   !< enddo
   !< enddo
   !< call get_memory_info(mem_free_2, mem_total)
   !< print*, mem_free_1 > mem_free_2
   !<```
   !=> T <<<
   integer(I8P), intent(out) :: mem_free   !< Free memory.
   integer(I8P), intent(out) :: mem_total  !< Total memory.
   logical                   :: is_present !< Logical flag to check the presence of '/proc/meminfo' system file.
   integer(I4P)              :: file_unit  !< File unit.
   character(999)            :: line       !< Line buffer.

   mem_free  = -1_I8P
   mem_total = -1_I8P
   inquire(file='/proc/meminfo', exist=is_present)
   if (is_present) then
      open(newunit=file_unit, file='/proc/meminfo', status='old')
      read(file_unit, '(A)') line ! total memory
      call parse_line(l=line, v=mem_total)
      read(file_unit, '(A)') line ! free memory
      call parse_line(l=line, v=mem_free)
      close(file_unit)
   endif
   contains
      subroutine parse_line(l,v)
      !< Parse input line and return memory value.
      character(*), intent(in)  :: l      !< Input line.
      integer(I8P), intent(out) :: v      !< Memory value.
      integer(I4P)              :: colon  !< Index of colon (name/value separator) char in line.
      character(:), allocatable :: memval !< Memory value, string.

      colon = index(l, ':')                 ! find name/value separator position
      memval = trim(adjustl(l(colon+1:)))   ! get memory value, string
      memval = trim(memval(:len(memval)-2)) ! remove memory unit, e.g. kb
      v = cton(str=memval, knd=1_I8P)       ! cast to string to integer
      endsubroutine parse_line
   endsubroutine get_memory_info

   subroutine save_memory_status(file_name, tag)
   !< Save the current CPU-memory status into a file.
   !< File is accessed in append position.
   character(*), intent(in)           :: file_name           !< File name.
   character(*), intent(in), optional :: tag                 !< Tag of current status.
   character(:), allocatable          :: tag_                !< Tag of current status, local var.
   integer(I8P)                       :: mem_free, mem_total !< Process memory.
   integer(I4P)                       :: file_unit           !< File unit.

   tag_ = '' ; if (present(tag)) tag_ = trim(tag)
   call get_memory_info(mem_free, mem_total)
   open(newunit=file_unit, file=trim(file_name), position="append")
   write(file_unit,*) tag_, mem_free, mem_total
   close(file_unit)
   endsubroutine save_memory_status
endmodule penf_allocatable_memory
