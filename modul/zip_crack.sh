#!/bin/bash
# -- / / --
#
#.......: zip_crack.sh
#.......: Script Bash untuk crack kata sandi file ZIP
#.......: (modul zip_crack)
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
h="\e[1;32m"
b="\e[1;34m"
p="\e[1;37m"
r="\e[0m"

# Input
im=$'\e[1;31m'
ip=$'\e[1;37m'

# Tentang
program="rcrack"
versi="v1.0"
modul="zip_crack"

# Fungsi untuk error handling
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
	echo -e "${p}Selamat datang di menu help modul ${modul}!${r}"
	echo -e ""
	echo -e "${b}[*] ${p}Menu help modul:${r}"
	echo ""
	echo -e "${b}Command                                 Fungsi${r}"
	echo -e "${p}----------------                        ----------------${r}"
	echo -e "${p}set zip_file [file zip]                 Untuk menyeting file ZIP yang ingin dicrack.${r}"
	echo -e "${p}set technique [teknik]                  Untuk menyeting teknik yang ingin digunakan dalam proses crack kata sandi file ZIP.${r}"
	echo -e "${p}set wordlist_file [file wordlist]       Untuk menyeting wordlist yang ingin digunakan dalam teknik Dictionary Attack.${r}"
	echo -e "${p}set min_length [panjang minimal]        Untuk menyeting panjang minimal kata sandi yang ingin dicoba dalam teknik Brute Force Attack.${r}"
	echo -e "${p}set max_length [panjang maksimal]       Untuk menyeting panjang maksimal kata sandi yang ingin dicoba dalam teknik Brute Force Attack.${r}"
	echo -e "${p}set mask_pattern [pola mask]            Untuk menyeting pola mask yang ingin dicoba dalam teknik Mask Attack.${r}"
	echo -e "${p}set charset [karakter]                  Untuk menyeting kombinasi karakter yang ingin dicoba dalam teknik Subsets Attack.${r}"
	echo -e "${p}run                                     Untuk memulai proses crack kata sandi file ZIP.${r}"
	echo ""
	echo -e "${b}[*] ${p}Daftar teknik:${r}"
	echo ""
	echo -e "${b}Teknik                                  Keterangan${r}"
	echo -e "${p}----------------                        ----------------${r}"
	echo -e "${p}dict                                    Mencoba semua kata sandi yang ada di file Wordlist satu persatu.${r}"
	echo -e "${p}brute                                   Mencoba semua kemungkinan kombinasi karakter secara menyeluruh hingga menemukan kata sandi yang benar.${r}"
	echo -e "${p}prince                                  Mencoba berbagai kombinasi dari kata-kata dalam file Wordlist.${r}"
	echo -e "${p}mask                                    Mencoba berbagai pola tertentu untuk mempersempit ruang pencarian kata sandi.${r}"
	echo -e "${p}subsets                                 Mencoba semua kombinasi mungkin dari subset karakter tertentu.${r}"
	echo ""
	echo -e "${b}[*] ${p}Daftar pola mask:${r}"
	echo ""
	echo -e "${b}Pola mask                               Keterangan${r}"
	echo -e "${p}----------------                        ------------${r}"
	echo -e "${p}?l                                      Huruf kecil (a-z)${r}"
	echo -e "${p}?u                                      Huruf besar (A-Z)${r}"
	echo -e "${p}?d                                      Angka (0-9)${r}"
	echo -e "${p}?s                                      Simbol (@-!)${r}"
	echo -e "${p}?a                                      Semua kombinasi (huruf kecil, huruf besar, angka dan simbol).${r}"
	echo ""
	echo -e "${b}[*] ${p}Menu help script:${r}"
	echo ""
	echo -e "${b}Command                                 Fungsi${r}"
	echo -e "${p}----------------                        ----------------${r}"
	echo -e "${p}back                                    Untuk kembali ke menu utama.${r}"
	echo -e "${p}help                                    Untuk menampilkan menu bantuan.${r}"
	echo -e "${p}clear                                   Untuk membersihkan layar terminal.${r}"
	echo -e "${p}banner                                  Untuk menampilkan banner.${r}"
	echo -e "${p}version                                 Untuk menampilkan versi script.${r}"
	echo -e "${p}exit                                    Untuk keluar dari script.${r}"
	echo -e ""
}

