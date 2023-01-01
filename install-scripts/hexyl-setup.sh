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


echo "Installing hexyl..."

if ! [[ -e "./build" ]]; then
    mkdir build
fi

cd build


git clone https://github.com/sharkdp/hexyl \
    && echo "Successfully cloned hexyl!" \
    || die "Error: Failed to clone hexyl."

cd hexyl


# Building
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release \
    && echo "Successfully built hexyl!" \
    || die "Error: Failed to build hexyl."


"$SUDO" cp "target/release/hexyl" "$INSTALL_DIR" \
    && echo "Successfully installed hexyl (binary)!" \
    || die "Error: Failed to install hexyl (binary)."

cd ..

echo "Installation of hexyl was successful!"
