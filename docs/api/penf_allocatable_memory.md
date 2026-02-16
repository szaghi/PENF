---
title: penf_allocatable_memory
---

# penf_allocatable_memory

> PENF allocatable memory facility.
 Wrap allocatable arrays routines providing extra information about memory handling.

**Source**: `src/lib/penf_allocatable_memory.F90`

## Interfaces

### allocate_variable

Allocate CPU variable with memory checking.

**Module procedures**: `alloc_var_R8P_1D`, `alloc_var_R8P_2D`, `alloc_var_R8P_3D`, `alloc_var_R8P_4D`, `alloc_var_R8P_5D`, `alloc_var_R8P_6D`, `alloc_var_R8P_7D`, `alloc_var_R4P_1D`, `alloc_var_R4P_2D`, `alloc_var_R4P_3D`, `alloc_var_R4P_4D`, `alloc_var_R4P_5D`, `alloc_var_R4P_6D`, `alloc_var_R4P_7D`, `alloc_var_I8P_1D`, `alloc_var_I8P_2D`, `alloc_var_I8P_3D`, `alloc_var_I8P_4D`, `alloc_var_I8P_5D`, `alloc_var_I8P_6D`, `alloc_var_I8P_7D`, `alloc_var_I4P_1D`, `alloc_var_I4P_2D`, `alloc_var_I4P_3D`, `alloc_var_I4P_4D`, `alloc_var_I4P_5D`, `alloc_var_I4P_6D`, `alloc_var_I4P_7D`, `alloc_var_I2P_1D`, `alloc_var_I2P_2D`, `alloc_var_I2P_3D`, `alloc_var_I2P_4D`, `alloc_var_I2P_5D`, `alloc_var_I2P_6D`, `alloc_var_I2P_7D`, `alloc_var_I1P_1D`, `alloc_var_I1P_2D`, `alloc_var_I1P_3D`, `alloc_var_I1P_4D`, `alloc_var_I1P_5D`, `alloc_var_I1P_6D`, `alloc_var_I1P_7D`

### assign_allocatable

Assign CPU variable with memory checking.

**Module procedures**: `assign_allocatable_R8P_1D`, `assign_allocatable_R8P_2D`, `assign_allocatable_R8P_3D`, `assign_allocatable_R8P_4D`, `assign_allocatable_R8P_5D`, `assign_allocatable_R8P_6D`, `assign_allocatable_R8P_7D`, `assign_allocatable_R4P_1D`, `assign_allocatable_R4P_2D`, `assign_allocatable_R4P_3D`, `assign_allocatable_R4P_4D`, `assign_allocatable_R4P_5D`, `assign_allocatable_R4P_6D`, `assign_allocatable_R4P_7D`, `assign_allocatable_I8P_1D`, `assign_allocatable_I8P_2D`, `assign_allocatable_I8P_3D`, `assign_allocatable_I8P_4D`, `assign_allocatable_I8P_5D`, `assign_allocatable_I8P_6D`, `assign_allocatable_I8P_7D`, `assign_allocatable_I4P_1D`, `assign_allocatable_I4P_2D`, `assign_allocatable_I4P_3D`, `assign_allocatable_I4P_4D`, `assign_allocatable_I4P_5D`, `assign_allocatable_I4P_6D`, `assign_allocatable_I4P_7D`, `assign_allocatable_I2P_1D`, `assign_allocatable_I2P_2D`, `assign_allocatable_I2P_3D`, `assign_allocatable_I2P_4D`, `assign_allocatable_I2P_5D`, `assign_allocatable_I2P_6D`, `assign_allocatable_I2P_7D`, `assign_allocatable_I1P_1D`, `assign_allocatable_I1P_2D`, `assign_allocatable_I1P_3D`, `assign_allocatable_I1P_4D`, `assign_allocatable_I1P_5D`, `assign_allocatable_I1P_6D`, `assign_allocatable_I1P_7D`

