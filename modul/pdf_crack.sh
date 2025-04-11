#!/bin/bash
# -- / / --
#
#.......: pdf_crack.sh
#.......: Script Bash untuk crack kata sandi file PDF
#.......: (modul pdf_crack)
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
modul="pdf_crack"

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
	echo -e "${p}set pdf_file [file pdf]                 Untuk menyeting file PDF yang ingin dicrack.${r}"
	echo -e "${p}set technique [teknik]                  Untuk menyeting teknik yang ingin digunakan dalam proses crack kata sandi file PDF.${r}"
	echo -e "${p}set wordlist_file [file wordlist]       Untuk menyeting wordlist yang ingin digunakan dalam teknik Dictionary Attack.${r}"
	echo -e "${p}set min_length [panjang minimal]        Untuk menyeting panjang minimal kata sandi yang ingin dicoba dalam teknik Brute Force Attack.${r}"
	echo -e "${p}set max_length [panjang maksimal]       Untuk menyeting panjang maksimal kata sandi yang ingin dicoba dalam teknik Brute Force Attack.${r}"
	echo -e "${p}set mask_pattern [pola mask]            Untuk menyeting pola mask yang ingin dicoba dalam teknik Mask Attack.${r}"
	echo -e "${p}set charset [karakter]                  Untuk menyeting kombinasi karakter yang ingin dicoba dalam teknik Subsets Attack.${r}"
	echo -e "${p}run                                     Untuk memulai proses crack kata sandi file PDF.${r}"
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

