#!/bin/bash

get_system_info() {
    HOSTNAME=$(hostname)
    TIMEZONE=$(timedatectl | grep "Time zone" | awk '{print $3, $4, $5}')
    USER=$(whoami)
    OS=$(cat /etc/os-release | grep "PRETTY_NAME" | cut -d'"' -f2)
    DATE=$(date +"%d %b %Y %H:%M:%S")
    UPTIME=$(uptime -p | cut -d' ' -f2-)
    UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}')
    IP=$(hostname -I | awk '{print $1}')
    MASK=$(ifconfig | grep -m1 netmask | awk '{print $4}')
    GATEWAY=$(ip route | grep default | awk '{print $3}')
    RAM_TOTAL=$(free -m | grep Mem | awk '{printf "%.3f GB", $2/1024}')
    RAM_USED=$(free -m | grep Mem | awk '{printf "%.3f GB", $3/1024}')
    RAM_FREE=$(free -m | grep Mem | awk '{printf "%.3f GB", $4/1024}')
    SPACE_ROOT=$(df -m / | grep / | awk '{printf "%.2f MB", $2}')
    SPACE_ROOT_USED=$(df -m / | grep / | awk '{printf "%.2f MB", $3}')
    SPACE_ROOT_FREE=$(df -m / | grep / | awk '{printf "%.2f MB", $4}')
}

print_system_info() {
    echo -e "${BG_COLOR1}${TEXT_COLOR1}HOSTNAME${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$HOSTNAME${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}TIMEZONE${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$TIMEZONE${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}USER${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$USER${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}OS${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$OS${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}DATE${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$DATE${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}UPTIME${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$UPTIME${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}UPTIME_SEC${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$UPTIME_SEC${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}IP${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$IP${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}MASK${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$MASK${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}GATEWAY${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$GATEWAY${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}RAM_TOTAL${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$RAM_TOTAL${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}RAM_USED${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$RAM_USED${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}RAM_FREE${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$RAM_FREE${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}SPACE_ROOT${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$SPACE_ROOT${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}SPACE_ROOT_USED${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$SPACE_ROOT_USED${RESET}"
    echo -e "${BG_COLOR1}${TEXT_COLOR1}SPACE_ROOT_FREE${RESET} = ${BG_COLOR2}${TEXT_COLOR2}$SPACE_ROOT_FREE${RESET}"
}

if [ $# -ne 4 ]; then
    echo "Usage: $0 <bg_color1> <text_color1> <bg_color2> <text_color2>"
    exit 1
fi

COLORS=("white" "red" "green" "blue" "purple" "black")

# Проверка на корректность ввода цветов
for param in "$@"; do
    if ! [[ "$param" =~ ^[1-6]$ ]]; then
        echo "Invalid color parameter: $param. All parameters must be numbers from 1 to 6."
        exit 1
    fi
done

# Присвоение цветов
BG_COLOR1=${COLORS[$1-1]}
TEXT_COLOR1=${COLORS[$2-1]}
BG_COLOR2=${COLORS[$3-1]}
TEXT_COLOR2=${COLORS[$4-1]}

# Проверка на совпадение цветов
if [ "$BG_COLOR1" == "$TEXT_COLOR1" ] || [ "$BG_COLOR2" == "$TEXT_COLOR2" ]; then
    echo "Background and text colors cannot be the same. Please run the script again with different colors."
    exit 1
fi

# Установка цветов в ANSI-коды
declare -A COLOR_CODES=(
    ["white"]="\033[47m"
    ["red"]="\033[41m"
    ["green"]="\033[42m"
    ["blue"]="\033[44m"
    ["purple"]="\033[45m"
    ["black"]="\033[40m"
)

declare -A TEXT_COLOR_CODES=(
    ["white"]="\033[37m"
    ["red"]="\033[31m"
    ["green"]="\033[32m"
    ["blue"]="\033[34m"
    ["purple"]="\033[35m"
    ["black"]="\033[30m"
)

BG_COLOR1=${COLOR_CODES[$BG_COLOR1]}
TEXT_COLOR1=${TEXT_COLOR_CODES[$TEXT_COLOR1]}
BG_COLOR2=${COLOR_CODES[$BG_COLOR2]}
TEXT_COLOR2=${TEXT_COLOR_CODES[$TEXT_COLOR2]}
RESET="\033[0m"


get_system_info


print_system_info