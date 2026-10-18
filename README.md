# toolchains

Custom LLVM toolchains for Mull.

Each CI run publishes a release tagged with the workflow run id, with these
assets per platform (`Darwin-aarch64`, `Linux-aarch64`, `Linux-x86_64`):

- `<OS>-<ARCH>.toolchain.tar.xz`: the LLVM toolchain (clang, lld,
  compiler-rt, tools), also including `FileCheck`. clang, lld and most LLVM
  tools are symlinks to a single multi-call `bin/llvm` binary. `clang-format`,
  `clang-tidy` and `clangd` are stubs that exit with an error: they're only
  there because toolchains_llvm expects them. There's no libc++, libunwind or
  libLTO, and compiler-rt has no libFuzzer, ORC, XRay or iOS runtimes.
- `<OS>-<ARCH>.filecheck.tar.xz`: just `bin/FileCheck`, for test suites
  that don't need the whole toolchain.

The LLVM revision is set by `LLVM_REF` in `.github/workflows/toolchain.yml`.
