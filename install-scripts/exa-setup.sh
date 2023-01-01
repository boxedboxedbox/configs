# Options:
# HAS_ELEVATED: Whether sudo is needed. Optional.
# INSTALL_DIR: Where to install the binary.

die() {
    echo $1
    exit 1
}

if [ -z $HAS_ELEVATED ]; then
    SUDO="sudo"
else
    SUDO=""
fi


echo "Installing exa..."

if ! [[ -e "./build" ]]; then
    mkdir build
fi

cd build


git clone https://github.com/ogham/exa \
    && echo "Successfully cloned exa!" \
    || die "Error: Failed to clone exa."

cd exa


# Building
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release \
    && echo "Successfully built exa!" \
    || die "Error: Failed to build exa."


"$SUDO" cp "target/release/exa" "$INSTALL_DIR" \
    && echo "Successfully installed exa (binary)!" \
    || die "Error: Failed to install exa (binary)."

cd ..

echo "Installation of exa was successful!"
