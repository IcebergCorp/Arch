#!/bin/bash

# Добавляем возможность писать в консоли на русском языке
loadkeys ru

# Устанавливаем русский шрифт
setfont cyr-sun16

# Синхронизация системных часов
timedatectl set-ntp true

# создание разделов
(
  echo o;

  echo n;
  echo;
  echo;
  echo;
  echo +512M;

  echo n;
  echo;
  echo;
  echo;
  echo +30G;

  echo n;
  echo;
  echo;
  echo;
  echo +16.5G;

  echo n;
  echo p;
  echo;
  echo;
  echo a;
  echo 1;

  echo w;
) | fdisk /dev/sda

# Форматирование дисков
mkfs.ext2  /dev/sda1 -L boot
mkfs.ext4  /dev/sda2 -L root
mkswap /dev/sda3 -L swap
mkfs.ext4  /dev/sda4 -L home

# Монтирование дисков
mount /dev/sda2 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
swapon /dev/sda3
mount /dev/sda4 /mnt/home

# Установка зеркала для загрузки ядра.
echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

# Установка основных пакетов ядра
pacstrap /mnt base base-devel linux linux-firmware

# Добавления файоа настроек системы
genfstab -pU /mnt >> /mnt/etc/fstab

# Заходим в папку под рутом
arch-chroot /mnt sh -c "$(curl -fsSL raw.github.com/IcebergCorp/Arch/master/andr2.sh)"
