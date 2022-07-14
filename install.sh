sudo pacman -Sy unzip

echo Installing configuration files...
cp alacritty ~/.config
cp nvim ~/.config
cp .bashrc ~/.bashrc
cp bottom.toml ~/.config

echo Installing fonts, icons and themes...
mkdir temp-asdghitryrytiyuuiawd
cd temp-asdghitryrytiyuuiawd

unzip candy-icons-master.zip
unzip fira-code.zip
unzip Sweet-Dark.zip

sudo mv candy-icons /usr/share/icons
sudo mv fira-code /usr/share/fonts
sudo mv Sweet-Dark /usr/share/themes

rm -rf temp-asdghitryrytiyuuiawd

echo Installation done!