## Subroutines

### alloc_var_R16P_1D

Allocate CPU variable with memory checking (kind R16P, rank 1).

```fortran
 use penf
 real(R16P), allocatable :: a(:)
 integer(I4P)            :: ulb(2)=[1,1]
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R16P_1D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R16P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R16P_2D

Allocate CPU variable with memory checking (kind R16P, rank 2).

```fortran
 use penf
 real(R16P), allocatable :: a(:,:)
 integer(I4P)            :: ulb(2,2)=reshape([1,1, &
                                              1,2],&
                                             [2,2])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R16P_2D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R16P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R16P_3D

Allocate CPU variable with memory checking (kind R16P, rank 3).

```fortran
 use penf
 real(R16P), allocatable :: a(:,:,:)
 integer(I4P)            :: ulb(2,3)=reshape([1,1, &
                                              1,2, &
                                              1,3],&
                                             [2,3])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R16P_3D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R16P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R16P_4D

Allocate CPU variable with memory checking (kind R16P, rank 4).

```fortran
 use penf
 real(R16P), allocatable :: a(:,:,:,:)
 integer(I4P)            :: ulb(2,4)=reshape([1,1, &
                                              1,2, &
                                              1,3, &
                                              1,4],&
                                             [2,4])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R16P_4D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R16P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R16P_5D

Allocate CPU variable with memory checking (kind R16P, rank 5).

```fortran
 use penf
 real(R16P), allocatable :: a(:,:,:,:,:)
 integer(I4P)            :: ulb(2,5)=reshape([1,1, &
                                              1,2, &
                                              1,3, &
                                              1,4, &
                                              1,5],&
                                             [2,5])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R16P_5D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R16P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R16P_6D

Allocate CPU variable with memory checking (kind R16P, rank 6).

```fortran
 use penf
 real(R16P), allocatable :: a(:,:,:,:,:,:)
 integer(I4P)            :: ulb(2,6)=reshape([1,1, &
                                              1,2, &
                                              1,3, &
                                              1,4, &
                                              1,5, &
                                              1,6],&
                                             [2,6])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R16P_6D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R16P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R16P_7D

Allocate CPU variable with memory checking (kind R16P, rank 6).

```fortran
 use penf
 real(R16P), allocatable :: a(:,:,:,:,:,:,:)
 integer(I4P)            :: ulb(2,7)=reshape([1,1, &
                                              1,2, &
                                              1,3, &
                                              1,4, &
                                              1,5, &
                                              1,6, &
                                              1,7],&
                                             [2,7])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R16P_7D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R16P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R8P_1D

Allocate CPU variable with memory checking (kind R8P, rank 1).

```fortran
 use penf
 real(R8P), allocatable :: a(:)
 integer(I4P)           :: ulb(2)=[1,1]
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R8P_1D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R8P_2D

Allocate CPU variable with memory checking (kind R8P, rank 2).

```fortran
 use penf
 real(R8P), allocatable :: a(:,:)
 integer(I4P)           :: ulb(2,2)=reshape([1,1, &
                                             1,2],&
                                            [2,2])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R8P_2D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R8P_3D

Allocate CPU variable with memory checking (kind R8P, rank 3).

```fortran
 use penf
 real(R8P), allocatable :: a(:,:,:)
 integer(I4P)           :: ulb(2,3)=reshape([1,1, &
                                             1,2, &
                                             1,3],&
                                            [2,3])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R8P_3D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R8P_4D

Allocate CPU variable with memory checking (kind R8P, rank 4).

```fortran
 use penf
 real(R8P), allocatable :: a(:,:,:,:)
 integer(I4P)           :: ulb(2,4)=reshape([1,1, &
                                             1,2, &
                                             1,3, &
                                             1,4],&
                                            [2,4])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R8P_4D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R8P_5D

Allocate CPU variable with memory checking (kind R8P, rank 5).

```fortran
 use penf
 real(R8P), allocatable :: a(:,:,:,:,:)
 integer(I4P)           :: ulb(2,5)=reshape([1,1, &
                                             1,2, &
                                             1,3, &
                                             1,4, &
                                             1,5],&
                                            [2,5])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R8P_5D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R8P_6D

