# Installation

## CMAKE

```make
git clone https://github.com/vickysharma0812/PENF.git
cd PENF
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=${PENF_PREFIX} -S ./ -B ./build
cmake --build ./build --target install
```

- Lets say you want to install PENF at `${HOME}/PENF`, then define the option `CMAKE_INSTALL_PREFIX` by using `-DCMAKE_INSTALL_PREFIX=${HOME}/PENF`
- If you want `DEBUG` version then set `-DCMAKE_BUILD_TYPE=Debug`
- If you want `STATIC` lib then set `-DBUILD_SHARED_LIB=OFF`

You can use it in CMAKE project as shown below.

```cmake
LIST(APPEND CMAKE_PREFIX_PATH "$ENV{EASIFEM_EXTPKGS}")
# LIST(APPEND CMAKE_PREFIX_PATH "$ENV{EASIFEM_EXTPKGS}/share/cmake/")
FIND_PACKAGE( PENF REQUIRED )
IF( PENF_FOUND )
  GET_TARGET_PROPERTY(
    PENF_INCLUDEDIR
    PENF::PENF
    INTERFACE_INCLUDE_DIRECTORIES)
  MESSAGE(STATUS "PENF found")
  MESSAGE(STATUS "PENF_INCLUDEDIR: ${PENF_INCLUDEDIR}")
  MESSAGE(STATUS "PENF_LIBRARIES: ${PENF_LIBRARIES}")
ELSE()
  MESSAGE(STATUS "PENF not found")
ENDIF()

target_link_libraries(
  ${PROJECT_NAME}
  PUBLIC
  PENF::PENF
)

TARGET_INCLUDE_DIRECTORIES(
  ${PROJECT_NAME}
  PUBLIC
  "${PENF_INCLUDEDIR}" )
```