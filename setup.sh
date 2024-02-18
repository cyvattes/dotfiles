#!/bin/sh

# Confirm Destructive Updates
echo "Destructively update NixOS and user configurations? [Y/n]"
read resp
if [[ "$resp" = "${resp#[Yy]}" ]]; then
	echo "Exiting setup."
	exit 0
fi

if ! [[ $(id -u) = 0 ]]; then
	echo "Setup script must be run as ROOT."
	exit 1
fi

# Copy NixOS System Files to /etc/nixos
echo -n "Copying NixOS system files..."
ROOT_CFG=/etc/nixos
cp -r system/. $ROOT_CFG
if [[ $? = 0 ]]; then
	echo "DONE"
else
	echo "FAILED"
	exit 1
fi

# Copy User Configuration Files to ~/.config
echo -n "Copying user configuration files..."
USER_CFG=/home/$SUDO_USER/.config
mkdir -p $USER_CFG
chown -R $SUDO_USER:users $USER_CFG
cp -a user/. $USER_CFG
cp user/zsh/zshrc.local /etc/
if [[ $? = 0 ]]; then
	echo "DONE"
else
	echo "FAILED"
	exit 1
fi

# Hotfix for Framework 12th-Gen Laptop Missing Brightness Keys
if [[ "$(cat /sys/devices/virtual/dmi/id/sys_vendor)" = "Framework" ]]; then
	cp hardware/framework-als-blacklist.conf /etc/modprobe.d/
	echo "Applied brightness key hotfix."
fi

# Apply Changes to NixOS
echo "Rebuild NixOS? [Y/n]"
read resp
if [[ "$resp" != "${resp#[Yy]}" ]]; then
	nixos-rebuild switch
else
	echo "NixOS can be rebuilt manually with \"nixos-rebuild switch\""
fi

