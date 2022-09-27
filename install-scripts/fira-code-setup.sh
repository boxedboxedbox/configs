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


echo "Installing fira-code..."

cd ../themes

mkdir temp-fira-code

cd temp-fira-code

cp ../fira-code.zip .

unzip fira-code.zip

"$SUDO" cp -r fira-code "$INSTALL_DIR" \
   && echo "Successfully installed fira-code!"
   || die "Error: Failed to install fira-code."

cd ..

rm -rf temp-fira-code

cd install-scripts

echo "Successfully installed fira-code!"
