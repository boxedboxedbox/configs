# Options:
# HAS_ELEVATED: Whether sudo is needed. Optional.
# DONT_INSTALL_DEPS: Name says it. Optional.
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


echo "Installing Flameshot..."

# Dependencies
if [ -z $DONT_INSTALL_DEPS ]; then
   "$SUDO" pacman -Sy cmake base-devel git qt5-base qt5-tools qt5-svg \
      && echo "Dependencies installed successfully!" \
      || die "Error: Failed to install dependencies for Flameshot."
fi


if ! [[ -e "./build" ]]; then
   mkdir build
fi

cd build


git clone https://github.com/flameshot-org/flameshot.git \
   && echo "Successfully cloned Flameshot!" \
   || die "Error: Failed to clone Flameshot."

cd flameshot


# Building
mkdir build
cd build

cmake ../ \
   && echo "Step 1 of building done!" \
   || die "Error: Failed to build Flameshot (step 1)."

make \
   && echo "Successfully built Flameshot!" \
   || die "Error: Failed to build Flameshot (step 2)."

"$SUDO" cp "src/flameshot" "$INSTALL_DIR" \
   && echo "Successfully installed Flameshot (binary)!" \
   || die "Error: Failed to install Flameshot (binary)."

cd ../..


if [ -z $SAVE_SRC ]; then
   rm -rf flameshot
fi

cd ..


echo "Installation of Flameshot was successful!"
