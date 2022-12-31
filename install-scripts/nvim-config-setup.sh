# Options:
# INSTALL_DIR: Where to install.

die() {
    echo $1
    exit 1
}

echo "Installing neovim configs..."

cp -r ../configs/nvim "$INSTALL_DIR" \
    && echo "Successfully installed neovim configs!" \
    || die "Error: Failed to install neovim configs."

echo "Successfully installed neovim configs!"
