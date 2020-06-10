#!/bin/bash
read -p "Введите имя компьютера: " hostname

# Прописываем имя компьютера'
echo $hostname > /etc/hostname
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

# Добавляем русскую локаль системы'
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen 

# Обновим текущую локаль системы'
locale-gen

# Указываем язык системы'
echo 'LANG=ru_RU.UTF-8' > /etc/locale.conf

# расскладка клавиатуры
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

# Создадим загрузочный RAM диск'
mkinitcpio -p linux

# Устанавливаем загрузчик'
pacman -Syy
pacman -S grub --noconfirm intel-ucode
grub-install /dev/sda

# Обновляем grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg

# Ставим программу для Wi-fi'
pacman -S dialog wpa_supplicant --noconfirm 

# Создаем root пароль'
passwd

# Устанавливаем SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

# Раскомментируем репозиторий multilib Для работы 32-битных приложений в 64-битной системе.'
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf

# обновляем пакман
pacman -Syy

# Ставим иксы и драйвера'
pacman -S xorg-server xorg-drivers xorg-xinit

echo "Ставим XFCE"
pacman -S budgie-desktop gnome --noconfirm

echo 'Cтавим DM'
pacman -S gdm --noconfirm
systemctl enable gdm

echo 'Ставим шрифты'
pacman -S ttf-liberation ttf-dejavu --noconfirm 

echo 'Ставим сеть'
pacman -S networkmanager network-manager-applet ppp --noconfirm

echo 'Подключаем автозагрузку менеджера входа и интернет'
systemctl enable NetworkManager

exit
