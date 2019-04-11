## packages are either found or built, depending on if
## they are statically or dynamically linked

set(JR_DEPENDENCY_LIBS "")

## fastjet
find_package(FastJet REQUIRED)
list(APPEND JR_DEPENDENCY_LIBS ${FASTJET_LIBRARIES})

## ROOT
list(APPEND CMAKE_PREFIX_PATH $ENV{ROOTSYS})
find_package(ROOT REQUIRED COMPONENTS MathCore RIO Hist Tree Net)
list(APPEND JR_DEPENDENCY_LIBS ${ROOT_LIBRARIES})
include(${ROOT_USE_FILE})
message(STATUS "Found ROOT")

## StPicoEvent
add_subdirectory(third_party/StPicoEvent)
list(APPEND JR_DEPENDENCY_LIBS ${PICO_LIBS})
JR_include_directories(${PICO_INCLUDE_DIRS})

## gflags
find_package(gflags)
if(GFLAGS_FOUND)
  JR_include_directories(${GFLAGS_INCLUDE_DIRS})
  list(APPEND JR_DEPENDENCY_LIBS ${GFLAGS_LIBRARIES})
else(GFLAGS_FOUND)
  message(FATAL_ERROR "gflags library not found")
endif(GFLAGS_FOUND)

## glog
find_package(glog)
if(GLOG_FOUND)
  set(JR_USE_GLOG 1)
  JR_include_directories(${GLOG_INCLUDE_DIRS})
  list(APPEND JR_DEPENDENCY_LIBS ${GLOG_LIBRARIES})
else(GLOG_FOUND)
  message(FATAL_ERROR "glog library not found")
endif(GLOG_FOUND)

## testing is done via gtest, gmock (currently not used)
## and google benchmark. They are compiled as static libraries
## and embedded in the test binaries
if(BUILD_TEST)
  set(TEMP_BUILD_SHARED_LIBS ${BUILD_SHARED_LIBS})
  set(BUILD_SHARED_LIBS OFF)
  set(BUILD_GTEST ON CACHE BOOL "build core gtest")
  set(INSTALL_GTEST OFF CACHE BOOL "do not install gtest to install directory")
  ## gmock currently not used
  set(BUILD_GMOCK OFF CACHE BOOL "do not build gmock")
  add_subdirectory(${PROJECT_SOURCE_DIR}/third_party/googletest)
  JR_include_directories(${PROJECT_SOURCE_DIR}/third_party/googletest/googletest/include)

  # We will not need to test benchmark lib itself.
  set(BENCHMARK_ENABLE_TESTING OFF CACHE BOOL "Disable benchmark testing.")
  set(BENCHMARK_ENABLE_INSTALL OFF CACHE BOOL "Disable benchmark install to avoid overwriting.")
  add_subdirectory(${PROJECT_SOURCE_DIR}/third_party/benchmark)
  JR_include_directories(${PROJECT_SOURCE_DIR}/third_party/benchmark/include)
  list(APPEND JR_DEPENDENCY_LIBS benchmark)

  # restore the build shared libs option.
  set(BUILD_SHARED_LIBS ${TEMP_BUILD_SHARED_LIBS})
endif()

## set more verbose variable names
set(JR_BUILD_SHARED_LIBS ${BUILD_SHARED_LIBS})
set(JR_BUILD_TEST ${BUILD_TEST})
