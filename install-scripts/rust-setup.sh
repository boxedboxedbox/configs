# Options:
# INSTALL_DIR: Where to install.

die() {
   echo $1
   exit 1
}

echo "Installing Rust..."

curl --proto "'=https'" --tlsv1.2 -sSf https://sh.rustup.rs | sh

cp ../other/cargo_completions "$INSTALL_DIR" \
   && echo "Successfully installed Rust!"
   || die "Error: Failed to install Rust."

echo "Successfully installed Rust!"
