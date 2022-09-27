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


echo "Installing tokei..."

if ! [[ -e "./build" ]]; then
   mkdir build
fi

cd build


git clone https://github.com/XAMPPRocky/tokei \
   && echo "Successfully cloned tokei!" \
   || die "Error: Failed to clone tokei."

cd tokei


# Building
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release \
   && echo "Successfully built tokei!" \
   || die "Error: Failed to build tokei."


"$SUDO" cp "target/release/tokei" "$INSTALL_DIR" \
   && echo "Successfully installed tokei (binary)!" \
   || die "Error: Failed to install tokei (binary)."

cd ..


if [ -z $SAVE_SRC ]; then
   rm -rf tokei
fi

cd ..


echo "Installation of tokei was successful!"
