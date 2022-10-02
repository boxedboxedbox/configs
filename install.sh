# Comment/uncomment parts of this file to customize installation.
#
# Note: different install script take different parameters.
# Read the setup script before installation for maximum customization.
# Leaving an option empty = option is disabled, writing anything (literally) = option is enabled.
# Example: PARAM="" is disabled, PARAM="dwadawdaw" or PARAM="yes" is enabled. 
#
# Note: Even if run with elevated privileges, some installers still might need user interaction.

if [ "$EUID" -ne 0 ]; then
   HE=""
else
   HE="yes"
fi

cd install-scripts

# Software
#INSTALL_DIR="/usr/bin" HAS_ELEVATED="$HE" WAYLAND="" ./alacritty-setup.sh
#INSTALL_DIR="/usr/bin" HAS_ELEVATED="$HE" ./bat-setup.sh
#INSTALL_DIR="/usr/bin" HAS_ELEVATED="$HE" ./bottom-setup.sh
#INSTALL_DIR="/usr/bin" HAS_ELEVATED="$HE" ./dust-setup.sh
#INSTALL_DIR="/usr/bin" HAS_ELEVATED="$HE" ./exa-setup.sh
#INSTALL_DIR="/usr/bin" HAS_ELEVATED="$HE" ./flameshot-setup.sh
#INSTALL_DIR="/usr/bin" HAS_ELEVATED="$HE" ./hexyl-setup.sh
#INSTALL_DIR="/usr/bin" HAS_ELEVATED="$HE" ./ripgrep-setup.sh
#INSTALL_DIR="/usr/bin" HAS_ELEVATED="$HE" ./tokei-setup.sh
#INSTALL_DIR="/usr/bin" HAS_ELEVATED="$HE" ./rust-analyzer-setup.sh
#HAS_ELEVATED="$HE" LIBCURL="" DISABLE_LIBXINERAMA="" LIBEXIF="" LIBMAGIC="" ./feh-setup.sh
#HAS_ELEVATED="$HE" ./nvim-setup.sh
#./rust-setup.sh

# Configs
#INSTALL_DIR=~/.config/ ./alacritty-config-setup.sh
#INSTALL_DIR=~/.config/ ./bottom-config-setup.sh
#INSTALL_DIR=~/.config/ ./neofetch-config-setup.sh
#INSTALL_DIR=~/.config/ ./nvim-config-setup.sh
#INSTALL_DIR=~ ./git-config-setup.sh

# Themes/icons/fonts/etc
#INSTALL_DIR="/usr/share/icons"  HAS_ELEVATED="$HE" ./candy-icons-setup.sh
#INSTALL_DIR="/usr/share/fonts"  HAS_ELEVATED="$HE" ./fira-code-setup.sh
#INSTALL_DIR="/usr/share/themes" HAS_ELEVATED="$HE" ./Sweet-Dark-setup.sh

echo "Install complete!"
