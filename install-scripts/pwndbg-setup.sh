if ! [[ -e "./build" ]]; then
    mkdir build
fi

cd build

git clone https://github.com/pwndbg/pwndbg

cd pwndbg

./setup.sh

cd ../..

echo "Installation of pwndbg was successful!"
