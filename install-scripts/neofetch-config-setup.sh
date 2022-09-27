# Options:
# INSTALL_DIR: Where to install.

die() {
   echo $1
   exit 1
}

echo "Installing neofetch configs..."

cp -r ../configs/neofetch "$INSTALL_DIR" \
   && echo "Successfully installed neofetch configs!"
   || die "Error: Failed to install neofetch configs."

echo "Successfully installed neofetch configs!"
