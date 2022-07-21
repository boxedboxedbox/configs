sudo pacman -Sy unzip

echo Configuring Git...
printf "Your username for Git\n>>> "
read GIT_USERNAME
printf "Your email for Git\n>>> "
read GIT_EMAIL
printf "Your GitHub account name\n>>> "
read GITHUB_USERNAME

sed -i "s/\$EMAIL/$GIT_EMAIL/" git/.gitconfig
sed -i "s/\$NAME/$GIT_USERNAME/" git/.gitconfig
sed -i "s/\$GHNAME/$GITHUB_USERNAME/" git/.gitconfig

echo Installing configuration files...
cp -r alacritty ~/.config
cp -r nvim ~/.config
cp .bashrc ~/.bashrc
cp -r bottom ~/.config
cp -r neofetch ~/.config
cp git/.gitconfig ~
cp git/.gitignore ~

echo Installing fonts, icons and themes...
mkdir temp-asdghitryrytiyuuiawd
cd temp-asdghitryrytiyuuiawd

unzip candy-icons-master.zip
unzip fira-code.zip
unzip Sweet-Dark.zip
unzip bbxfwm.zip

sudo mv candy-icons /usr/share/icons
sudo mv fira-code /usr/share/fonts
sudo mv Sweet-Dark /usr/share/themes
sudo mv boxedboxedxfwm /usr/share/themes

rm -rf temp-asdghitryrytiyuuiawd

echo Installation done!
