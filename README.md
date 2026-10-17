# toolchains

Custom LLVM toolchains for Mull.

Each CI run publishes a release tagged with the workflow run id, with these
assets per platform (`Darwin-aarch64`, `Linux-aarch64`, `Linux-x86_64`):

- `<OS>-<ARCH>.toolchain.tar.{gz,xz}`: the LLVM toolchain (clang, lld,
  runtimes, tools), also including `FileCheck`.
- `<OS>-<ARCH>.filecheck.tar.{gz,xz}`: just `bin/FileCheck`, for test suites
  that don't need the whole toolchain.

The LLVM revision is set by `LLVM_REF` in `.github/workflows/toolchain.yml`.
