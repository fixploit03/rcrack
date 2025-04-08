#!/bin/bash
# -- / / --
#
#.......: run.sh
#.......: Script Bash untuk menjalankan script rcrack.sh
#.......: runner script (pembuka)
#
# -- / / --
#
# Dibuat oleh: Rofi (Fixploit03)
# Github: https://github.com/fixploit03/rcrack
#
# -- / / --
#
# Script ini merupakan pengembangan dari repositori Jono
#
# -- / / --

# Variabel warna
m="\e[1;31m"
b="\e[1;34m"
p="\e[1;37m"
r="\e[0m"

# Tentang
program="rcrack"

echo -e "${b}[*] ${p}Menjalankan '${program}'...${r}"
sleep 5

if [[ -f "script/banner.py" ]]; then
	python3 "script/banner.py"
else
	echo -e "${m}[-] ${p}File 'script/banner.py' tidak ditemukan.${r}"
	exit 1
fi

if [[ -f "rcrack.sh" ]]; then
	bash "rcrack.sh"
else
	echo -e "${m}[-] ${p}File 'rcrack.sh' tidak ditemukan.${r}"
	exit 1
fi
