#!/bin/bash

echo "[*] Menginstal dependensi yang diperlukan..."

daftar_dependensi=(
        "python3"
        "python3-colorama"
        "john"
        "john-data"
        "poppler-utils"
        "pdfid"
)

apt-get update

for dependensi in "${daftar_dependensi[@]}"; do
        apt-get install "${dependensi}"
done

echo "[+] Selesai."
