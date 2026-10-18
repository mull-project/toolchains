# Based on clang/cmake/caches/DistributionExample.cmake
# This file sets up a CMakeCache for a simple distribution bootstrap build.

# Enable LLVM projects and runtimes
set(LLVM_ENABLE_PROJECTS "clang;lld" CACHE STRING "")
# Stage1 only needs compiler-rt. On Darwin stage1 tools run with
# DYLD_LIBRARY_PATH pointing at stage1's lib/ (for libLTO), so a stage1 libc++
# there would replace the system one they were linked against.
set(LLVM_ENABLE_RUNTIMES "compiler-rt" CACHE STRING "")
# Passed to stage2 after LLVM_ENABLE_RUNTIMES, so it wins there
set(BOOTSTRAP_LLVM_ENABLE_RUNTIMES "compiler-rt;libcxx;libcxxabi;libunwind" CACHE STRING "")

set(LLVM_INSTALL_TOOLCHAIN_ONLY ON CACHE BOOL "")
set(LLVM_CCACHE_BUILD ON CACHE BOOL "")
set(LLVM_ENABLE_ZSTD OFF CACHE BOOL "")
set(LLVM_ENABLE_ZLIB OFF CACHE BOOL "")
set(LLVM_ENABLE_LIBXML2 OFF CACHE BOOL "")

# Only build the native target in stage1 since it is a throwaway build.
set(LLVM_TARGETS_TO_BUILD Native CACHE STRING "")

# Optimize the stage1 compiler, but don't LTO it because that wastes time.
set(CMAKE_BUILD_TYPE Release CACHE STRING "")

# Setup vendor-specific settings.
set(PACKAGE_VENDOR LLVM.org CACHE STRING "")

# Setting up the stage2 LTO option needs to be done on the stage1 build so that
# the proper LTO library dependencies can be connected.
# ThinLTO rather than full LTO: full LTO links of clang/lld/clangd are too slow
# and memory hungry for GitHub-hosted runners.
set(BOOTSTRAP_LLVM_ENABLE_LTO Thin CACHE STRING "")

if(NOT APPLE)
    # Since LLVM_ENABLE_LTO is ON we need a LTO capable linker
    set(BOOTSTRAP_LLVM_ENABLE_LLD ON CACHE BOOL "")
endif()

# Expose stage2 targets through the stage1 build configuration.
set(CLANG_BOOTSTRAP_TARGETS
    check-all
    check-llvm
    check-clang
    llvm-config
    test-suite
    test-depends
    llvm-test-depends
    clang-test-depends
    distribution
    install-distribution
    install-distribution-stripped
    clang CACHE STRING "")

# Setup the bootstrap build.
set(CLANG_ENABLE_BOOTSTRAP ON CACHE BOOL "")

if(STAGE2_CACHE_FILE)
    set(CLANG_BOOTSTRAP_CMAKE_ARGS
        -C ${STAGE2_CACHE_FILE}
        CACHE STRING "")
else()
    set(CLANG_BOOTSTRAP_CMAKE_ARGS
        -C ${CMAKE_CURRENT_LIST_DIR}/ToolchainCache-stage2.cmake
        CACHE STRING "")
endif()