Allocate CPU variable with memory checking (kind R8P, rank 6).

```fortran
 use penf
 real(R8P), allocatable :: a(:,:,:,:,:,:)
 integer(I4P)           :: ulb(2,6)=reshape([1,1, &
                                             1,2, &
                                             1,3, &
                                             1,4, &
                                             1,5, &
                                             1,6],&
                                            [2,6])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R8P_6D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R8P_7D

Allocate CPU variable with memory checking (kind R8P, rank 6).

```fortran
 use penf
 real(R8P), allocatable :: a(:,:,:,:,:,:,:)
 integer(I4P)           :: ulb(2,7)=reshape([1,1, &
                                             1,2, &
                                             1,3, &
                                             1,4, &
                                             1,5, &
                                             1,6, &
                                             1,7],&
                                            [2,7])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R8P_7D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R4P_1D

Allocate CPU variable with memory checking (kind R4P, rank 1).

```fortran
 use penf
 real(R4P), allocatable :: a(:)
 integer(I4P)           :: ulb(2)=[1,1]
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R4P_1D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R4P_2D

Allocate CPU variable with memory checking (kind R4P, rank 2).

```fortran
 use penf
 real(R4P), allocatable :: a(:,:)
 integer(I4P)           :: ulb(2,2)=reshape([1,1, &
                                             1,2],&
                                            [2,2])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R4P_2D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R4P_3D

Allocate CPU variable with memory checking (kind R4P, rank 3).

```fortran
 use penf
 real(R4P), allocatable :: a(:,:,:)
 integer(I4P)           :: ulb(2,3)=reshape([1,1, &
                                             1,2, &
                                             1,3],&
                                            [2,3])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R4P_3D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R4P_4D

Allocate CPU variable with memory checking (kind R4P, rank 4).

```fortran
 use penf
 real(R4P), allocatable :: a(:,:,:,:)
 integer(I4P)           :: ulb(2,4)=reshape([1,1, &
                                             1,2, &
                                             1,3, &
                                             1,4],&
                                            [2,4])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R4P_4D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R4P_5D

Allocate CPU variable with memory checking (kind R4P, rank 5).

```fortran
 use penf
 real(R4P), allocatable :: a(:,:,:,:,:)
 integer(I4P)           :: ulb(2,5)=reshape([1,1, &
                                             1,2, &
                                             1,3, &
                                             1,4, &
                                             1,5],&
                                            [2,5])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R4P_5D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R4P_6D

Allocate CPU variable with memory checking (kind R4P, rank 6).

```fortran
 use penf
 real(R4P), allocatable :: a(:,:,:,:,:,:)
 integer(I4P)           :: ulb(2,6)=reshape([1,1, &
                                             1,2, &
                                             1,3, &
                                             1,4, &
                                             1,5, &
                                             1,6],&
                                            [2,6])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R4P_6D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_R4P_7D

Allocate CPU variable with memory checking (kind R4P, rank 6).

```fortran
 use penf
 real(R4P), allocatable :: a(:,:,:,:,:,:,:)
 integer(I4P)           :: ulb(2,7)=reshape([1,1, &
                                             1,2, &
                                             1,3, &
                                             1,4, &
                                             1,5, &
                                             1,6, &
                                             1,7],&
                                            [2,7])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_R4P_7D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | real(kind=R4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I8P_1D

Allocate CPU variable with memory checking (kind I8P, rank 1).

```fortran
 use penf
 integer(I8P), allocatable :: a(:)
 integer(I4P)              :: ulb(2)=[1,1]
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I8P_1D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I8P_2D

