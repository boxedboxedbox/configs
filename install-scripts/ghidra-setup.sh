# Options:
# HAS_ELEVATED: Whether sudo is needed. Optional.
# INSTALL_DIR: Where to install the binary.

die() {
    echo $1
    exit 1
}

if [ -z $HAS_ELEVATED ]; then
    SUDO="sudo"
else
    SUDO=""
fi

echo "Installing ghidra 10.2.2"

$SUDO pacman -Sy jdk17-openjdk

if ! [[ -e "./build" ]]; then
    mkdir build
fi

cd build

mkdir ghidra

cd ghidra

$SUDO pacman -Sy wget unzip

wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.2.2_build/ghidra_10.2.2_PUBLIC_20221115.zip

mv ghidra_10.2.2_PUBLIC_20221115.zip ghidra.zip

unzip ghidra.zip

mv ghidra_10.2.2_PUBLIC ghidra

if ! [[ -d "$INSTALL_DIR" ]]; then
    $SUDO mkdir -p "$INSTALL_DIR"
fi

$SUDO cp -r ghidra "$INSTALL_DIR"  

$SUDO touch /usr/bin/ghidra
echo "$INSTALL_DIR/ghidra/ghidraRun" | $SUDO tee /usr/bin/ghidra

cd ../..

echo "Installation of ghidra was successful!
