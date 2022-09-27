# Options:
# HAS_ELEVATED: Whether sudo is needed. Optional.
# DONT_INSTALL_DEPS: Name says it. Optional.
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


echo "Installing neovim..."

# Dependencies
if [ -z $DONT_INSTALL_DEPS ]; then
   "$SUDO" pacman -Sy base-devel cmake unzip ninja tree-sitter curl \
      && echo "Dependencies installed successfully!" \
      || die "Error: Failed to install dependencies for neovim."
fi


if ! [[ -e "./build" ]]; then
   mkdir build
fi

cd build


git clone https://github.com/neovim/neovim.git \
   && echo "Successfully cloned neovim!" \
   || die "Error: Failed to clone neovim."

cd neovim


# Building
make CMAKE_BUILD_TYPE=Release \
   && echo "Successfully build neovim!" \
   || die "Error: Failed to build neovim."

"$SUDO" make install \
   && echo "Successfully installed neovim (binary)!" \
   || die "Error: Failed to install neovim (binary)."

cd ..


if [ -z $SAVE_SRC ]; then
   rm -rf neovim
fi

cd ..


echo "Installation of was neovim successful!"