# Fungsi untuk crack file PDF
function pdf_crack(){
	status_file_pdf="false"
	status_teknik="false"
	status_file_wordlist="false"
	status_panjang_min="false"
	status_panjang_maks="false"
	status_mask_pattern="false"
	status_charset="false"
	while true; do
		read -e -r -p "${ip}${program} (${im}${modul}${ip}) > " -a pdf_c
		if [[ "${#pdf_c[@]}" -eq 3 ]]; then
			# seting file pdf
			if [[ "${pdf_c[0]}" == "set" && "${pdf_c[1]}" == "pdf_file" && -n "${pdf_c[2]}" ]]; then
				file_pdf="${pdf_c[2]}"
				# cek apakah file pdf ada apa kaga
				if [[ ! -f "${file_pdf}" ]]; then
					echo -e "${m}[-] ${p}File PDF '${file_pdf}' tidak ditemukan.${r}"
					continue
				fi
				# cek apakah file pdf merupakan file pdf atau tidak
			        if [[ "${file_pdf##*.}" != "pdf" ]]; then
					echo -e "${m}[-] ${p}File '${file_pdf}' bukan file PDF.${r}"
					continue
				fi
				echo -e "${p}File PDF => ${file_pdf}${r}"
				status_file_pdf="true"
				continue
			# seting teknik
			elif [[ "${pdf_c[0]}" == "set" && "${pdf_c[1]}" == "technique" && -n "${pdf_c[2]}" ]];  then
				daftar_teknik=("dict" "brute" "prince" "mask" "subsets")
				teknik="${pdf_c[2]}"
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
			elif [[ "${pdf_c[0]}" == "set" && "${pdf_c[1]}" == "wordlist_file" && -n "${pdf_c[2]}" ]]; then
				file_wordlist="${pdf_c[2]}"
				if [[ ! -f "${file_wordlist}" ]]; then
					echo -e "${m}[-] ${p}File Wordlist '${file_wordlist}' tidak ditemukan.${r}"
					continue
				fi
				echo -e "${p}File Wordlist => ${file_wordlist}${r}"
				status_file_wordlist="true"
				continue
			# seting panjang minimal kata sandi
			elif [[ "${pdf_c[0]}" == "set" && "${pdf_c[1]}" == "min_length" && -n "${pdf_c[2]}" ]]; then
				panjang_min="${pdf_c[2]}"
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
			elif [[ "${pdf_c[0]}" == "set" && "${pdf_c[1]}" == "max_length" && -n "${pdf_c[2]}" ]]; then
				panjang_maks="${pdf_c[2]}"
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
			elif [[ "${pdf_c[0]}" == "set" && "${pdf_c[1]}" == "mask_pattern" && -n "${pdf_c[2]}" ]]; then
				mask_pattern="${pdf_c[2]}"
				if [[ ! "${mask_pattern}" =~ ^(\?l|\?u|\?d|\?s|\?a)+$ ]]; then
					echo -e "${m}[-] ${p}Pola mask '${mask_pattern}' tidak valid.${r}"
					continue
				fi
				echo -e "${p}Pola mask => ${mask_pattern}${r}"
				status_mask_pattern="true"
				continue
			# seting set karakter
			elif [[ "${pdf_c[0]}" == "set" && "${pdf_c[1]}" == "charset" && -n "${pdf_c[2]}" ]]; then
				charset="${pdf_c[2]}"
				echo -e "${p}Karakter => ${charset}${r}"
				status_charset="true"
				continue
			else
				error
				continue
			fi
		elif [[ "${#pdf_c[@]}" -eq 1 ]]; then
			if [[ "${pdf_c[0]}" == "run" ]]; then
				if [[ "${status_file_pdf}" == "false" ]]; then
					echo -e "${m}[-] ${p}File PDF belum diseting.${r}"
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
						echo -e "${b}[*] ${p}Mengekstrak hash file PDF '${file_pdf}'...${r}"
						file_hash="${file_pdf}_hash.txt"
						pdf2john "${file_pdf}" 1> "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							continue
						fi
						if pdfid "${file_pdf}" | grep -qo "Not a PDF document"; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							echo -e "${m}[-] ${p}File PDF '${file_pdf}' tidak valid atau rusak.${r}"
							continue
						fi
						if pdfinfo "${file_pdf}" | grep -qo "Encrypted:       no"; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							echo -e "${m}[-] ${p}File PDF '${file_pdf}' tidak dienkripsi.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file PDF '${file_pdf}' berhasil diekstrak.${r}"
						format="PDF"
						echo -e "${b}[*] ${p}Mengcrack kata sandi file PDF '${file_pdf}'...${r}"
						john --wordlist="${file_wordlist}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file PDF '${file_pdf}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file PDF '${file_pdf}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file PDF '${file_pdf}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file PDF '${file_pdf}' selesai.${r}"
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
						echo -e "${b}[*] ${p}Mengekstrak hash file PDF '${file_pdf}'...${r}"
						file_hash="${file_pdf}_hash.txt"
						pdf2john "${file_pdf}" 1> "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							continue
						fi
						if pdfid "${file_pdf}" | grep -qo "Not a PDF document"; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							echo -e "${m}[-] ${p}File PDF '${file_pdf}' tidak valid atau rusak.${r}"
							continue
						fi
						if pdfinfo "${file_pdf}" | grep -qo "Encrypted:       no"; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							echo -e "${m}[-] ${p}File PDF '${file_pdf}' tidak dienkripsi.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file PDF '${file_pdf}' berhasil diekstrak.${r}"
						format="PDF"
						echo -e "${b}[*] ${p}Mengcrack kata sandi file PDF '${file_pdf}'...${r}"
						john --incremental --min-length="${panjang_min}" --max-length="${panjang_maks}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file PDF '${file_pdf}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file PDF '${file_pdf}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file PDF '${file_pdf}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file PDF '${file_pdf}' selesai.${r}"
						continue
					elif [[ "${teknik}" == "Prince Attack" ]]; then
						if [[ "${status_file_wordlist}" == "false" ]]; then
							echo -e "${m}[-] ${p}File Wordlist belum diseting.${r}"
							continue
						fi
						echo -e "${b}[*] ${p}Mengekstrak hash file PDF '${file_pdf}'...${r}"
						file_hash="${file_pdf}_hash.txt"
						pdf2john "${file_pdf}" 1> "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							continue
						fi
						if pdfid "${file_pdf}" | grep -qo "Not a PDF document"; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							echo -e "${m}[-] ${p}File PDF '${file_pdf}' tidak valid atau rusak.${r}"
							continue
						fi
						if pdfinfo "${file_pdf}" | grep -qo "Encrypted:       no"; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							echo -e "${m}[-] ${p}File PDF '${file_pdf}' tidak dienkripsi.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file PDF '${file_pdf}' berhasil diekstrak.${r}"
						format="PDF"
						echo -e "${b}[*] ${p}Mengcrack kata sandi file PDF '${file_pdf}'...${r}"
						john --prince="${file_wordlist}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file PDF '${file_pdf}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file PDF '${file_pdf}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file PDF '${file_pdf}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file PDF '${file_pdf}' selesai.${r}"
						continue
					elif [[ "${teknik}" == "Mask Attack" ]]; then
						if [[ "${status_mask_pattern}" == "false" ]]; then
							echo -e "${m}[-] ${p}Pola mask belum diseting.${r}"
							continue
						fi
						echo -e "${b}[*] ${p}Mengekstrak hash file PDF '${file_pdf}'...${r}"
						file_hash="${file_pdf}_hash.txt"
						pdf2john "${file_pdf}" 1> "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							continue
						fi
						if pdfid "${file_pdf}" | grep -qo "Not a PDF document"; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							echo -e "${m}[-] ${p}File PDF '${file_pdf}' tidak valid atau rusak.${r}"
							continue
						fi
						if pdfinfo "${file_pdf}" | grep -qo "Encrypted:       no"; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							echo -e "${m}[-] ${p}File PDF '${file_pdf}' tidak dienkripsi.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file PDF '${file_pdf}' berhasil diekstrak.${r}"
						format="PDF"
						echo -e "${b}[*] ${p}Mengcrack kata sandi file PDF '${file_pdf}'...${r}"
						john --mask="${mask_pattern}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file PDF '${file_pdf}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file PDF '${file_pdf}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file PDF '${file_pdf}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file PDF '${file_pdf}' selesai.${r}"
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
						echo -e "${b}[*] ${p}Mengekstrak hash file PDF '${file_pdf}'...${r}"
						file_hash="${file_pdf}_hash.txt"
						pdf2john "${file_pdf}" 1> "${file_hash}"
						if [[ $? -ne 0 ]]; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							continue
						fi
						if pdfid "${file_pdf}" | grep -qo "Not a PDF document"; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							echo -e "${m}[-] ${p}File PDF '${file_pdf}' tidak valid atau rusak.${r}"
							continue
						fi
						if pdfinfo "${file_pdf}" | grep -qo "Encrypted:       no"; then
							echo -e "${m}[-] ${p}Hash file PDF '${file_pdf}' gagal diekstrak.${r}"
							echo -e "${m}[-] ${p}File PDF '${file_pdf}' tidak dienkripsi.${r}"
							continue
						fi
						echo -e "${h}[+] ${p}Hash file PDF '${file_pdf}' berhasil diekstrak.${r}"
						format="PDF"
						echo -e "${b}[*] ${p}Mengcrack kata sandi file PDF '${file_pdf}'...${r}"
						john --subsets="${charset}" --min-length="${panjang_min}" --max-length="${panjang_maks}" "${file_hash}" --pot="pot.txt" --format="${format}" --progress-every=1 --verbosity=6
						john --show "${file_hash}" --pot="pot.txt" --format="${format}"
						if [[ -f "pot.txt" ]]; then
							if grep -qo ":" "pot.txt"; then
								kata_sandi=$(cat "pot.txt" | cut -d ':' -f 2)
								echo -e "${h}[+] ${p}Kata sandi file PDF '${file_pdf}' ditemukan.${r}"
								echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi}${r}"
							else
								echo -e "${m}[-] ${p}Kata sandi file PDF '${file_pdf}' tidak ditemukan.${r}"
							fi
						else
							echo -e "${m}[-] ${p}File 'pot.txt' tidak ditemukan.${r}"
							echo -e "${m}[-] ${p}Kata sandi file PDF '${file_pdf}' tidak ditemukan.${r}"
						fi
						rm "pot.txt" "${file_hash}"
						echo -e "${b}[*] ${p}Proses crack kata sandi file PDF '${file_pdf}' selesai.${r}"
						continue
					fi
				fi
			elif [[ "${pdf_c[0]}" == "back" ]]; then
				if [[ -f "rcrack.sh" ]]; then
					bash "rcrack.sh"
					break
				else
					echo -e "${m}[-] ${p}File 'rcrack.sh' tidak ditemukan.${r}"
					continue
				fi
			elif [[ "${pdf_c[0]}" == "help" ]]; then
				help
				continue
			elif [[ "${pdf_c[0]}" == "clear" ]]; then
				clear
				continue
			elif [[ "${pdf_c[0]}" == "banner" ]]; then
				if [[ -f "script/banner.py" ]]; then
					python3 "script/banner.py"
					continue
				else
					echo -e "${m}[-] ${p}File 'script/banner.py' tidak ditemukan.${r}"
					continue
				fi
			elif [[ "${pdf_c[0]}" == "version" ]]; then
				echo -e "${p}${versi}${r}"
				continue
			elif [[ "${pdf_c[0]}" == "exit" ]]; then
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

pdf_crack
