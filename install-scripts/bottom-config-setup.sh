# Options:
# INSTALL_DIR: Where to install.

die() {
   echo $1
   exit 1
}

echo "Installing bottom configs..."

cp -r ../configs/bottom "$INSTALL_DIR" \
   && echo "Successfully installed bottom configs!"
   || die "Error: Failed to install bottom configs."

echo "Successfully installed bottom configs!"
