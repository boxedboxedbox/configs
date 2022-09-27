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


echo "Installing ripgrep..."

if ! [[ -e "./build" ]]; then
   mkdir build
fi

cd build


git clone https://github.com/BurntSushi/ripgrep.git \
   && echo "Successfully cloned ripgrep!" \
   || die "Error: Failed to clone ripgrep."

cd ripgrep


# Building
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release \
   && echo "Successfully built ripgrep!" \
   || die "Error: Failed to build ripgrep."


"$SUDO" cp "target/release/rg" "$INSTALL_DIR" \
   && echo "Successfully installed ripgrep (binary)!" \
   || die "Error: Failed to install ripgrep (binary)."

cd ..


if [ -z $SAVE_SRC ]; then
   rm -rf ripgrep
fi

cd ..


echo "Installation of ripgrep was successful!"
