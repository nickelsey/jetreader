## get source files for libjetreader
file(GLOB tmp *.cc)
set(JR_SRCS ${JR_SRCS} ${tmp})

## get header files for libjetreader
file(GLOB tmp *.h)
set(JR_HDRS ${JR_HDRS} ${tmp})

## get test source files
file(GLOB tmp *_test.cc)
set(JR_TEST_SRCS ${JR_TEST_SRCS} ${tmp})

## and exclude the test files from libjetreader
if (JR_TEST_SRCS)
list(REMOVE_ITEM JR_SRCS ${JR_TEST_SRCS})
endif(JR_TEST_SRCS)

## get test benchmark files
file(GLOB tmp *_benchmark.cc)
set(JR_BENCH_SRCS ${JR_BENCH_SRCS} ${tmp})

## and exclude the benchmark files from libjetreader
if (JR_BENCH_SRCS)
list(REMOVE_ITEM JR_SRCS ${JR_BENCH_SRCS})
endif(JR_BENCH_SRCS)

## find gtest_main if it exists
file(GLOB tmp *gtest_main*)
set(JR_TEST_MAIN ${JR_TEST_MAIN} ${tmp})

## and exclude gtest_main from libjetreader
if (JR_TEST_MAIN)
list(REMOVE_ITEM JR_SRCS ${JR_TEST_MAIN})
endif(JR_TEST_MAIN)

## install headers
install(FILES ${JR_HDRS} DESTINATION include/jetreader/lib)

## add subdirectories
## none

## export file lists to parent scope
set(JR_SRCS ${JR_SRCS} PARENT_SCOPE)
set(JR_HDRS ${JR_HDRS} PARENT_SCOPE)
set(JR_TEST_SRCS ${JR_TEST_SRCS} PARENT_SCOPE)
set(JR_TEST_MAIN ${JR_TEST_MAIN} PARENT_SCOPE)
set(JR_BENCH_SRCS ${JR_BENCH_SRCS} PARENT_SCOPE)
