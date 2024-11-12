#!/bin/bash

# Получаем сетевое имя

get_system_info() {
HOSTNAME=$(hostname)
# Получаем временную зону
TIMEZONE=$(timedatectl | grep "Time zone" | awk '{print $3, $4, $5}')
# Получаем текущего пользователя
USER=$(whoami)
# Получаем тип и версию операционной системы
OS=$(cat /etc/os-release | grep "PRETTY_NAME" | cut -d'"' -f2)
# Получаем текущую дату и время
DATE=$(date +"%d %b %Y %H:%M:%S")
# Получаем время работы системы
UPTIME=$(uptime -p | cut -d' ' -f2-)
# Получаем время работы системы в секундах
UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}')
# Получаем IP-адрес машины
IP=$(hostname -I | awk '{print $1}')
# Получаем сетевую маску
MASK=$(ifconfig | grep -m1 netmask | awk '{print $4}')
# Получаем IP шлюза по умолчанию
GATEWAY=$(ip route | grep default | awk '{print $3}')
# Получаем размер оперативной памяти
RAM_TOTAL=$(free -m | grep Mem | awk '{printf "%.3f GB", $2/1024}')
RAM_USED=$(free -m | grep Mem | awk '{printf "%.3f GB", $3/1024}')
RAM_FREE=$(free -m | grep Mem | awk '{printf "%.3f GB", $4/1024}')
# Получаем размер рутового раздела
SPACE_ROOT=$(df -m / | grep / | awk '{printf "%.2f MB", $2}')
SPACE_ROOT_USED=$(df -m / | grep / | awk '{printf "%.2f MB", $3}')
SPACE_ROOT_FREE=$(df -m / | grep / | awk '{printf "%.2f MB", $4}')
}

# Выводим информацию на экран

print_system_info() {
echo "HOSTNAME = $HOSTNAME"
echo "TIMEZONE = $TIMEZONE"
echo "USER = $USER"
echo "OS = $OS"
echo "DATE = $DATE"
echo "UPTIME = $UPTIME"
echo "UPTIME_SEC = $UPTIME_SEC"
echo "IP = $IP"
echo "MASK = $MASK"
echo "GATEWAY = $GATEWAY"
echo "RAM_TOTAL = $RAM_TOTAL"
echo "RAM_USED = $RAM_USED"
echo "RAM_FREE = $RAM_FREE"
echo "SPACE_ROOT = $SPACE_ROOT"
echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
}

# Предлагаем пользователю сохранить информацию в файл

record() {
read -p "Do you want to save this information to a file? (Y/N): " answer

# Проверяем ответ пользователя
if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
    # Создаем имя файла с текущей датой и временем
    FILENAME=$(date +"%d_%m_%y_%H_%M_%S.status")
    
    # Сохраняем информацию в файл
    echo "HOSTNAME = $HOSTNAME" > $FILENAME
    echo "TIMEZONE = $TIMEZONE" >> $FILENAME
    echo "USER = $USER" >> $FILENAME
    echo "OS = $OS" >> $FILENAME
    echo "DATE = $DATE" >> $FILENAME
    echo "UPTIME = $UPTIME" >> $FILENAME
    echo "UPTIME_SEC = $UPTIME_SEC" >> $FILENAME
    echo "IP = $IP" >> $FILENAME
    echo "MASK = $MASK" >> $FILENAME
    echo "GATEWAY = $GATEWAY" >> $FILENAME
    echo "RAM_TOTAL = $RAM_TOTAL" >> $FILENAME
    echo "RAM_USED = $RAM_USED" >> $FILENAME
    echo "RAM_FREE = $RAM_FREE" >> $FILENAME
    echo "SPACE_ROOT = $SPACE_ROOT" >> $FILENAME
    echo "SPACE_ROOT_USED = $SPACE_ROOT_USED" >> $FILENAME
    echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE" >> $FILENAME
    
    echo "Information saved to $FILENAME"
else
    echo "Information not saved"
fi
}