Allocate CPU variable with memory checking (kind I8P, rank 2).

```fortran
 use penf
 integer(I8P), allocatable :: a(:,:)
 integer(I4P)              :: ulb(2,2)=reshape([1,1, &
                                                1,2],&
                                               [2,2])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I8P_2D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I8P_3D

Allocate CPU variable with memory checking (kind I8P, rank 3).

```fortran
 use penf
 integer(I8P), allocatable :: a(:,:,:)
 integer(I4P)              :: ulb(2,3)=reshape([1,1, &
                                                1,2, &
                                                1,3],&
                                               [2,3])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I8P_3D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I8P_4D

Allocate CPU variable with memory checking (kind I8P, rank 4).

```fortran
 use penf
 integer(I8P), allocatable :: a(:,:,:,:)
 integer(I4P)              :: ulb(2,4)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4],&
                                               [2,4])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I8P_4D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I8P_5D

Allocate CPU variable with memory checking (kind I8P, rank 5).

```fortran
 use penf
 integer(I8P), allocatable :: a(:,:,:,:,:)
 integer(I4P)              :: ulb(2,5)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5],&
                                               [2,5])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I8P_5D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I8P_6D

Allocate CPU variable with memory checking (kind I8P, rank 6).

```fortran
 use penf
 integer(I8P), allocatable :: a(:,:,:,:,:,:)
 integer(I4P)              :: ulb(2,6)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5, &
                                                1,6],&
                                               [2,6])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I8P_6D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I8P_7D

Allocate CPU variable with memory checking (kind I8P, rank 7).

```fortran
 use penf
 integer(I8P), allocatable :: a(:,:,:,:,:,:,:)
 integer(I4P)              :: ulb(2,7)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5, &
                                                1,6, &
                                                1,7],&
                                               [2,7])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I8P_7D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I8P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I4P_1D

Allocate CPU variable with memory checking (kind I4P, rank 1).

```fortran
 use penf
 integer(I4P), allocatable :: a(:)
 integer(I4P)              :: ulb(2)=[1,1]
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I4P_1D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I4P_2D

Allocate CPU variable with memory checking (kind I4P, rank 2).

```fortran
 use penf
 integer(I4P), allocatable :: a(:,:)
 integer(I4P)              :: ulb(2,2)=reshape([1,1, &
                                                1,2],&
                                               [2,2])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I4P_2D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I4P_3D

Allocate CPU variable with memory checking (kind I4P, rank 3).

```fortran
 use penf
 integer(I4P), allocatable :: a(:,:,:)
 integer(I4P)              :: ulb(2,3)=reshape([1,1, &
                                                1,2, &
                                                1,3],&
                                               [2,3])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I4P_3D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I4P_4D

Allocate CPU variable with memory checking (kind I4P, rank 4).

```fortran
 use penf
 integer(I4P), allocatable :: a(:,:,:,:)
 integer(I4P)              :: ulb(2,4)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4],&
                                               [2,4])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I4P_4D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I4P_5D

Allocate CPU variable with memory checking (kind I4P, rank 5).

```fortran
 use penf
 integer(I4P), allocatable :: a(:,:,:,:,:)
 integer(I4P)              :: ulb(2,5)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5],&
                                               [2,5])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I4P_5D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I4P_6D

Allocate CPU variable with memory checking (kind I4P, rank 6).

```fortran
 use penf
 integer(I4P), allocatable :: a(:,:,:,:,:,:)
 integer(I4P)              :: ulb(2,6)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5, &
                                                1,6],&
                                               [2,6])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I4P_6D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I4P_7D

Allocate CPU variable with memory checking (kind I4P, rank 7).

