cmake_minimum_required(VERSION 2.8.12 FATAL_ERROR)
cmake_policy(SET CMP0042 NEW)
cmake_policy(SET CMP0048 NEW) ## version defined in project()

## policy 0077 is not supported by older cmake versions, but may cause 
## problems without it, so I am leaving it here for now
##cmake_policy(SET CMP0077 NEW)

## project title and version
project(jetreader
        VERSION 0.1.0)

set(CMAKE_BUILD_TYPE RELEASE)

## build options
option(BUILD_SHARED_LIBS "Build libjetreader.so" ON)
option(BUILD_TESTS "Build test suite binaries" OFF)
option(BUILD_EXAMPLES "Build example binaries" ON)

## build options
set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O2 -fPIC")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-narrowing")

## this is needed for StPicoDst compilation
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_VANILLA_ROOT_")

## compiler & system checks
include(cmake/SysCheck.cmake)

## add module path to cmake
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/Modules)

## helper functions
include(cmake/Utils.cmake)

## dependencies
include(cmake/Dependencies.cmake)

## forcing proper include lookup paths - must take
## configured files in build dir before empty files
## in the source dir
include_directories(BEFORE ${PROJECT_SOURCE_DIR})

## finally, add the source tree
add_subdirectory(jetreader)

## add an uninstall option, since cmake does not provide
## one by default
if(NOT TARGET uninstall)
   configure_file(
      ${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in
      ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake
      IMMEDIATE @ONLY)

   add_custom_target(uninstall
      COMMAND ${CMAKE_COMMAND} -P
      ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)
endif()
