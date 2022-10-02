# Options:
# INSTALL_DIR: Where to install.

die() {
   echo $1
   exit 1
}

echo "Installing git configs..."

printf "Your username for Git\n>>> "
read USERNAME

printf "Your email for Git\n>>> "
read EMAIL

printf "Your GitHub account name\n>>> "
read GITHUB_NAME

cp ../configs/git/.gitconfig "$INSTALL_DIR" \
    && echo "Successfully installed .gitconfig!"
    || die "Error: Failed to install .gitconfig."

cp ../configs/git/.gitignore "$INSTALL_DIR" \
    && echo "Successfully installed .gitignore!"
    || die "Error: Failed to install .gitignore."

cp ../configs/git/.gitmessage.txt "$INSTALL_DIR" \
    && echo "Successfully installed .gitmessage.txt!"
    || die "Error: Failed to install .gitmessage.txt"

sed -i "s/EMAIL/$EMAIL/" "$INSTALL_DIR/.gitconfig"
sed -i "s/NAME/$USERNAME/" "$INSTALL_DIR/.gitconfig"
sed -i "s/GHNAME/$GITHUB_NAME/" "$INSTALL_DIR/.gitconfig"

echo "Successfully installed git configs!"
