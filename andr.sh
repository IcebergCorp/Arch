loadkeys ru
setfont cyr-sun16
echo 'Скрипт сделан на основе чеклиста Бойко Алексея по Установке ArchLinux'
echo 'Ссылка на чек лист есть в группе vk.com/arch4u'

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
