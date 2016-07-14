#################################################################
# TESTS
#################################################################

FILE(GLOB_RECURSE TESTS_SRC *.f90 *.F90)
SET(TESTS_SRC ${TESTS_SRC} PARENT_SCOPE)

#################################################################
# EXTERNAL LIBRARIES
#################################################################

FOREACH(TEST_SRC ${TESTS_SRC})
    GET_FILENAME_COMPONENT(EXE_NAME ${TEST_SRC} NAME_WE)
    ADD_EXECUTABLE(${EXE_NAME} ${TEST_SRC})
    TARGET_LINK_LIBRARIES(${EXE_NAME} ${LIB})
    FOREACH (EXT_LIB ${EXT_LIBS})
        IF(DEFINED ${PROJECT_NAME}_ENABLE_${EXT_LIB} AND ${PROJECT_NAME}_ENABLE_${EXT_LIB} AND ${EXT_LIB}_FOUND)
            TARGET_LINK_LIBRARIES(${EXE_NAME} ${${EXT_LIB}_LIBRARIES})
        ENDIF()
    ENDFOREACH()

    IF(${PROJECT_NAME}_ENABLE_MPI)
        TARGET_LINK_LIBRARIES(${EXE_NAME} ${MPI_Fortran_LIBRARIES})
    ENDIF()

    IF(${PROJECT_NAME}_ENABLE_HDF5)
        TARGET_LINK_LIBRARIES(${EXE_NAME} ${HDF5_Fortran_HL_LIBRARIES})
        TARGET_LINK_LIBRARIES(${EXE_NAME} ${HDF5_HL_LIBRARIES})
        TARGET_LINK_LIBRARIES(${EXE_NAME} ${HDF5_Fortran_LIBRARIES})
        TARGET_LINK_LIBRARIES(${EXE_NAME} ${HDF5_LIBRARIES})
    ENDIF()

    ADD_TEST(${EXE_NAME}_TEST ${EXECUTABLE_OUTPUT_PATH}/${EXE_NAME})
ENDFOREACH()



