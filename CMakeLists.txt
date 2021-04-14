# This file is a part of easifem-base
# (c) 2021, all right reserved, Dr Vikas Sharma
#
# log
# 17/02/2021 this file was created
#-----------------------------------------------------------------------

cmake_minimum_required(VERSION 3.10.0 FATAL_ERROR)
set(PROJECT_NAME "PENF")
project(${PROJECT_NAME})
enable_language(Fortran)
set(VERSION_MAJOR "1")
set(VERSION_MINOR "2")
set(VERSION_BugFix "1")
set(PROJECT_VERSION ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_BugFix})
set(TARGETS_EXPORT_NAME "${PROJECT_NAME}Targets")
set(namespace "${PROJECT_NAME}")

include(CMakePrintHelpers)
include(FortranCInterface)
FortranCInterface_VERIFY()

# SYSTEM INFORMATION
# Disable in-source builds to prevent source tree corruption.
if(" ${CMAKE_CURRENT_SOURCE_DIR}" STREQUAL " ${CMAKE_CURRENT_BINARY_DIR}")
  message(FATAL_ERROR "
    FATAL: In-source builds are not allowed.
    You should create a separate directory for build files.")
endif()

# CREATING DIRECTORIES FOR EASIFEM_BASE
include( GNUInstallDirs )
set(
  CMAKE_Fortran_MODULE_DIRECTORY
  ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}
)
set(
  CMAKE_LIBRARY_OUTPUT_DIRECTORY
  ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}
)
set(
  CMAKE_ARCHIVE_OUTPUT_DIRECTORY
  ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}
)
set(
  CMAKE_RUNTIME_OUTPUT_DIRECTORY
  ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}
)

set(
  INSTALL_LIBDIR
  ${CMAKE_INSTALL_LIBDIR}
  CACHE PATH "install location of lib"
)
set(
  INSTALL_INCLUDEDIR
  ${CMAKE_INSTALL_INCLUDEDIR}
  CACHE PATH "install location of include"
)
set(
  INSTALL_BINDIR
  ${CMAKE_INSTALL_BINDIR}
  CACHE PATH "install location of bin"
)

if(WIN32 AND NOT CYGWIN)
  set(DEF_INSTALL_CMAKEDIR CMake)
else()
  set(DEF_INSTALL_CMAKEDIR share/cmake/${PROJECT_NAME})
endif()
set(INSTALL_CMAKEDIR ${DEF_INSTALL_CMAKEDIR} CACHE PATH "Installation directory for CMake files")

foreach(p LIB BIN INCLUDE CMAKE)
  file(TO_NATIVE_PATH ${CMAKE_INSTALL_PREFIX}/${INSTALL_${p}DIR} _path)
  message(STATUS "Installing ${p} componenets to ${_path}")
endforeach()

option(BUILD_SHARED_LIBS "Build shared library" ON)
if (BUILD_SHARED_LIBS)
  message(STATUS "${PROJECT_NAME} will be built as a shared library.")
else()
  message(STATUS "${PROJECT_NAME} will be built as a static library.")
endif()

# INSTALLING easifemBase
if(BUILD_SHARED_LIBS)
  add_library(${PROJECT_NAME} SHARED "" )
else()
  add_library(${PROJECT_NAME} STATIC "")
endif()

# COMPILER RELATED OPTIONS
include(${PROJECT_SOURCE_DIR}/cmake/Compiler.cmake)

if( $<CONFIG:Debug> )
  list( APPEND TARGET_COMPILE_DEF "-DDEBUG_VER" )
endif()

###########################################
INCLUDE(src/lib/CMakeLists.txt)
###########################################

MESSAGE(STATUS "TARGET_COMPILE_DEF: ${TARGET_COMPILE_DEF}")
target_compile_options(
  ${PROJECT_NAME}
  PRIVATE
  ${TARGET_COMPILE_OPT}
  ${FORTRAN_FLAGS}
  "$<$<CONFIG:Debug>:${FORTRAN_FLAGS_DEBUG}>"
  "$<$<CONFIG:Release>:${FORTRAN_FLAGS_RELEASE}>"
)

target_compile_definitions(
  ${PROJECT_NAME}
  PUBLIC
  ${TARGET_COMPILE_DEF}
)

# target_link_libraries(
#   ${PROJECT_NAME}
#   PUBLIC
# )

# target_compile_definitions()
SET_TARGET_PROPERTIES(
  ${PROJECT_NAME}
    PROPERTIES
    POSITION_INDEPENDENT_CODE 1
    SOVERSION ${VERSION_MAJOR}
    OUTPUT_NAME ${PROJECT_NAME}
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}
    ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    MACOSX_RPATH ON
    WINDOWS_EXPORT_ALL_SYMBOLS ON
)

TARGET_INCLUDE_DIRECTORIES(
  ${PROJECT_NAME}
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_Fortran_MODULE_DIRECTORY}>
  $<INSTALL_INTERFACE:${INSTALL_INCLUDEDIR}>
)

INSTALL(
  TARGETS
    ${PROJECT_NAME}
  EXPORT
    ${TARGETS_EXPORT_NAME}
  ARCHIVE
    DESTINATION ${INSTALL_LIBDIR}
    COMPONENT lib
  RUNTIME
    DESTINATION ${INSTALL_BINDIR}
    COMPONENT bin
  LIBRARY
    DESTINATION ${INSTALL_LIBDIR}
    COMPONENT lib
)

install(
  DIRECTORY
    ${CMAKE_Fortran_MODULE_DIRECTORY}
    DESTINATION "./"
    COMPONENT lib
)

install(
  EXPORT
    ${TARGETS_EXPORT_NAME}
    NAMESPACE ${namespace}::
    DESTINATION ${INSTALL_CMAKEDIR}
    COMPONENT dev
)

include(CMakePackageConfigHelpers)

configure_package_config_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
  INSTALL_DESTINATION ${INSTALL_CMAKEDIR}
)
if(BUILD_SHARED_LIBS OR PROJECT_VERSION_MAJOR EQUAL 0)
  # Due to the uncertain ABI compatibility of Fortran shared libraries
  # limit compatibility for dynamic linking to same minor version.
  set(COMPATIBILITY AnyNewerVersion)
  # set(COMPATIBILITY SameMinorVersion)
else()
  # Require API compatibility via semantic versioning for static linking.
  set(COMPATIBILITY AnyNewerVersion)
  # set(COMPATIBILITY SameMajorVersion)
endif()

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  VERSION "${PROJECT_VERSION}"
  COMPATIBILITY ${COMPATIBILITY}
)

install(
  FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
  DESTINATION
    ${INSTALL_CMAKEDIR}
)
