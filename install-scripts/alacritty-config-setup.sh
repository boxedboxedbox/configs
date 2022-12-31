# Options:
# INSTALL_DIR: Where to install.

die() {
    echo $1
    exit 1
}

echo "Installing Alacritty configs..."

cp -r ../configs/alacritty "$INSTALL_DIR" \
    && echo "Successfully installed Alacritty configs!"
    || die "Error: Failed to install Alacritty configs."

echo "Successfully installed Alacritty configs!"
