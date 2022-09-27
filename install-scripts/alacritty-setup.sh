# Options:
# HAS_ELEVATED: Whether sudo is needed. Optional.
# DONT_INSTALL_DEPS: Name says it. Optional.
# WAYLAND: Build with support for wayland. Optional.
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


echo "Installing Alacritty..."

# Dependencies
if [ -z $DONT_INSTALL_DEPS ]; then
   "$SUDO" pacman -Sy cmake freetype2 fontconfig pkg-config make libxcb libxkbcommon python \
      && echo "Dependencies installed successfully!" \
      || die "Error: Failed to install dependencies for Alacritty."
fi


if ! [[ -e "./build" ]]; then
   mkdir build
fi

cd build


git clone https://github.com/alacritty/alacritty.git \
   && echo "Successfully cloned Alacritty!" \
   || die "Error: Failed to clone Alacrity."

cd alacritty


# Building
if [ -z $WAYLAND ]; then
   # Force support for only X11
   RUSTFLAGS="-Ctarget-cpu=native" cargo build --release --no-default-features --features=x11 \
      && echo "Successfully built Alacritty!" \
      || die "Error: Failed to build Alacritty."
else
   # Force support for only Wayland
   RUSTFLAGS="-Ctarget-cpu=native" cargo build --release --no-default-features --features=wayland \
      && echo "Successfully built Alacritty!" \
      || die "Error: Failed to build Alacritty."
fi


"$SUDO" cp "target/release/alacritty" "$INSTALL_DIR" \
   && echo "Successfully installed Alacritty (binary)!" \
   || die "Error: Failed to install Alacritty (binary)."

cd ..


if [ -z $SAVE_SRC ]; then
   rm -rf alacritty
fi

cd ..


echo "Installation of Alacritty was successful!"
