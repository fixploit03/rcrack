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

m = Fore.LIGHTRED_EX
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
f"""
{h}**********************************************************************{r}
{h}*                                                                    *{r}
{h}* {p}{program}                                                             {h}*{r}
{h}* {p}{deskripsi}              {h}*{r}
{h}* {p}Versi: {versi}                                                        {h}*{r}
{h}* {p}Github: {github}                       {h}*{r}
{h}* {p}Dibuat oleh: {pembuat}                                     {h}*{r}
{h}*                                                                    *{r}
{h}* {p}Ditenagai oleh: {by} {h}*{r}
{h}*                                                                    *{r}
{h}**********************************************************************{r}
""",
f"""
{p}==========================================================={r}
       {b}[*] {p}Sedang crack password...{r}
{r}
       {h}[+] {p}Password ditemukan: {h}+-------------------+{r}
                               {h}| 01100001 01100100 |{r}
                               {h}| 01101101 01101001 |{r}
                               {h}| 01101110 00110001 |{r}
                               {h}| 00110010 00110011 |{r}
                               {h}+-------------------+{r}
{r}
       {h}[+] {p}Clear password: {h}admin123{r}
{p}==========================================================={r}
""",
f"""
{m}                                                oooo       {r}
{m}                                                 888       {r}
{m}oooo d8b   ooooo   oooo d8b   oooo      ooooo    888  oooo {r}
{m} 888  8P d88    Y8  888  8P  P  )88b  d88    Y8  888  8P   {r}
{m} 888     888        888       oP 888  888        888888    {r}
{m} 888     888    o8  888     d8(  888  888    o8  888  88b  {r}
{m}d888b     Y8bod8P  d888b     Y888888o  Y8bod8P  o888o o888o {h}{versi}{r}
{r}
{b}[*] {p}{deskripsi}{r}
{b}[*] {p}Dibuat oleh: {pembuat}{r}
{b}[*] {p}Github: {github}{r}
"""]

print(random.choice(daftar_banner))
