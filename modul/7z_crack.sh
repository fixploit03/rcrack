#!/bin/bash
# -- / / --
#
#.......: 7z_crack.sh
#.......: Script Bash untuk crack kata sandi file 7z
#.......: (modul 7z_crack)
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
modul="7z_crack"

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
	echo -e "${p}set 7z_file [file 7z]                   Untuk menyeting file 7z yang ingin dicrack.${r}"
	echo -e "${p}set technique [teknik]                  Untuk menyeting teknik yang ingin digunakan dalam proses crack kata sandi file 7z.${r}"
	echo -e "${p}set wordlist_file [file wordlist]       Untuk menyeting wordlist yang ingin digunakan dalam teknik Dictionary Attack.${r}"
	echo -e "${p}set min_length [panjang minimal]        Untuk menyeting panjang minimal kata sandi yang ingin dicoba dalam teknik Brute Force Attack.${r}"
	echo -e "${p}set max_length [panjang maksimal]       Untuk menyeting panjang maksimal kata sandi yang ingin dicoba dalam teknik Brute Force Attack.${r}"
	echo -e "${p}set mask_pattern [pola mask]            Untuk menyeting pola mask yang ingin dicoba dalam teknik Mask Attack.${r}"
	echo -e "${p}set charset [karakter]                  Untuk menyeting kombinasi karakter yang ingin dicoba dalam teknik Subsets Attack.${r}"
	echo -e "${p}run                                     Untuk memulai proses crack kata sandi file 7z.${r}"
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

