# The target of the library PENF is exported
# as PENF::PENF to a package config file for PENF
#
# usage find_package(PENF)
# ...
# target_link_library(<target> PENF)
#
# the config file is generatet in the build and install directories

#################################################################
# HEADER
#################################################################
cmake_minimum_required(VERSION 3.10...3.11)
project(PENF VERSION 1.2.1 LANGUAGES Fortran)

#################################################################
# seach path for additional cmake modules
#################################################################
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake/Modules)

#################################################################
# CONFIGURATION TYPES & BUILD MODE & BUILD_TESTS
#################################################################

#################################################################
# set export variables needed for building
#################################################################

set(TARGETS_EXPORT_NAME "${PROJECT_NAME}-targets")
set(NAMESPACE "${PROJECT_NAME}::")

#################################################################
# generate the library and install instructions
#################################################################

add_subdirectory(src/lib)

#################################################################
# ENABLE TESTING
#################################################################

option(BUILD_TESTING "Build the testing tree." OFF)
if(BUILD_TESTING)
    include(CTest)
    add_subdirectory(src/tests)
endif()

#################################################################
# generate package config files
#################################################################

include(GNUInstallDirs)
set(project_config "${PROJECT_NAME}-config.cmake")
set(cmake_files_dir "${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles")
set(config_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
set(config_build_dir "${CMAKE_CURRENT_BINARY_DIR}/${config_install_dir}")

# export targets for install
install(EXPORT ${TARGETS_EXPORT_NAME}
    NAMESPACE
        ${NAMESPACE}
    DESTINATION
        ${config_install_dir}
    COMPONENT Development
)

# export targets into build
export(EXPORT ${TARGETS_EXPORT_NAME}
    NAMESPACE
        ${NAMESPACE}
    FILE
        ${config_build_dir}/${TARGETS_EXPORT_NAME}.cmake
)

#create package config
include(CMakePackageConfigHelpers)
configure_package_config_file(cmake/${project_config}.in ${cmake_files_dir}/${project_config}
    INSTALL_DESTINATION ${config_install_dir}
)
install(FILES ${cmake_files_dir}/${project_config}
    DESTINATION ${config_install_dir}
)

configure_package_config_file(cmake/${project_config}.in ${config_build_dir}/${project_config}
    INSTALL_DESTINATION ${config_build_dir}
    INSTALL_PREFIX ${CMAKE_CURRENT_BINARY_DIR}
)
