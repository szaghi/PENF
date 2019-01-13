#################################################################
# set type specific output defaults
#################################################################
include(GNUInstallDirs)

SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}")
SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}")
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}")
SET(CMAKE_Fortran_MODULE_DIRECTORY "${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}")

set(LIB PENF)
add_library(${LIB}
    penf.F90
    penf_b_size.F90
    penf_global_parameters_variables.F90
    penf_stringify.F90
)
add_library(${NAMESPACE}::${LIB} ALIAS ${LIB})

target_include_directories(${LIB}
    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_Fortran_MODULE_DIRECTORY}>
)

include(CheckFortranSourceRuns)

check_fortran_source_runs("program r16p_support; integer, parameter :: r16p = selected_real_kind(33, 4931); if(r16p < 0) stop 1; end program r16p_support" _R16P_SUPPORTED SRC_EXT f90)
if(_R16P_SUPPORTED)
    set(_r16p_supported "_R16P_SUPPORTED")
endif()
check_fortran_source_runs("program ascii_support; integer, parameter :: ascii = selected_char_kind('ascii'); if(ascii < 0) stop 1; end program ascii_support" _ASCII_SUPPORTED SRC_EXT f90)
if(_ASCII_SUPPORTED)
    set(_ascii_supported "_ASCII_SUPPORTED")
endif()
check_fortran_source_runs("program ucs4_support; integer, parameter :: ucs4 = selected_char_kind('iso_10646'); if(ucs4 < 0) stop 1; end program ucs4_support" _UCS4_SUPPORTED SRC_EXT f90)
if(_UCS4_SUPPORTED)
    set(_ucs4_supported "_UCS4_SUPPORTED")
endif()

target_compile_definitions(${LIB}
    PRIVATE
        ${_r16p_supported}
        ${_ascii_supported}
        ${_ucs4_supported}
)

set_target_properties(${LIB} PROPERTIES
    VERSION
        ${PROJECT_VERSION}
    SOVERSION
        ${PROJECT_VERSION_MAJOR}
)

# installation and export of targets
install(DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
    COMPONENT Developement
)

install(TARGETS ${LIB} EXPORT ${TARGETS_EXPORT_NAME}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT Development
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT RuntimeLibraries
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR} COMPONENT RuntimeLibraries
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
)
