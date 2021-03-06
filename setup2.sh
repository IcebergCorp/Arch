#!/bin/bash
read -p "Введите имя компьютера: " hostname
read -p "Введите имя пользователя: " username

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
pacman -S grub intel-ucode --noconfirm
grub-install /dev/sda

# Обновляем grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg

# Ставим программу для Wi-fi'
pacman -S dialog wpa_supplicant --noconfirm 

echo 'Добавляем пользователя'
useradd -m -g users -G wheel -s /bin/bash $username

# Создаем root пароль'
passwd

echo 'Устанавливаем пароль пользователя'
passwd $username

# Устанавливаем SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

# Раскомментируем репозиторий multilib Для работы 32-битных приложений в 64-битной системе.'
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf

# обновляем пакман
pacman -Syy

# Ставим иксы и драйвера'
pacman -S xorg xorg-server xorg-drivers xorg-xinit

echo "Ставим XFCE"
pacman -S plasma plasma-wayland-session kde-applications --noconfirm

echo 'Cтавим DM'
pacman -S sddm --noconfirm
systemctl enable sddm

echo 'Ставим шрифты'
pacman -S ttf-liberation ttf-freeserif --noconfirm 

echo 'Ставим сеть'
pacman -S networkmanager network-manager-applet ppp --noconfirm

echo 'Подключаем автозагрузку менеджера входа и интернет'
systemctl enable NetworkManager

exit
