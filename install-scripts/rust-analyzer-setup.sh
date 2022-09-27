# Options:
# HAS_ELEVATED: Whether sudo is needed. Optional.
# INSTALL_DIR: Where to install.
# SAVE_SRC: Whether to save the source. Optional.

die() {
    echo $1
    exit 1
}

if [ -z $HAS_ELEVATED ]; then
    SUDO="sudo"
else
    SUDO=""
fi

echo "Installing rust-analyzer..."

if ! [[ -e "./build" ]]; then
    mkdir build
fi

cd build

git clone https://github.com/rust-lang/rust-analyzer.git \
    && echo "Successfully cloned rust-analyzer!" \
    || die "Error: Failed to clone Alacrity."

cd rust-analyzer

# Building
cargo xtask install --server \
    && echo "Successfully built rust-analyzer!" \
    || die "Error: Failed to build rust-analyzer."


"$SUDO" cp target/release/rust-analyzer "$INSTALL_DIR" \
    && echo "Successfully installed rust-analyzer (binary)!" \
    || die "Error: Failed to install rust-analyzer (binary)."

cd ..

if [ -z $SAVE_SRC ]; then
    rm -rf rust-analyzer
fi

cd ..

echo "Installation of rust-analyzer was successful!"
