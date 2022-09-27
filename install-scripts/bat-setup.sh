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


echo "Installing bat..."

if ! [[ -e "./build" ]]; then
   mkdir build
fi

cd build


git clone https://github.com/sharkdp/bat.git \
   && echo "Successfully cloned bat!" \
   || die "Error: Failed to clone bat."

cd bat


# Building
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release \
   && echo "Successfully built bat!" \
   || die "Error: Failed to build bat."


"$SUDO" cp "target/release/bat" "$INSTALL_DIR" \
   && echo "Successfully installed bat (binary)!" \
   || die "Error: Failed to install bat (binary)."

cd ..


if [ -z $SAVE_SRC ]; then
   rm -rf bat
fi

cd ..


echo "Installation of bat was successful!"
