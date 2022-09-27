# Options:
# HAS_ELEVATED: Whether sudo is needed. Optional.
# INSTALL_DIR: Where to install.

die() {
   echo $1
   exit 1
}

if [ -z $HAS_ELEVATED ]; then
   SUDO="sudo"
else
   SUDO=""
fi


echo "Installing Sweet-Dark theme..."

cd ../themes

mkdir temp-sweet-dark

cd temp-sweet-dark

cp ../Sweet-Dark.zip .

unzip Sweet-Dark.zip

"$SUDO" cp -r Sweet-Dark "$INSTALL_DIR" \
   && echo "Successfully installed Sweet-Dark!"
   || die "Error: Failed to install Sweet-Dark."

cd ..

rm -rf temp-sweet-dark

cd install-scripts

echo "Successfully installed Sweet-Dark theme!"
