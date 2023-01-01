# Options:
# HAS_ELEVATED: Whether sudo is needed. Optional.
# DONT_INSTALL_DEPS: Name says it. Optional.
# LIBCURL: Build with libcurl. Optional.
# DISABLE_LIBXINERAMA: Don't build with libxinerama. Optional.
# LIBEXIF: Build with libexif. Optional.
# LIBMAGIC: Build with libmagic. Optional.

die() {
    echo $1
    exit 1
}

if [ -z $HAS_ELEVATED ]; then
    SUDO="sudo"
else
    SUDO=""
fi

# Defaults
libcurl=0
libxinerama=1
libexif=0
libmagic=0

echo "Installing feh..."

# Dependencies
if [ -z $DONT_INSTALL_DEPS ]; then
    "$SUDO" pacman -Sy imlib2 libpng libx11 libxt \
        && echo "Dependencies installed successfully!" \
        || die "Error: Failed to install dependencies for feh."
fi

if ! [[ -z $LIBCURL ]]; then
    libcurl=1

    "$SUDO" pacman -S libcurl \
        && echo "libcurl installed successfully!" \
        || die "Error: Failed to install libcurl for feh."
else
    echo "libcurl is disabled."
    libcurl=0
fi

if [ -z $DISABLE_LIBXINERAMA ]; then
    "$SUDO" pacman -S libxinerama \
        && echo "libxinerama installed successfully!" \
        || die "Error: Failed to install libxinerama for feh."
else
    echo "libxinerama is disabled."
    libxinerama=0
fi

if ! [[ -z $LIBEXIF ]]; then
    libexif=1

    "$SUDO" pacman -S libexif-dev libexif12 \
        && echo "libexif installed successfully!" \
        || die "Error: Failed to install libexif for feh."
else
    echo "libexif is disabled."
    libexif=0
fi

if ! [[ -z $MAGIC ]]; then
    libmagic=1

    "$SUDO" pacman -S libmagic \
        && echo "libmagic installed successfully!" \
        || die "Error: Failed to install libmagic for feh."
else
    echo "libmagic is disabled."
    libmagic=0
fi

if ! [[ -e "./build" ]]; then
    mkdir build
fi

cd build

git clone https://github.com/derf/feh.git \
    && echo "Successfully cloned feh!" \
    || die "Error: Failed to clone feh."

cd feh

# Building
make curl="$LIBCURL" exif="$LIBEXIF" xinerama="$LIBXINERAMA" magic="$LIBMAGIC" \
    && echo "Successfully built feh!" \
    || die "Error: Failed to build feh."

"$SUDO" make install app=1 \
    && echo "Successfully installed feh!" \
    || die "Error: Failed to install feh."

cd ..

echo "Installation of was feh successful!"
