for i in "$@"; do
    case $i in
        --preserve-src=*)
        preserve_src="${i#*=}"
        shift
        ;;
        --install-dir=*)
        install_dir="${i#*=}"
        shift
        ;;
        --openrc=*)
        openrc="${i#*=}"
        shift
        ;;
        -*|--*)
        echo "Unknown option $i"
        exit 1
        ;;
        *)
        ;;
    esac
done 

# todo: automatically install neovim, packer and all the packages

mkdir tools
cd tools

### Software

# Dependencies
echo Installing dependencies...
sudo pacman -Syy cmake base-devel qt5-base qt5-tools qt5-svg unzip ninja tree-sitter

# Other software
echo "Installing software this doesn't build from source."
sudo pacman -S git gcc make keepassxc neofetch fzf curl redshift
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Clone and build
echo Compiling...

# bat
git clone --depth 20 https://github.com/sharkdp/bat.git
cd bat
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release
cd ..

# dust
git clone --depth 20 https://github.com/bootandy/dust.git
cd dust
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release
cd ..

# exa
git clone --depth 20 https://github.com/ogham/exa.git
cd exa
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release
cd ..

# ripgrep
git clone --depth 20 https://github.com/BurntSushi/ripgrep.git
cd ripgrep
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release
cd ..

# hexyl
git clone --depth 20 https://github.com/sharkdp/hexyl.git
cd hexyl
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release
cd ..

# tokei
git clone --depth 20 https://github.com/xampprocky/tokei.git
cd tokei
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release
cd ..

# bottom
git clone --depth 20 https://github.com/clementtsang/bottom.git
cd bottom
RUSTFLAGS="-Ctarget-cpu=native" cargo build --release
cd ..

# flameshot
git clone --depth 20 https://github.com/flameshot-org/flameshot.git
cd flameshot
mkdir build ; cd build
cmake ../
make
cd ../..

# doas/OpenDoas
git clone --depth 20 https://github.com/Duncaen/OpenDoas.git
cd OpenDoas
./configure --without-pam --prefix=/usr/local --datadir=/dev/null --mandir=/dev/null
# trick to disable installation of the man page thingies
sed -i "s/mkdir -p -m 0755 \${DESTDIR}\${MANDIR}/#/g" GNUmakefile
sed -i "s/mkdir -p -m 0755 \${DESTDIR}\${MANDIR}/#/g" GNUmakefile
sed -i "s/cp -f doas.1 \${DESTDIR}\${MANDIR}/#/g" GNUmakefile
sed -i "s/cp -f doas.conf.5 \${DESTDIR}\${MANDIR}/#/g" GNUmakefile
cd ..

# neovim
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=Release
cd ..

# Install

echo "Installing binaries to $install_dir..."

sudo mv bat/target/release/bat $install_dir
sudo mv dust/target/release/dust $install_dir
sudo mv exa/target/release/exa $install_dir
sudo mv ripgrep/target/release/rg $install_dir
sudo mv hexyl/target/release/hexyl $install_dir
sudo mv tokei/target/release/tokei $install_dir
sudo mv bottom/target/release/btm $install_dir
sudo mv flameshot/build/flameshot $install_dir
sudo mv OpenDoas/doas $install_dir
# too bad if you don't want to install neovim to /usr 
cd neovim
sudo make install
cd ..

# Clean up

# echo Removing compile-time dependencies...
# sudo pacman -R cmake qt5-base qt5-tools

if [ $preserve_src -eq "n" ]; then
    echo Removing directories...
    cd ..
    rm -rf tools
else
    echo Removing object files...
    cd bat
    cargo clean
    cd ..
    cd dust
    cargo clean
    cd ..
    cd exa
    cargo clean
    cd ..
    cd ripgrep
    cargo clean
    cd ..
    cd hexyl
    cargo clean
    cd ..
    cd tokei
    cargo clean
    cd ..
    cd flameshot/build
    rm -rf *
    cd ../..
    cd OpenDoas
    make clean
    cd ..
fi
