# Options:
# INSTALL_DIR: Where to install.

die() {
   echo $1
   exit 1
}

echo "Installing git configs..."

printf "Your username for Git\n>>> "
read GIT_USERNAME

printf "Your email for Git\n>>> "
read GIT_EMAIL

printf "Your GitHub account name\n>>> "
read GITHUB_USERNAME

sed -i "s/\$EMAIL/$GIT_EMAIL/" ../configs/git/.gitconfig
sed -i "s/\$NAME/$GIT_USERNAME/" ../configs/git/.gitconfig
sed -i "s/\$GHNAME/$GITHUB_USERNAME/" ../configs/git/.gitconfig

cp -r ../configs/git "$INSTALL_DIR" \
   && echo "Successfully installed git configs!"
   || die "Error: Failed to install git configs."

echo "Successfully installed git configs!"