```fortran
 use penf
 integer(I4P), allocatable :: a(:,:,:,:,:,:,:)
 integer(I4P)              :: ulb(2,7)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5, &
                                                1,6, &
                                                1,7],&
                                               [2,7])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I4P_7D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I4P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I2P_1D

Allocate CPU variable with memory checking (kind I2P, rank 1).

```fortran
 use penf
 integer(I2P), allocatable :: a(:)
 integer(I4P)              :: ulb(2)=[1,1]
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I2P_1D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I2P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I2P_2D

Allocate CPU variable with memory checking (kind I2P, rank 2).

```fortran
 use penf
 integer(I2P), allocatable :: a(:,:)
 integer(I4P)              :: ulb(2,2)=reshape([1,1, &
                                                1,2],&
                                               [2,2])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I2P_2D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I2P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I2P_3D

Allocate CPU variable with memory checking (kind I2P, rank 3).

```fortran
 use penf
 integer(I2P), allocatable :: a(:,:,:)
 integer(I4P)              :: ulb(2,3)=reshape([1,1, &
                                                1,2, &
                                                1,3],&
                                               [2,3])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I2P_3D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I2P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I2P_4D

Allocate CPU variable with memory checking (kind I2P, rank 4).

```fortran
 use penf
 integer(I2P), allocatable :: a(:,:,:,:)
 integer(I4P)              :: ulb(2,4)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4],&
                                               [2,4])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I2P_4D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I2P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I2P_5D

Allocate CPU variable with memory checking (kind I2P, rank 5).

```fortran
 use penf
 integer(I2P), allocatable :: a(:,:,:,:,:)
 integer(I4P)              :: ulb(2,5)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5],&
                                               [2,5])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I2P_5D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I2P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I2P_6D

Allocate CPU variable with memory checking (kind I2P, rank 6).

```fortran
 use penf
 integer(I2P), allocatable :: a(:,:,:,:,:,:)
 integer(I4P)              :: ulb(2,6)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5, &
                                                1,6],&
                                               [2,6])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I2P_6D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I2P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I2P_7D

Allocate CPU variable with memory checking (kind I2P, rank 7).

```fortran
 use penf
 integer(I2P), allocatable :: a(:,:,:,:,:,:,:)
 integer(I4P)              :: ulb(2,7)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5, &
                                                1,6, &
                                                1,7],&
                                               [2,7])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I2P_7D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I2P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I1P_1D

Allocate CPU variable with memory checking (kind I1P, rank 1).

```fortran
 use penf
 integer(I1P), allocatable :: a(:)
 integer(I4P)              :: ulb(2)=[1,1]
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I1P_1D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I1P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I1P_2D

Allocate CPU variable with memory checking (kind I1P, rank 2).

```fortran
 use penf
 integer(I1P), allocatable :: a(:,:)
 integer(I4P)              :: ulb(2,2)=reshape([1,1, &
                                                1,2],&
                                               [2,2])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I1P_2D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I1P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I1P_3D

Allocate CPU variable with memory checking (kind I1P, rank 3).

```fortran
 use penf
 integer(I1P), allocatable :: a(:,:,:)
 integer(I4P)              :: ulb(2,3)=reshape([1,1, &
                                                1,2, &
                                                1,3],&
                                               [2,3])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I1P_3D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I1P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I1P_4D

Allocate CPU variable with memory checking (kind I1P, rank 4).

```fortran
 use penf
 integer(I1P), allocatable :: a(:,:,:,:)
 integer(I4P)              :: ulb(2,4)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4],&
                                               [2,4])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I1P_4D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I1P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I1P_5D

Allocate CPU variable with memory checking (kind I1P, rank 5).

```fortran
 use penf
 integer(I1P), allocatable :: a(:,:,:,:,:)
 integer(I4P)              :: ulb(2,5)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5],&
                                               [2,5])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I1P_5D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I1P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I1P_6D

Allocate CPU variable with memory checking (kind I1P, rank 6).

```fortran
 use penf
 integer(I1P), allocatable :: a(:,:,:,:,:,:)
 integer(I4P)              :: ulb(2,6)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5, &
                                                1,6],&
                                               [2,6])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I1P_6D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I1P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### alloc_var_I1P_7D

