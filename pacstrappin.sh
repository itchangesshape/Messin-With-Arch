#!/bin/bash

# Pacstrap the system

echo "Do you wish to initiate pacstrap?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) pacstrap -i /mnt base base-devel efibootmgr grub linux linux-headers linux-firmare linux-zen linux-zen headers /
          networkmanager networkmanager-openvpn networkmanager-pptp networkmanager-vpnc xdg-utils xdg-user-dirs sudo vi /
          vim bash bash-completion zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting intel-ucode dkms /
          broadcom-wl-dkms which nano less ifplugd firefox;; 
    No ) exit;;
  esac
done

echo "Pacstrap complete. Generate fstab?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) genfstab -U /mnt >> /mnt/etc/fstab
    No ) exit;;
  esac
done

echo "Step complete. Chroot into the system via $ arch-chroot /mnt"
