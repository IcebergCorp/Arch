loadkeys ru
setfont cyr-sun16

echo '2.3 Синхронизация системных часов'
timedatectl set-ntp true

echo '2.4 создание разделов'
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

echo '2.4.2 Форматирование дисков'
mkfs.ext2  /dev/sda1 -L boot
mkfs.ext4  /dev/sda2 -L root
mkswap /dev/sda3 -L swap
mkfs.ext4  /dev/sda4 -L home