# Fungsi untuk crack file ZIP
function zip_crack(){
	status_file_zip="false"
	status_teknik="false"
	status_file_wordlist="false"
	status_panjang_min="false"
	status_panjang_maks="false"
	status_mask_pattern="false"
	status_charset="false"
	while true; do
		read -p "${ip}${program} (${im}${modul}${ip}) > " -a zip_c
		if [[ "${#zip_c[@]}" -eq 3 ]]; then
			# seting file zip
			if [[ "${zip_c[0]}" == "set" && "${zip_c[1]}" == "zip_file" && -n "${zip_c[2]}" ]]; then
				file_zip="${zip_c[2]}"
				# cek apakah file zip ada apa kaga
				if [[ ! -f "${file_zip}" ]]; then
					echo -e "${m}[-] ${p}File ZIP '${file_zip}' tidak ditemukan.${r}"
					continue
				fi
				# cek apakah file zip merupakan file zip atau tidak
		                if ! file "${file_zip}" | grep -qi "Zip archive data"; then
					echo -e "${m}[-] ${p}File '${file_zip}' bukan file ZIP.${r}"
					continue
				fi
				echo -e "${p}File ZIP => ${file_zip}${r}"
				status_file_zip="true"
				continue
			# seting teknik
			elif [[ "${zip_c[0]}" == "set" && "${zip_c[1]}" == "technique" && -n "${zip_c[2]}" ]];  then
				daftar_teknik=("dict" "brute" "prince" "mask" "subsets")
				teknik="${zip_c[2]}"
				teknik_valid=false

				for t in "${daftar_teknik[@]}"; do
				        if [[ "${teknik}" == "${t}" ]]; then
				        	teknik_valid=true
					        break
				        fi
				done

				if [[ "${teknik_valid}" == false ]]; then
				        echo -e "${m}[-] ${p}Teknik '${teknik}' tidak tersedia.${r}"
				        continue
				fi

				if [[ "${teknik}" == "dict" ]]; then
					teknik="Dictionary Attack"
				elif [[ "${teknik}" == "brute" ]]; then
					teknik="Brute Force Attack"
				elif [[ "${teknik}" == "prince" ]]; then
					teknik="Prince Attack"
				elif [[ "${teknik}" == "mask" ]]; then
					teknik="Mask Attack"
				elif [[ "${teknik}" == "subsets" ]]; then
					teknik="Subsets Attack"
				fi
				echo -e "${p}Teknik => ${teknik}${r}"
				status_teknik="true"
				continue
			# seting wordlist
			elif [[ "${zip_c[0]}" == "set" && "${zip_c[1]}" == "wordlist_file" && -n "${zip_c[2]}" ]]; then
				file_wordlist="${zip_c[2]}"
				if [[ ! -f "${file_wordlist}" ]]; then
					echo -e "${m}[-] ${p}File Wordlist '${file_wordlist}' tidak ditemukan.${r}"
					continue
				fi
				echo -e "${p}File Wordlist => ${file_wordlist}${r}"
				status_file_wordlist="true"
				continue
			# seting panjang minimal kata sandi
			elif [[ "${zip_c[0]}" == "set" && "${zip_c[1]}" == "min_length" && -n "${zip_c[2]}" ]]; then
				panjang_min="${zip_c[2]}"
				if [[ ! "${panjang_min}" =~ ^[0-9]+$ ]]; then
					echo -e "${m}[-] ${p}Panjang minimal kata sandi harus berupa angka.${r}"
					continue
				fi
				if [[ "${panjang_min}" =~ ^0 ]]; then
					echo -e "${m}[-] ${p}Panjang minimal kata sandi tidak boleh diawali dengan angka 0.${r}"
					continue
				fi
				if [[ "${panjang_min}" -le 0 ]]; then
					echo -e "${m}[-] ${p}Panjang minimal kata sandi harus lebih besar dari angka 0.${r}"
					continue
				fi
				echo -e "${p}Panjang minimal kata sandi => ${panjang_min}${r}"
				status_panjang_min="true"
				continue
			# seting panjang maksimal kata sandi
			elif [[ "${zip_c[0]}" == "set" && "${zip_c[1]}" == "max_length" && -n "${zip_c[2]}" ]]; then
				panjang_maks="${zip_c[2]}"
				if [[ ! "${panjang_maks}" =~ ^[0-9]+$ ]]; then
					echo -e "${m}[-] ${p}Panjang maksimal kata sandi harus berupa angka.${r}"
					continue
				fi
				if [[ "${panjang_maks}" =~ ^0 ]]; then
					echo -e "${m}[-] ${p}Panjang maksimal kata sandi tidak boleh diawali dengan angka 0.${r}"
					continue
				fi
				if [[ "${panjang_maks}" -le 0 ]]; then
					echo -e "${m}[-] ${p}Panjang maksimal kata sandi harus lebih besar dari angka 0.${r}"
					continue
				fi
				if [[ ! -z "${panjang_min}" ]]; then
					if [[ ! "${panjang_maks}" -ge "${panjang_min}" ]]; then
						echo -e "${m}[-] ${p}Panjang maksimal kata sandi harus lebih besar atau sama dengan panjang minimal kata sandi.${r}"
						continue
					fi
				fi
				echo -e "${p}Panjang maksimal kata sandi => ${panjang_maks}${r}"
				status_panjang_maks="true"
				continue
			# seting mask pattern atau pola mask
			elif [[ "${zip_c[0]}" == "set" && "${zip_c[1]}" == "mask_pattern" && -n "${zip_c[2]}" ]]; then
				mask_pattern="${zip_c[2]}"
				if [[ ! "${mask_pattern}" =~ ^(\?l|\?u|\?d|\?s|\?a)+$ ]]; then
					echo -e "${m}[-] ${p}Pola mask '${mask_pattern}' tidak valid.${r}"
					continue
				fi
				echo -e "${p}Pola mask => ${mask_pattern}${r}"
				status_mask_pattern="true"
				continue
			# seting set karakter
			elif [[ "${zip_c[0]}" == "set" && "${zip_c[1]}" == "charset" && -n "${zip_c[2]}" ]]; then
				charset="${zip_c[2]}"
				echo -e "${p}Karakter => ${charset}${r}"
				status_charset="true"
				continue
			else
				error
				continue
			fi
		elif [[ "${#zip_c[@]}" -eq 1 ]]; then
			if [[ "${zip_c[0]}" == "run" ]]; then
				if [[ "${status_file_zip}" == "false" ]]; then
					echo -e "${m}[-] ${p}File ZIP belum diseting.${r}"
					continue
				elif [[ "${status_teknik}" == "false" ]]; then
					echo -e "${m}[-] ${p}Teknik belum diseting.${r}"
					continue
				else
					if [[ "${teknik}" == "Dictionary Attack" ]]; then
						if [[ "${status_file_wordlist}" == "false" ]]; then
							echo -e "${m}[-] ${p}File Wordlist belum diseting.${r}"
							continue
						fi
						echo -e "${b}[*] ${p}Mengekstrak hash file ZIP '${file_zip}'...${r}"
						file_hash="${file_zip}_hash.txt"
						zip2john "${file_zip}" > "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file ZIP '${file_zip}' gagal diekstrak.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file ZIP '${file_zip}' berhasil diekstrak.${r}"
						if grep -qi "pkzip" "${file_hash}"; then
							format="PKZIP"
						elif grep -qi "zip2" "${file_hash}"; then
							format="zip2"
						fi
						echo -e "${b}[*] ${p}Mengcrack kata sandi file ZIP '${file_zip}'...${r}"
						john --wordlist="${file_wordlist}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file ZIP '${file_zip}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file ZIP '${file_zip}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file ZIP '${file_zip}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file ZIP '${file_zip}' selesai.${r}"
						continue
					elif [[ "${teknik}" == "Brute Force Attack" ]]; then
						if [[ "${status_panjang_min}" == "false" ]]; then
							echo -e "${m}[-] ${p}Panjang minimal kata sandi belum diseting.${r}"
							continue
						fi
						if [[ "${status_panjang_maks}" == "false" ]]; then
							echo -e "${m}[-] ${p}Panjang maksimal kata sandi belum diseting.${r}"
							continue
						fi
						if [[ ! "${panjang_maks}" -ge "${panjang_min}" ]]; then
							echo -e "${m}[-] ${p}Panjang maksimal kata sandi harus lebih besar atau sama dengan panjang minimal kata sandi.${r}"
							continue
						fi
						echo -e "${b}[*] ${p}Mengekstrak hash file ZIP '${file_zip}'...${r}"
						file_hash="${file_zip}_hash.txt"
						zip2john "${file_zip}" > "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file ZIP '${file_zip}' gagal diekstrak.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file ZIP '${file_zip}' berhasil diekstrak.${r}"
						if grep -qi "pkzip" "${file_hash}"; then
							format="PKZIP"
						elif grep -qi "zip2" "${file_hash}"; then
							format="zip2"
						fi
						echo -e "${b}[*] ${p}Mengcrack kata sandi file ZIP '${file_zip}'...${r}"
						john --incremental --min-length="${panjang_min}" --max-length="${panjang_maks}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file ZIP '${file_zip}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file ZIP '${file_zip}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file ZIP '${file_zip}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file ZIP '${file_zip}' selesai.${r}"
						continue
					elif [[ "${teknik}" == "Prince Attack" ]]; then
						if [[ "${status_file_wordlist}" == "false" ]]; then
							echo -e "${m}[-] ${p}File Wordlist belum diseting.${r}"
							continue
						fi
						echo -e "${b}[*] ${p}Mengekstrak hash file ZIP '${file_zip}'...${r}"
						file_hash="${file_zip}_hash.txt"
						zip2john "${file_zip}" > "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file ZIP '${file_zip}' gagal diekstrak.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file ZIP '${file_zip}' berhasil diekstrak.${r}"
						if grep -qi "pkzip" "${file_hash}"; then
							format="PKZIP"
						elif grep -qi "zip2" "${file_hash}"; then
							format="zip2"
						fi
						echo -e "${b}[*] ${p}Mengcrack kata sandi file ZIP '${file_zip}'...${r}"
						john --prince="${file_wordlist}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file ZIP '${file_zip}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file ZIP '${file_zip}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file ZIP '${file_zip}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file ZIP '${file_zip}' selesai.${r}"
						continue
					elif [[ "${teknik}" == "Mask Attack" ]]; then
						if [[ "${status_mask_pattern}" == "false" ]]; then
							echo -e "${m}[-] ${p}Pola mask belum diseting.${r}"
							continue
						fi
						echo -e "${b}[*] ${p}Mengekstrak hash file ZIP '${file_zip}'...${r}"
						file_hash="${file_zip}_hash.txt"
						zip2john "${file_zip}" > "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file ZIP '${file_zip}' gagal diekstrak.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file ZIP '${file_zip}' berhasil diekstrak.${r}"
						if grep -qi "pkzip" "${file_hash}"; then
							format="PKZIP"
						elif grep -qi "zip2" "${file_hash}"; then
							format="zip2"
						fi
						echo -e "${b}[*] ${p}Mengcrack kata sandi file ZIP '${file_zip}'...${r}"
						john --mask="${mask_pattern}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file ZIP '${file_zip}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file ZIP '${file_zip}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file ZIP '${file_zip}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file ZIP '${file_zip}' selesai.${r}"
						continue
					elif [[ "${teknik}" == "Subsets Attack" ]]; then
						if [[ "${status_charset}" == "false" ]]; then
							echo -e "${m}[-] ${p}Karakter belum diseting.${r}"
							continue
						fi
						if [[ "${status_panjang_min}" == "false" ]]; then
							echo -e "${m}[-] ${p}Panjang minimal kata sandi belum diseting.${r}"
							continue
						fi
						if [[ "${status_panjang_maks}" == "false" ]]; then
							echo -e "${m}[-] ${p}Panjang maksimal kata sandi belum diseting.${r}"
							continue
						fi
						echo -e "${b}[*] ${p}Mengekstrak hash file ZIP '${file_zip}'...${r}"
						file_hash="${file_zip}_hash.txt"
						zip2john "${file_zip}" > "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file ZIP '${file_zip}' gagal diekstrak.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file ZIP '${file_zip}' berhasil diekstrak.${r}"
						if grep -qi "pkzip" "${file_hash}"; then
							format="PKZIP"
						elif grep -qi "zip2" "${file_hash}"; then
							format="zip2"
						fi
						echo -e "${b}[*] ${p}Mengcrack kata sandi file ZIP '${file_zip}'...${r}"
						john --subsets="${charset}" --min-length="${panjang_min}" --max-length="${panjang_maks}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file ZIP '${file_zip}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file ZIP '${file_zip}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file ZIP '${file_zip}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file ZIP '${file_zip}' selesai.${r}"
						continue
					fi
				fi
			elif [[ "${zip_c[0]}" == "back" ]]; then
				if [[ -f "rcrack.sh" ]]; then
					bash "rcrack.sh"
					break
				else
					echo -e "${m}[-] ${p}File 'rcrack.sh' tidak ditemukan.${r}"
					continue
				fi
			elif [[ "${zip_c[0]}" == "help" ]]; then
				help
				continue
			elif [[ "${zip_c[0]}" == "clear" ]]; then
				clear
				continue
			elif [[ "${zip_c[0]}" == "banner" ]]; then
				if [[ -f "script/banner.py" ]]; then
					python3 "script/banner.py"
					continue
				else
					echo -e "${m}[-] ${p}File 'script/banner.py' tidak ditemukan.${r}"
					continue
				fi
			elif [[ "${zip_c[0]}" == "version" ]]; then
				echo -e "${p}${versi}${r}"
				continue
			elif [[ "${zip_c[0]}" == "exit" ]]; then
				keluar
				break
			else
				error
				continue
			fi
		else
			error
			continue
		fi
	done
}

zip_crack
