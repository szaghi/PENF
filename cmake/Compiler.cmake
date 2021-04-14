
# if working Fortran compiler present, enable Fortran before searching for libraries
# include(CheckLanguage)
# check_language(Fortran)
# if(CMAKE_Fortran_COMPILER)
#   enable_language(Fortran)
# endif()

message(STATUS
"Is the Fortran compiler loaded? ${CMAKE_Fortran_COMPILER_LOADED}")

if(CMAKE_Fortran_COMPILER_LOADED)
  message(STATUS "Fortran compiler ID = ${CMAKE_Fortran_COMPILER_ID}")
  message(STATUS "Is the Fortran from GNU? ${CMAKE_COMPILER_IS_GNUFortran}")
  message(STATUS
    "The Fortran compiler version is: ${CMAKE_Fortran_COMPILER_VERSION}")
endif()

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

if(CMAKE_Fortran_COMPILER_ID MATCHES "GNU")
  list(APPEND
    dialect
    "-ffree-form"
    "-std=f2008"
    "-fimplicit-none"
    "-pedantic"
    "-fall-intrinsics"
  )
  set(lang_std "-std=")
  set(ppd "-cpp")
  set(openmp "-fopenmp")
  set(openacc "-fopenacc")
  set(bounds "-fbounds-check")
  set(debug "-g" "-fbacktrace" "-Wextra" "-Wall" )
  set(pic "-fPIC")
  set(opt_level 3)
endif()

if(CMAKE_Fortran_COMPILER_ID MATCHES "Intel")

endif()

if(CMAKE_Fortran_COMPILER_ID MATCHES "PGI")

endif()


list(APPEND FORTRAN_FLAGS
  ${dialect}
  ${ppd}
  ${pic}
)

list(APPEND
  FORTRAN_FLAGS_DEBUG
  ${dialect}
  ${bounds}
  ${debug}
  ${ppd}
  ${pic}
)

list(APPEND
  FORTRAN_FLAGS_RELEASE
  ${dialect}
  "-O${opt_level}"
  ${ppd}
  ${pic}
)

list( APPEND
  FORTRAN_FLAGS_SPARSEKIT
  "-O${opt_level}"
  "${lang_std}legacy"
  ${pic}
  "-fno-trapping-math" "-mtune=native"
)

cmake_print_variables(FORTRAN_FLAGS)
cmake_print_variables(FORTRAN_FLAGS_RELEASE)
cmake_print_variables(FORTRAN_FLAGS_DEBUG)