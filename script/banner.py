#!/usr/bin/env python3
# -- / / --
#
#.......: banner.py
#.......: buat bikin banner script rcrack.sh
#.......: (pembuat banner)
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

import random
from colorama import Fore, Style

h = Fore.LIGHTGREEN_EX
b = Fore.LIGHTBLUE_EX
p = Fore.LIGHTWHITE_EX
r = Style.RESET_ALL

program = "rcrack"
deskripsi = "Crack berbagai jenis file menggunakan John The Ripper"
versi = "v1.0"
github = "https://github.com/fixploit03/rcrack"
pembuat = "Rofi (Fixploit03)"
by = "John The Ripper (https://github.com/openwall/john)"

daftar_banner = [
f"""{h}
**********************************************************************
*                                                                    *
* {p}{program}                                                             {h}*
* {p}{deskripsi}              {h}*
* {p}Versi: {versi}                                                        {h}*
* {p}Github: {github}                       {h}*
* {p}Dibuat oleh: {pembuat}                                     {h}*
*                                                                    *
* {p}Ditenagai oleh: {by} {h}*
*                                                                    *
**********************************************************************
{r}""",
f"""
{p}===========================================================
       {b}[*] {p}Sedang crack password...

       {h}[+] {p}Password ditemukan: {h}+-------------------+
                               {h}| 01100001 01100100 |
                               {h}| 01101101 01101001 |
                               {h}| 01101110 00110001 |
                               {h}| 00110010 00110011 |
                               {h}+-------------------+

       {h}[+] {p}Clear password: {h}admin123
{p}===========================================================
"""]

print(random.choice(daftar_banner))
