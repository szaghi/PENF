# Memory Management

## Allocatable memory management

`allocate_variable()` allocates arrays with explicit lower/upper bounds and optional logging:

```fortran
use penf

real(R8P), allocatable :: field_1d(:)
real(R8P), allocatable :: field_2d(:,:)
real(R8P), allocatable :: field_3d(:,:,:)

integer(I4P) :: bounds_1d(2)   = [1, 100]
integer(I4P) :: bounds_2d(2,2) = reshape([1,1, 1,200], [2,2])
integer(I4P) :: bounds_3d(2,3) = reshape([1,1, 1,200, 1,300], [2,3])

call allocate_variable(field_1d, bounds_1d)
call allocate_variable(field_2d, bounds_2d)
call allocate_variable(field_3d, bounds_3d)

print *, allocated(field_1d), allocated(field_2d), allocated(field_3d)   ! T T T
```

`assign_allocatable()` safely reallocates and copies an array:

```fortran
use penf

real(R8P), allocatable :: a(:,:), b(:,:)

allocate(b(1:10, 1:20))
b = 0._R8P

call assign_allocatable(a, b)   ! a is allocated and filled from b
print *, allocated(a)           ! T
```

> **Tip:** Pass `file_unit` and `verbose=.true.` to `allocate_variable()` to log every allocation with size and bounds — handy for tracking memory usage in large simulations.
