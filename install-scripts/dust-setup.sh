# Options:
# HAS_ELEVATED: Whether sudo is needed. Optional.
# INSTALL_DIR: Where to install the binary.
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


echo "Installing dust..."

if ! [[ -e "./build" ]]; then
   mkdir build
fi

cd build


git clone https://github.com/bootandy/dust \
   && echo "Successfully cloned dust!" \
   || die "Error: Failed to clone dust."

cd dust


# Building
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release \
   && echo "Successfully built dust!" \
   || die "Error: Failed to build dust."


"$SUDO" cp "target/release/dust" "$INSTALL_DIR" \
   && echo "Successfully installed dust (binary)!" \
   || die "Error: Failed to install dust (binary)."

cd ..


if [ -z $SAVE_SRC ]; then
   rm -rf dust
fi

cd ..


echo "Installation of dust was successful!"
