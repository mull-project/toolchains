# Based on clang/cmake/caches/DistributionExample-stage2.cmake

set(LLVM_ENABLE_PROJECTS "clang;clang-tools-extra;lld" CACHE STRING "")
set(LLVM_ENABLE_RUNTIMES "compiler-rt;libcxx;libcxxabi;libunwind" CACHE STRING "")

set(LLVM_TARGETS_TO_BUILD X86;ARM;AArch64 CACHE STRING "")
set(LLVM_INSTALL_TOOLCHAIN_ONLY ON CACHE BOOL "")
set(LLVM_CCACHE_BUILD ON CACHE BOOL "")
set(LLVM_ENABLE_ZSTD OFF CACHE BOOL "")
set(LLVM_ENABLE_TERMINFO OFF CACHE BOOL "")
set(LLVM_ENABLE_ZLIB OFF CACHE BOOL "")

set(CMAKE_BUILD_TYPE Release CACHE STRING "")

if(APPLE)
    set(libtool_darwin llvm-libtool-darwin)
endif()

# setup toolchain
set(LLVM_INSTALL_TOOLCHAIN_ONLY ON CACHE BOOL "")
set(LLVM_TOOLCHAIN_TOOLS
    ${libtool_darwin}
    clang-format
    clang-tidy
    llvm-ar
    llvm-dwp
    llvm-nm
    llvm-objcopy
    llvm-objdump
    llvm-profdata
    llvm-ranlib
    llvm-strip
    llvm-symbolizer

    CACHE STRING "")

set(LLVM_DISTRIBUTION_COMPONENTS
    clang
    LTO
    lld
    clang-format
    clang-resource-headers
    builtins
    runtimes
    ${LLVM_TOOLCHAIN_TOOLS}
    CACHE STRING "")
