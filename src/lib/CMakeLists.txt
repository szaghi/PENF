# set type specific output defaults
SET(SRC_PATH "${CMAKE_CURRENT_LIST_DIR}/")
TARGET_SOURCES(
    ${PROJECT_NAME} PRIVATE
    ${SRC_PATH}/penf.F90
    ${SRC_PATH}/penf_b_size.F90
    ${SRC_PATH}/penf_global_parameters_variables.F90
    ${SRC_PATH}/penf_stringify.F90
)

INCLUDE(CheckFortranSourceRuns)

check_fortran_source_runs(
    "program r16p_support;
         integer, parameter :: r16p = selected_real_kind(33, 4931);
         if(r16p < 0) stop 1;
     end program r16p_support"
     R16P_SUPPORTED
     SRC_EXT f90)
if(R16P_SUPPORTED)
    set(r16p_supported "-D_R16P")
endif()

check_fortran_source_runs(
    "program ascii_support;
        integer, parameter :: ascii = selected_char_kind('ascii');
        if(ascii < 0) stop 1;
    end program ascii_support"
    ASCII_SUPPORTED
    SRC_EXT f90
)

IF(ASCII_SUPPORTED)
    SET(ascii_supported "-D_ASCII_SUPPORTED")
ENDIF()

check_fortran_source_runs(
    "program ascii_neq_default;
        integer, parameter :: ascii = selected_char_kind('ascii');
        integer, parameter :: default = selected_char_kind('default');
        if(ascii == default) stop 1;
    end program ascii_neq_default"
    ASCII_NEQ_DEFAULT
    SRC_EXT f90
)

IF(ASCII_NEQ_DEFAULT)
    SET(ascii_neq_default "-D_ASCII_NEQ_DEFAULT")
ENDIF()

check_fortran_source_runs(
    "program ucs4_support;
        integer, parameter :: ucs4 = selected_char_kind('iso_10646');
        if(ucs4 < 0) stop 1;
    end program ucs4_support"
    UCS4_SUPPORTED
    SRC_EXT f90
)

IF(UCS4_SUPPORTED)
    SET(ucs4_supported "-D_UCS4_SUPPORTED")
ENDIF()

LIST( APPEND TARGET_COMPILE_DEF ${ascii_supported} )
LIST( APPEND TARGET_COMPILE_DEF ${ascii_neq_default} )
LIST( APPEND TARGET_COMPILE_DEF ${ucs4_supported} )
LIST( APPEND TARGET_COMPILE_DEF ${r16p_supported} )