echo "WARNING!"
echo "This will reset any changes you made to any other packages locally!"
echo "Make sure you have a backup of your changes."
echo "Stop now if this might be an issue!"
sleep 3

echo "Updating the system normally..."
sleep 2
sudo xbps-install -Su # Update system normally first to avoid building every package needing update from source

echo "Udating void-packages repo..."
sleep 2
cd ~/.local/pkgs/void-packages
git clean -fd
git reset --hard
git pull

echo "Updating hyprland-void repo..."
sleep 2
cd ../hyprland-void
git pull

echo "Copying hyprland srcpkgs to void-packages..."
sleep 2
cat common/shlibs >> ../void-packages/common/shlibs
cp -r srcpkgs/* ../void-packages/srcpkgs

echo "Building update..."
sleep 2
cd ../void-packages
./xbps-src update-sys

echo "Done."