# Fungsi untuk crack file 7z
function f7z_crack(){
	while true; do
		read -p "${ip}${program} (${im}${modul}${ip}) > " -a i7z_c
		if [[ "${#i7z_c[@]}" -eq 3 ]]; then
			# seting file 7z
			if [[ "${i7z_c[0]}" == "set" && "${i7z_c[1]}" == "7z_file" ]]; then
				file_7z="${i7z_c[2]}"
				# cek apakah file 7z ada apa kaga
				if [[ ! -f "${file_7z}" ]]; then
					echo -e "${m}[-] ${p}File 7z '${file_7z}' tidak ditemukan.${r}"
					continue
				fi
				# cek apakah file 7z merupakan file 7z atau tidak
                if ! file "${file_7z}" | grep -qi "7-zip archive data"; then
					echo -e "${m}[-] ${p}File '${file_7z}' bukan file 7z.${r}"
					continue
				fi
				echo -e "${p}File 7z => ${file_7z}${r}"
				continue
            else
                error
                continue
			fi
			# seting teknik
			if [[ "${i7z_c[0]}" == "set" && "${i7z_c[1]}" == "technique" ]];  then
				daftar_teknik=("dict" "brute" "prince" "mask" "subsets")
				teknik="${i7z_c[2]}"
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
				continue
            else
                error
                continue
			fi
			# seting wordlist
			if [[ "${i7z_c[0]}" == "set" && "${i7z_c[1]}" == "wordlist_file" ]]; then
				file_wordlist="${i7z_c[2]}"
				if [[ ! -f "${file_wordlist}" ]]; then
					echo -e "${m}[-] ${p}File Wordlist '${file_wordlist}' tidak ditemukan.${r}"
					continue
				fi
				echo -e "${p}File Wordlist => ${file_wordlist}${r}"
				continue
            else
                error
                continue
            fi
			# seting panjang minimal kata sandi
			if [[ "${i7z_c[0]}" == "set" && "${i7z_c[1]}" == "min_length" ]]; then
				panjang_min="${i7z_c[2]}"
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
				continue
            else
                error
                continue
            fi
			# seting panjang maksimal kata sandi
			if [[ "${i7z_c[0]}" == "set" && "${i7z_c[1]}" == "max_length" ]]; then
				panjang_maks="${i7z_c[2]}"
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
				continue
            else
                error
                continue
            fi
			# seting mask pattern atau pola mask
			if [[ "${i7z_c[0]}" == "set" && "${i7z_c[1]}" == "mask_pattern" ]]; then
				mask_pattern="${i7z_c[2]}"
				if [[ ! "${mask_pattern}" =~ ^(\?l|\?u|\?d|\?s|\?a)+$ ]]; then
					echo -e "${m}[-] ${p}Pola mask '${mask_pattern}' tidak valid.${r}"
					continue
				fi
				echo -e "${p}Pola mask => ${mask_pattern}${r}"
				continue
            else
                error
                continue
            fi
			# seting set karakter
			if [[ "${i7z_c[0]}" == "set" && "${i7z_c[1]}" == "charset" ]]; then
				charset="${i7z_c[2]}"
				echo -e "${p}Karakter => ${charset}${r}"
				continue
            else
                error
                continue
            fi
		elif [[ "${#i7z_c[@]}" -eq 1 ]]; then
			if [[ "${i7z_c[0]}" == "run" ]]; then
				if [[ -z "${file_7z}" ]]; then
					echo -e "${m}[-] ${p}File 7z belum diseting.${r}"
					continue
				elif [[ -z "${teknik}" ]]; then
					echo -e "${m}[-] ${p}Teknik belum diseting.${r}"
					continue
				else
					if [[ "${teknik}" == "Dictionary Attack" ]]; then
						if [[ -z "${file_wordlist}" ]]; then
							echo -e "${m}[-] ${p}File Wordlist belum diseting.${r}"
							continue
						fi
						echo -e "${b}[*] ${p}Mengekstrak hash file 7z '${file_7z}'...${r}"
						file_hash="${file_7z}_hash.txt"
						7z2john "${file_7z}" > "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file 7z '${file_7z}' gagal diekstrak.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file 7z '${file_7z}' berhasil diekstrak.${r}"
						format="7z"
						echo -e "${b}[*] ${p}Mengcrack kata sandi file 7z '${file_7z}'...${r}"
						john --wordlist="${file_wordlist}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file 7z '${file_7z}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file 7z '${file_7z}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file 7z '${file_7z}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file 7z '${file_7z}' selesai.${r}"
						continue
					elif [[ "${teknik}" == "Brute Force Attack" ]]; then
						if [[ -z "${panjang_min}" ]]; then
							echo "[-] Panjang minimal kata sandi belum diseting."
							continue
						fi
						if [[ -z "${panjang_maks}" ]]; then
							echo "[-] Panjang maksimal kata sandi belum diseting."
							continue
						fi
						if [[ ! "${panjang_maks}" -ge "${panjang_min}" ]]; then
							echo "[-] Panjang maksimal kata sandi harus lebih besar atau sama dengan panjang minimal kata sandi."
							continue
						fi
						echo -e "${b}[*] ${p}Mengekstrak hash file 7z '${file_7z}'...${r}"
						file_hash="${file_7z}_hash.txt"
						7z2john "${file_7z}" > "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file 7z '${file_7z}' gagal diekstrak.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file 7z '${file_7z}' berhasil diekstrak.${r}"
						format="7z"
						echo -e "${b}[*] ${p}Mengcrack kata sandi file 7z '${file_7z}'...${r}"
						john --incremental --min-length="${panjang_min}" --max-length="${panjang_maks}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file 7z '${file_7z}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file 7z '${file_7z}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file 7z '${file_7z}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file 7z '${file_7z}' selesai.${r}"
						continue
					elif [[ "${teknik}" == "Prince Attack" ]]; then
						if [[ -z "${file_wordlist}" ]]; then
							echo -e "${m}[-] ${p}File Wordlist belum diseting.${r}"
							continue
						fi
						echo -e "${b}[*] ${p}Mengekstrak hash file 7z '${file_7z}'...${r}"
						file_hash="${file_7z}_hash.txt"
						7z2john "${file_7z}" > "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file 7z '${file_7z}' gagal diekstrak.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file 7z '${file_7z}' berhasil diekstrak.${r}"
						format="7z"
						echo -e "${b}[*] ${p}Mengcrack kata sandi file 7z '${file_7z}'...${r}"
						john --prince="${file_wordlist}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file 7z '${file_7z}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file 7z '${file_7z}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file 7z '${file_7z}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file 7z '${file_7z}' selesai.${r}"
						continue
					elif [[ "${teknik}" == "Mask Attack" ]]; then
						if [[ -z "${mask_pattern}" ]]; then
							echo -e "${m}[-] ${p}Pola mask belum diseting.${r}"
							continue
						fi
						echo -e "${b}[*] ${p}Mengekstrak hash file 7z '${file_7z}'...${r}"
						file_hash="${file_7z}_hash.txt"
						7z2john "${file_7z}" > "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file 7z '${file_7z}' gagal diekstrak.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file 7z '${file_7z}' berhasil diekstrak.${r}"
						format="7z"
						echo -e "${b}[*] ${p}Mengcrack kata sandi file 7z '${file_7z}'...${r}"
						john --mask="${mask_pattern}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file 7z '${file_7z}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file 7z '${file_7z}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file 7z '${file_7z}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file 7z '${file_7z}' selesai.${r}"
						continue
					elif [[ "${teknik}" == "Subsets Attack" ]]; then
						if [[ -z "${charset}" ]]; then
							echo -e "${m}[-] ${p}Karakter belum diseting.${r}"
							continue
						fi
						if [[ -z "${panjang_min}" ]]; then
							echo -e "${m}[-] ${p}Panjang minimal kata sandi belum diseting.${r}"
							continue
						fi
						if [[ -z "${panjang_maks}" ]]; then
							echo -r "${m}[-] ${p}Panjang maksimal kata sandi belum diseting.${r}"
							continue
						fi
						echo -e "${b}[*] ${p}Mengekstrak hash file 7z '${file_7z}'...${r}"
						file_hash="${file_7z}_hash.txt"
						7z2john "${file_7z}" > "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file 7z '${file_7z}' gagal diekstrak.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file 7z '${file_7z}' berhasil diekstrak.${r}"
						format="7z"
						echo -e "${b}[*] ${p}Mengcrack kata sandi file 7z '${file_7z}'...${r}"
						john --subsets="${charset}" --min-length="${panjang_min}" --max-length="${panjang_maks}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file 7z '${file_7z}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file 7z '${file_7z}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file 7z '${file_7z}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file 7z '${file_7z}' selesai.${r}"
						continue
					fi
				fi
			elif [[ "${i7z_c[0]}" == "back" ]]; then
				if [[ -f "rcrack.sh" ]]; then
					bash "rcrack.sh"
					break
				else
					echo -e "${m}[-] ${p}File 'rcrack.sh' tidak ditemukan.${r}"
					continue
				fi
			elif [[ "${i7z_c[0]}" == "help" ]]; then
				help
				continue
			elif [[ "${i7z_c[0]}" == "clear" ]]; then
				clear
				continue
			elif [[ "${i7z_c[0]}" == "banner" ]]; then
				if [[ -f "script/banner.py" ]]; then
					python3 "script/banner.py"
					continue
				else
					echo -e "${m}[-] ${p}File 'script/banner.py' tidak ditemukan.${r}"
					continue
				fi
			elif [[ "${i7z_c[0]}" == "version" ]]; then
				echo -e "${p}${versi}${r}"
				continue
			elif [[ "${i7z_c[0]}" == "exit" ]]; then
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

f7z_crack
