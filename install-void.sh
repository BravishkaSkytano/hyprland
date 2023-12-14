echo "This script will use a void-src repo to install Hypr"
sleep 3

echo "Installing xorg, git, and vim..."
sleep 2
sudo xbps-install xorg git vim

echo "Creating ~/.local/pkgs...."
sleep 2
mkdir -p ~/.local/pkgs
cd ~/.local/pkgs

echo "Cloning and building void-packages..."
sleep 2
git clone https://github.com/void-linux/void-packages
cd void-packages
./xbps-src binary-bootstrap
cd ..

echo "CLoning hyprland-void from Makrennel..."
sleep 2
git clone https://github.com/Makrennel/hyprland-void.git
cd hyprland-void

echo "Adding shared libraries to void-packages..."
sleep 2
cat common/shlibs >> ../void-packages/common/shlibs

echo "Copying srcpkgs to void-packages"
cp -r srcpkgs/* ../void-packages/srcpkgs

echo "Building and installing hyprland packages"
cd ../void-packages
./xbps-src pkg {hyprland,xdg-desktop-portal-hyprland,hyprland-protocols,hyprpaper}
sudo xbps-install -R hostdir/binpkgs {hyprland,hyprland-protocols,xdg-desktop-portal-hyprland,hyprpaper}

echo "Installing kitty, dbus, seatd, polkit elogind, mesa-dri"
sleep 2
sudo xbps-install kitty dbus seatd polkit elogind mesa-dri

echo "Starting services..."
sudo ln -s /etc/sv/{dbus,polkitd,seatd} /var/service

echo "Assigning you to _seatd..."
read -rp "What is your username?" $user
sudo usermod -aG _seatd $user

echo "Done."
echo "Congratulations on your new system!"
