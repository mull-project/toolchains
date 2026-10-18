# Based on clang/cmake/caches/DistributionExample-stage2.cmake

set(LLVM_ENABLE_PROJECTS "clang;lld" CACHE STRING "")
set(LLVM_ENABLE_RUNTIMES "compiler-rt;libcxx;libcxxabi;libunwind" CACHE STRING "")

set(LLVM_TARGETS_TO_BUILD Native CACHE STRING "")
set(LLVM_INSTALL_TOOLCHAIN_ONLY ON CACHE BOOL "")
set(LLVM_CCACHE_BUILD ON CACHE BOOL "")
set(LLVM_ENABLE_ZSTD OFF CACHE BOOL "")
set(LLVM_ENABLE_ZLIB OFF CACHE BOOL "")
set(LLVM_ENABLE_LIBXML2 OFF CACHE BOOL "")
set(LLVM_STATIC_LINK_CXX_STDLIB ON CACHE BOOL "")

set(CMAKE_BUILD_TYPE Release CACHE STRING "")

# Build clang, lld and the LLVM tools as a single multi-call `llvm` binary, so
# they share one copy of the LLVM libraries
set(LLVM_TOOL_LLVM_DRIVER_BUILD ON CACHE BOOL "")

if(APPLE)
    set(libtool_darwin llvm-libtool-darwin)
    # toolchains_llvm runs llvm-libtool-darwin as `libtool`; this makes the
    # multi-call binary recognise that name
    set(LLVM_INSTALL_CCTOOLS_SYMLINKS ON CACHE BOOL "")
endif()

# setup toolchain
# clang-format, clang-tidy and clangd are stubbed out at packaging time, see
# .github/workflows/toolchain.yml
set(LLVM_TOOLCHAIN_TOOLS
    ${libtool_darwin}
    llvm-ar
    llvm-dwp
    llvm-nm
    llvm-objcopy
    llvm-objdump
    llvm-profdata
    llvm-ranlib
    llvm-strip
    llvm-symbolizer
    llvm-cov
    # Not added automatically since we set LLVM_TOOLCHAIN_TOOLS ourselves
    llvm-driver

    CACHE STRING "")

# Utilities are only installed with LLVM_INSTALL_UTILS=ON, and in
# toolchain-only mode only if listed in LLVM_TOOLCHAIN_UTILITIES.
set(LLVM_INSTALL_UTILS ON CACHE BOOL "")
set(LLVM_TOOLCHAIN_UTILITIES
    FileCheck
    CACHE STRING "")

set(LLVM_DISTRIBUTION_COMPONENTS
    clang
    LTO
    lld
    clang-resource-headers
    builtins
    runtimes
    ${LLVM_TOOLCHAIN_TOOLS}
    ${LLVM_TOOLCHAIN_UTILITIES}
    CACHE STRING "")
