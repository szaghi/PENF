#!/usr/bin/make
MAKEFLAGS = -j 1

#main building variables
DSRC = src

COMPILER = gnu
ifeq "$(COMPILER)" "gnu"
  FC    = gfortran
  OPTSC = -c -frealloc-lhs -std=f2008 -fall-intrinsics -O2 -Dr16p -J $(DMOD)
  OPTSL = -O2 -J $(DMOD)
endif
ifeq "$(COMPILER)" "intel"
  FC    = ifort
  OPTSC = -c -assume realloc_lhs -standard-semantics -std08 -O2 -Dr16p -module $(DMOD)
  OPTSL = -O2 -module $(DMOD)
endif

TESTS = no
ifeq "$(TESTS)" "yes"
  DOBJ = exe/obj/
  DMOD = exe/mod/
  DEXE = exe/
  RULE = .NOTPARALLEL
else
  DOBJ = lib/obj/
  DMOD = lib/mod/
  DEXE = lib/
  RULE = PENF
endif
LIBS    =
VPATH   = $(DSRC) $(DOBJ) $(DMOD)
MKDIRS  = $(DOBJ) $(DMOD) $(DEXE)
LCEXES  = $(shell echo $(EXES) | tr '[:upper:]' '[:lower:]')
EXESPO  = $(addsuffix .o,$(LCEXES))
EXESOBJ = $(addprefix $(DOBJ),$(EXESPO))
MAKELIB = ar -rcs $(DEXE)libpenf.a $(DOBJ)*.o ; ranlib $(DEXE)libpenf.a

#auxiliary variables
COTEXT = "Compile $(<F)"
LITEXT = "Assemble $@"

firstrule: $(RULE)

#building rules
#the library
PENF: $(MKDIRS) $(DOBJ)penf.o
	@echo $(LITEXT)
	@$(MAKELIB)

#tests
.NOTPARALLEL: $(DEXE)TEST_ALL $(DEXE)COMPACT_REAL

$(DEXE)TEST_ALL: $(MKDIRS) $(DOBJ)test_all.o
	@rm -f $(filter-out $(DOBJ)test_all.o,$(EXESOBJ))
	@echo $(LITEXT)
	@$(FC) $(OPTSL) $(DOBJ)*.o $(LIBS) -o $@
EXES := $(EXES) TEST_ALL

$(DEXE)COMPACT_REAL: $(MKDIRS) $(DOBJ)compact_real.o
	@rm -f $(filter-out $(DOBJ)compact_real.o,$(EXESOBJ))
	@echo $(LITEXT)
	@$(FC) $(OPTSL) $(DOBJ)*.o $(LIBS) -o $@
EXES := $(EXES) COMPACT_REAL

#compiling rules
$(DOBJ)penf_b_size.o: src/lib/penf_b_size.F90 \
	$(DOBJ)penf_global_parameters_variables.o
	@echo $(COTEXT)
	@$(FC) $(OPTSC)  $< -o $@

$(DOBJ)penf.o: src/lib/penf.F90 \
	$(DOBJ)penf_global_parameters_variables.o \
	$(DOBJ)penf_b_size.o \
	$(DOBJ)penf_stringify.o
	@echo $(COTEXT)
	@$(FC) $(OPTSC)  $< -o $@

$(DOBJ)penf_stringify.o: src/lib/penf_stringify.F90 \
	$(DOBJ)penf_b_size.o \
	$(DOBJ)penf_global_parameters_variables.o
	@echo $(COTEXT)
	@$(FC) $(OPTSC)  $< -o $@

$(DOBJ)penf_global_parameters_variables.o: src/lib/penf_global_parameters_variables.F90
	@echo $(COTEXT)
	@$(FC) $(OPTSC)  $< -o $@

$(DOBJ)test_all.o: src/tests/test_all.F90 \
	$(DOBJ)penf.o
	@echo $(COTEXT)
	@$(FC) $(OPTSC)  $< -o $@

$(DOBJ)compact_real.o: src/tests/compact_real.f90 \
	$(DOBJ)penf.o
	@echo $(COTEXT)
	@$(FC) $(OPTSC)  $< -o $@

#phony auxiliary rules
.PHONY : $(MKDIRS)
$(MKDIRS):
	@mkdir -p $@
.PHONY : cleanobj
cleanobj:
	@echo deleting objects
	@rm -fr $(DOBJ)
.PHONY : cleanmod
cleanmod:
	@echo deleting mods
	@rm -fr $(DMOD)
.PHONY : cleanexe
cleanexe:
	@echo deleting exes
	@rm -f $(addprefix $(DEXE),$(EXES))
.PHONY : clean
clean: cleanobj cleanmod
.PHONY : cleanall
cleanall: clean cleanexe
