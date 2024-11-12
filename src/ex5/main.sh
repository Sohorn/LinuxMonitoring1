#!/bin/bash

NC='\033[0m'
RED='\033[31m'
BLUE='\033[34m'

START=$(date +%s%N)

if [ $# -ne 1 ] || [ "${1: -1}" != "/" ]; then
    echo -e "${RED}ERROR:${NC} Invalid argument"
    exit 1
fi

DIR=$1

echo -e "${BLUE}Total number of folders (including all nested ones)${NC}: $(find "$DIR" -type d 2>/dev/null | wc -l)"
echo -e "${BLUE}TOP 5 folders of maximum size arranged in descending order${NC}:"
du -h "$DIR" --max-depth=1 2>/dev/null | sort -hr | head -5 | cat -n | awk '{print $1" - "$3", "$2}'
echo -e "${BLUE}Total number of files${NC}: $(find "$DIR" -type f 2>/dev/null | wc -l)"
echo -e "${BLUE}Number of:${NC}"
echo "Configuration files (with the .conf extension): $(find "$DIR" -type f -name "*.conf" 2>/dev/null | wc -l)"
echo "Text files: $(find "$DIR" -type f -name "*.txt" 2>/dev/null | wc -l)"
echo "Executable files: $(find "$DIR" -type f -executable 2>/dev/null | wc -l)"
echo "Log files (with the extension .log): $(find "$DIR" -type f -name "*.log" 2>/dev/null | wc -l)"
echo "Archive files: $(find "$DIR" -type f \( -name "*.zip" -o -name "*.tar" -o -name "*.gz" -o -name "*.rar" \) 2>/dev/null | wc -l)"
echo "Symbolic links: $(find "$DIR" -type l 2>/dev/null | wc -l)"
echo -e "${BLUE}TOP 10 files of maximum size arranged in descending order${NC}:"
find "$DIR" -type f -exec du -h {} + 2>/dev/null | sort -hr | head -10 | cat -n | awk '{print $1" - "$3", "$2}'
echo -e "${BLUE}TOP 10 executable files of the maximum size arranged in descending order${NC}:"
find "$DIR" -type f -executable -exec du -h {} + 2>/dev/null | sort -hr | head -10 | cat -n | awk '{print $1" - "$3", "$2}'

END=$(date +%s%N)
DIFF=$((( $END - $START )/1000000))
echo -e "${BLUE}Script execution time (in seconds)${NC}: $DIFF"