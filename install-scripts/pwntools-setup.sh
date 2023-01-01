# Options:
# HAS_ELEVATED: Whether sudo is needed. Optional.

if [ -z $HAS_ELEVATED ]; then
    SUDO="sudo"
else
    SUDO=""
fi

$SUDO pacman -Sy python3 git binutils
pip install --upgrade pip pwntools

echo "export PATH=\$PATH:~/.local/bin" >> ~/.bashrc
