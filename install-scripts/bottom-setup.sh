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


echo "Installing bottom..."


if ! [[ -e "./build" ]]; then
   mkdir build
fi

cd build


git clone https://github.com/clementtsang/bottom.git \
   && echo "Successfully cloned bottom!" \
   || die "Error: Failed to clone bottom."

cd bottom


# Building
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release \
   && echo "Successfully built bottom!" \
   || die "Error: Failed to build bottom."


"$SUDO" cp "target/release/btm" "$INSTALL_DIR" \
   && echo "Successfully installed bottom (binary)!" \
   || die "Error: Failed to install bottom (binary)."

cd ..

if [ -z $SAVE_SRC ]; then
   rm -rf bottom
fi

cd ..


echo "Installation of bottom was successful!"
