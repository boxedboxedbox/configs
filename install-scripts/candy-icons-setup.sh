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


echo "Installing candy-icons..."

cd ../themes

mkdir temp-candy-icons

cd temp-candy-icons

cp ../candy-icons.zip .

unzip candy-icons.zip

"$SUDO" cp -r candy-icons "$INSTALL_DIR" \
   && echo "Successfully installed candy-icons!" \
   || die "Error: Failed to install candy-icons."

cd ..

rm -rf temp-candy-icons

cd install-scripts

echo "Successfully installed candy-icons!"
