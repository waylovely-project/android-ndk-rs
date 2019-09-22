#!/bin/bash

set -ex

export CC=$NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/clang
export AR=$NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar

# Check formatting
cargo fmt --all -- --check

# Run tests
cargo test --package android-ndk-sys --lib --target=x86_64-unknown-linux-gnu

# Make sure it compiles on each platform
cargo check --package android-ndk --target=arm-linux-androideabi
cargo check --package android-ndk --target=armv7-linux-androideabi
cargo check --package android-ndk --target=aarch64-linux-android
cargo check --package android-ndk --target=i686-linux-android
cargo check --package android-ndk --target=x86_64-linux-android

# Make sure doc tests compile
CC= AR= cargo test --manifest-path android-ndk/Cargo.toml --doc --target=x86_64-unknown-linux-gnu --features rustdoc