Allocate CPU variable with memory checking (kind I1P, rank 7).

```fortran
 use penf
 integer(I1P), allocatable :: a(:,:,:,:,:,:,:)
 integer(I4P)              :: ulb(2,7)=reshape([1,1, &
                                                1,2, &
                                                1,3, &
                                                1,4, &
                                                1,5, &
                                                1,6, &
                                                1,7],&
                                               [2,7])
 open(unit=666, file='doctest-mem.log')
 call allocate_variable(a, ulb, file_unit=666, verbose=.true.)
 close(666, status='delete')
 print*, allocated(a)
```

```fortran
subroutine alloc_var_I1P_7D(var, ulb, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `var` | integer(kind=I1P) | inout | allocatable | Varibale to be allocate on CPU. |
| `ulb` | integer(kind=I4P) | in |  | Upper/lower bounds of variable. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R16P_1D

Assign CPU variable with memory checking (kind R16P, rank 1).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R16P), allocatable :: a(:), b(:)
 allocate(b(1:1))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R16P_1D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R16P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R16P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R16P_2D

Assign CPU variable with memory checking (kind R16P, rank 2).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R16P), allocatable :: a(:,:), b(:,:)
 allocate(b(1:1,1:2))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R16P_2D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R16P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R16P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R16P_3D

Assign CPU variable with memory checking (kind R16P, rank 3).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R16P), allocatable :: a(:,:,:), b(:,:,:)
 allocate(b(1:1,1:2,1:3))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R16P_3D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R16P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R16P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R16P_4D

Assign CPU variable with memory checking (kind R16P, rank 4).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R16P), allocatable :: a(:,:,:,:), b(:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R16P_4D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R16P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R16P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R16P_5D

Assign CPU variable with memory checking (kind R16P, rank 5).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R16P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R16P_5D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R16P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R16P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R16P_6D

Assign CPU variable with memory checking (kind R16P, rank 6).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R16P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R16P_6D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R16P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R16P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R16P_7D

Assign CPU variable with memory checking (kind R16P, rank 7).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R16P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R16P_7D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R16P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R16P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R8P_1D

Assign CPU variable with memory checking (kind R8P, rank 1).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R8P), allocatable :: a(:), b(:)
 allocate(b(1:1))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R8P_1D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R8P_2D

Assign CPU variable with memory checking (kind R8P, rank 2).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R8P), allocatable :: a(:,:), b(:,:)
 allocate(b(1:1,1:2))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R8P_2D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R8P_3D

Assign CPU variable with memory checking (kind R8P, rank 3).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R8P), allocatable :: a(:,:,:), b(:,:,:)
 allocate(b(1:1,1:2,1:3))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R8P_3D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R8P_4D

Assign CPU variable with memory checking (kind R8P, rank 4).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R8P), allocatable :: a(:,:,:,:), b(:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R8P_4D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R8P_5D

Assign CPU variable with memory checking (kind R8P, rank 5).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R8P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R8P_5D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R8P_6D

Assign CPU variable with memory checking (kind R8P, rank 6).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R8P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R8P_6D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R8P_7D

Assign CPU variable with memory checking (kind R8P, rank 7).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R8P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R8P_7D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R4P_1D

Assign CPU variable with memory checking (kind R4P, rank 1).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R4P), allocatable :: a(:), b(:)
 allocate(b(1:1))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R4P_1D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R4P_2D

Assign CPU variable with memory checking (kind R4P, rank 2).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R4P), allocatable :: a(:,:), b(:,:)
 allocate(b(1:1,1:2))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R4P_2D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R4P_3D

Assign CPU variable with memory checking (kind R4P, rank 3).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R4P), allocatable :: a(:,:,:), b(:,:,:)
 allocate(b(1:1,1:2,1:3))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R4P_3D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R4P_4D

Assign CPU variable with memory checking (kind R4P, rank 4).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R4P), allocatable :: a(:,:,:,:), b(:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R4P_4D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R4P_5D

Assign CPU variable with memory checking (kind R4P, rank 5).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R4P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R4P_5D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R4P_6D

Assign CPU variable with memory checking (kind R4P, rank 6).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R4P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R4P_6D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_R4P_7D

Assign CPU variable with memory checking (kind R4P, rank 7).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 real(R4P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_R4P_7D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | real(kind=R4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | real(kind=R4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I8P_1D

Assign CPU variable with memory checking (kind I8P, rank 1).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I8P), allocatable :: a(:), b(:)
 allocate(b(1:1))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I8P_1D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I8P_2D

Assign CPU variable with memory checking (kind I8P, rank 2).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I8P), allocatable :: a(:,:), b(:,:)
 allocate(b(1:1,1:2))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I8P_2D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I8P_3D

Assign CPU variable with memory checking (kind I8P, rank 3).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I8P), allocatable :: a(:,:,:), b(:,:,:)
 allocate(b(1:1,1:2,1:3))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I8P_3D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I8P_4D

Assign CPU variable with memory checking (kind I8P, rank 4).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I8P), allocatable :: a(:,:,:,:), b(:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I8P_4D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I8P_5D

Assign CPU variable with memory checking (kind I8P, rank 5).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I8P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I8P_5D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I8P_6D

Assign CPU variable with memory checking (kind I8P, rank 6).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I8P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I8P_6D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I8P_7D

Assign CPU variable with memory checking (kind I8P, rank 7).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I8P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I8P_7D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I8P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I8P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I4P_1D

Assign CPU variable with memory checking (kind I4P, rank 1).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I4P), allocatable :: a(:), b(:)
 allocate(b(1:1))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I4P_1D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I4P_2D

Assign CPU variable with memory checking (kind I4P, rank 2).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I4P), allocatable :: a(:,:), b(:,:)
 allocate(b(1:1,1:2))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I4P_2D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I4P_3D

Assign CPU variable with memory checking (kind I4P, rank 3).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I4P), allocatable :: a(:,:,:), b(:,:,:)
 allocate(b(1:1,1:2,1:3))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I4P_3D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I4P_4D

Assign CPU variable with memory checking (kind I4P, rank 4).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I4P), allocatable :: a(:,:,:,:), b(:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I4P_4D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I4P_5D

Assign CPU variable with memory checking (kind I4P, rank 5).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I4P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I4P_5D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I4P_6D

Assign CPU variable with memory checking (kind I4P, rank 6).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I4P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I4P_6D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I4P_7D

Assign CPU variable with memory checking (kind I4P, rank 7).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I4P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I4P_7D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I4P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I4P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I2P_1D

Assign CPU variable with memory checking (kind I2P, rank 1).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I2P), allocatable :: a(:), b(:)
 allocate(b(1:1))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I2P_1D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I2P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I2P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I2P_2D

Assign CPU variable with memory checking (kind I2P, rank 2).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I2P), allocatable :: a(:,:), b(:,:)
 allocate(b(1:1,1:2))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I2P_2D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I2P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I2P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I2P_3D

Assign CPU variable with memory checking (kind I2P, rank 3).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I2P), allocatable :: a(:,:,:), b(:,:,:)
 allocate(b(1:1,1:2,1:3))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I2P_3D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I2P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I2P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I2P_4D

Assign CPU variable with memory checking (kind I2P, rank 4).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I2P), allocatable :: a(:,:,:,:), b(:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I2P_4D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I2P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I2P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I2P_5D

Assign CPU variable with memory checking (kind I2P, rank 5).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I2P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I2P_5D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I2P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I2P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I2P_6D

Assign CPU variable with memory checking (kind I2P, rank 6).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I2P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I2P_6D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I2P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I2P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I2P_7D

Assign CPU variable with memory checking (kind I2P, rank 7).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I2P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I2P_7D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I2P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I2P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I1P_1D

Assign CPU variable with memory checking (kind I1P, rank 1).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I1P), allocatable :: a(:), b(:)
 allocate(b(1:1))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I1P_1D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I1P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I1P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I1P_2D

Assign CPU variable with memory checking (kind I1P, rank 2).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I1P), allocatable :: a(:,:), b(:,:)
 allocate(b(1:1,1:2))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I1P_2D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I1P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I1P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I1P_3D

Assign CPU variable with memory checking (kind I1P, rank 3).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I1P), allocatable :: a(:,:,:), b(:,:,:)
 allocate(b(1:1,1:2,1:3))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I1P_3D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I1P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I1P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I1P_4D

Assign CPU variable with memory checking (kind I1P, rank 4).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I1P), allocatable :: a(:,:,:,:), b(:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I1P_4D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I1P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I1P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I1P_5D

Assign CPU variable with memory checking (kind I1P, rank 5).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I1P), allocatable :: a(:,:,:,:,:), b(:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I1P_5D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I1P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I1P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I1P_6D

Assign CPU variable with memory checking (kind I1P, rank 6).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I1P), allocatable :: a(:,:,:,:,:,:), b(:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I1P_6D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I1P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I1P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### assign_allocatable_I1P_7D

Assign CPU variable with memory checking (kind I1P, rank 7).
 Variable is returned not allocated if right hand side is not allocated.

```fortran
 use penf
 integer(I1P), allocatable :: a(:,:,:,:,:,:,:), b(:,:,:,:,:,:,:)
 allocate(b(1:1,1:2,1:3,1:4,1:5,1:6,1:7))
 call assign_allocatable(a, b)
 print*, allocated(a)
