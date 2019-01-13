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

function(check_fortran_source_runs code resultVar)
    cmake_parse_arguments(PARSE_ARGV 2 check "" "SRC_EXT" "FAIL_REGEX")
    # message("${code}")
    # message("${check_SRC_EXT}")
    # message("${check_FAIL_REGEX}")
    if(DEFINED call_SRC_EXT)
        set(ext "${check_SRC_EXT}")
    else()
        set(ext "f90")
    endif()
    file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/check_fortran_source_runs.${ext} "${code}")
    try_run(run_result compile_result
        ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/try_run
        ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/check_fortran_source_runs.${ext}
        RUN_OUTPUT_VARIABLE run_output
    )
    # message("compile_result: ${compile_result}")
    if(compile_result)
        # message("run_result: ${run_result}")
        if(DEFINED check_FAIL_REGEX)
            set(tmpVar FALSE)
            foreach(regexp in check_FAIL_REGEXP)
                string(REGEXP MATCH ${regexp} match run_output)
                if(NOT (${match} STREQUAL ""))
                    set(tmpVar TRUE)
                    break()
                endif()
            endforeach()
            set(${resultVar} ${tmpVar} PARENT_SCOPE)
        else()
            if(${run_result} EQUAL 0)
                set(${resultVar} TRUE PARENT_SCOPE)
            else()
                set(${resultVar} FALSE PARENT_SCOPE)
            endif()
        endif()
    else()
        set(${resultVar} FALSE PARENT_SCOPE)
    endif()
endfunction()

if(NOT (DEFINED _R16P_SUPPORTED))
    check_fortran_source_runs("program r16p_support; integer, parameter :: r16p = selected_real_kind(33, 4931) - 16; stop r16p; end program r16p_support" _r16p_supported SRC_EXT f90)
    message(STATUS "Checking wether ${CMAKE_Fortran_COMPILER} supports 16 byte reals -- ${_r16p_supported}")
    set(_R16P_SUPPORTED ${_r16p_supported} CACHE BOOL "Fortran compiler supports 16 byte precision reals")
endif()

target_compile_definitions(${LIB}
    PRIVATE
       $<$<BOOL:${_R16P_SUPPORTED}>:_R16P_SUPPORTED>
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
