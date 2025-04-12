#!/bin/bash
# -- / / --
#
#.......: rcrack.sh
#.......: Script Bash untuk crack berbagai jenis file menggunakan John The Ripper
#.......: main script (script utama)
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

# Input
im=$'\e[1;31m'
ip=$'\e[1;37m'
iu=$'\e[4m'
ir=$'\e[0m'

# Tentang
program="rcrack"
versi="v1.0"

# Fugsi untuk error handling
function error(){
	echo -e "${m}[-] ${p}Ketikkan 'help' untuk menampilkan menu bantuan.${r}"
}

# Fungsi untuk keluar dari script
function keluar(){
	echo ""
	echo -e "${p}Bye...${r}"
	exit 1
}

# Fungsi untuk menampilkan menu help atau menu bantuan
function help(){
	echo -e ""
	echo -e "${p}Selamat datang di menu help ${program}!${r}"
	echo -e ""
	echo -e "${b}[*] ${p}Menu help script:${r}"
	echo ""
	echo -e "${b}Command                Fungsi${r}"
	echo -e "${p}----------------       ----------------${r}"
	echo -e "${p}use [nama modul]       Untuk menggunakan modul yang ingin digunakan.${r}"
	echo -e "${p}help                   Untuk menampilkan menu bantuan.${r}"
	echo -e "${p}clear                  Untuk membersihkan layar terminal.${r}"
	echo -e "${p}banner                 Untuk menampilkan banner.${r}"
	echo -e "${p}version                Untuk menampilkan versi script.${r}"
	echo -e "${p}exit                   Untuk keluar dari script.${r}"
	echo -e ""
	echo -e "${b}[*] ${p}Daftar modul yang tersedia:${r}"
	echo -e ""
	echo -e "${b}Nama Modul             Fungsi${r}"
	echo -e "${p}----------------       ----------------${r}"
	echo -e "${p}zip_crack              Untuk mengcrack file ZIP.${r}"
	echo -e "${p}rar_crack              Untuk mengcrack file RAR.${r}"
	echo -e "${p}7z_crack               Untuk mengcrack file 7z.${r}"
	echo -e "${p}pdf_crack              Untuk mengcrack file PDF.${r}"
	echo -e "${p}office_crack           Untuk mengcrack file Office.${r}"
	echo ""
}

# Fungsi utama script
function rcrack(){
	while true; do
		read -e -r -p "${ip}${iu}rcrack${ir} ${ip}> " rcrack
		if [[ "${rcrack}" == "" ]]; then
			continue
		elif [[ "${rcrack}" == "use zip_crack" ]]; then
			if [[ -f "modul/zip_crack.sh" ]]; then
				bash "modul/zip_crack.sh"
				break
			else
				echo -e "${m}[-] ${p}File 'modul/zip_crack.sh' tidak ditemukan.${r}"
				continue
			fi
		elif [[ "${rcrack}" == "use rar_crack" ]]; then
			if [[ -f "modul/rar_crack.sh" ]]; then
				bash "modul/rar_crack.sh"
				break
			else
				echo -e "${m}[-] ${p}File 'modul/rar_crack.sh' tidak ditemukan.${r}"
				continue
			fi
		elif [[ "${rcrack}" == "use 7z_crack" ]]; then
			if [[ -f "modul/7z_crack.sh" ]]; then
				bash "modul/7z_crack.sh"
				break
			else
				echo -e "${m}[-] ${p}File 'modul/7z_crack.sh' tidak ditemukan.${r}"
				continue
			fi
		elif [[ "${rcrack}" == "use pdf_crack" ]]; then
			if [[ -f "modul/pdf_crack.sh" ]]; then
				bash "modul/pdf_crack.sh"
				break
			else
				echo -e "${m}[-] ${p}File 'modul/pdf_crack.sh' tidak ditemukan.${r}"
				continue
			fi
		elif [[ "${rcrack}" == "use office_crack" ]]; then
			if [[ -f "modul/office_crack.sh" ]]; then
				bash "modul/office_crack.sh"
				break
			else
				echo -e "${m}[-] ${p}File 'modul/office_crack.sh' tidak ditemukan.${r}"
				continue
			fi
		elif [[ "${rcrack}" == "help" ]]; then
			help
			continue
		elif [[ "${rcrack}" == "clear" ]]; then
			clear
			continue
		elif [[ "${rcrack}" == "banner" ]]; then
			if [[ -f "script/banner.py" ]]; then
				python3 "script/banner.py"
				continue
			else
				echo -e "${m}[-] ${p}File 'script/banner.py' tidak ditemukan."
				continue
			fi
		elif [[ "${rcrack}" == "version" ]]; then
			echo -e "${p}${versi}${r}"
			continue
		elif [[ "${rcrack}" == "exit" ]]; then
			keluar
			break
		else
			error
			continue
		fi
	done
}

rcrack