```

```fortran
subroutine assign_allocatable_I1P_7D(lhs, rhs, file_unit, msg, verbose)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `lhs` | integer(kind=I1P) | inout | allocatable | Left hand side of assignement. |
| `rhs` | integer(kind=I1P) | in | allocatable | Right hand side of assignement. |
| `file_unit` | integer(kind=I4P) | in | optional | File unit for verbose output. |
| `msg` | character(len=*) | in | optional | Message to be printed in verbose mode. |
| `verbose` | logical | in | optional | Flag to activate verbose mode. |

### get_memory_info

Get the current CPU-memory status.
```fortran
 use penf
 real(R8P), allocatable :: a(:,:,:)
 integer(I8P)           :: mem_free_1, mem_free_2, mem_total
 logical                :: is_present
 integer(I4P)           :: n, i, j, k
 call get_memory_info(mem_free_1, mem_total)
 inquire(file='/proc/meminfo', exist=is_present)
 if (is_present) then
    n = 800
    allocate(a(1:n,1:n,1:n))
 else
    print*, .true.
    stop
 endif
 a = 1._R8P
 do k=2, n
 do j=2, n
 do i=2, n
    a(i,j,k) = 1._R8P / 2._R8P * exp(a(i-1,j,k)) - a(i-1,j,k)
 enddo
 enddo
 enddo
 call get_memory_info(mem_free_2, mem_total)
 print*, mem_free_1 > mem_free_2
```

```fortran
subroutine get_memory_info(mem_free, mem_total)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `mem_free` | integer(kind=I8P) | out |  | Free memory. |
| `mem_total` | integer(kind=I8P) | out |  | Total memory. |

### save_memory_status

Save the current CPU-memory status into a file.
 File is accessed in append position.

```fortran
subroutine save_memory_status(file_name, tag)
```

**Arguments**

| Name | Type | Intent | Attributes | Description |
|------|------|--------|------------|-------------|
| `file_name` | character(len=*) | in |  | File name. |
| `tag` | character(len=*) | in | optional | Tag of current status. |
