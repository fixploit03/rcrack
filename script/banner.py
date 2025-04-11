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

m = Fore.LIGHTRED_EX    # merah
h = Fore.LIGHTGREEN_EX  # hijau
k = Fore.LIGHTYELLOW_EX # kuning
b = Fore.LIGHTBLUE_EX   # biru
p = Fore.LIGHTWHITE_EX  # putih
c = "\033[38;5;130m"    # cokelat
a = "\033[38;5;240m"    # abu-abu
cy = Fore.LIGHTCYAN_EX  # cyan
r = Style.RESET_ALL     # reset

program = "rcrack"
deskripsi = "Crack berbagai jenis file menggunakan John The Ripper"
versi = "v1.0"
github = "https://github.com/fixploit03/rcrack"
pembuat = "Rofi (Fixploit03)"
by = "John The Ripper (https://github.com/openwall/john)"

daftar_banner = [
fr"""
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
fr"""
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
fr"""
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
""",
fr"""
{m}          .                                                      .{r}
{m}        .n                   .                 .                  n.{r}
{m}  .   .dP                  dP                   9b                 9b.    .{r}
{m} 4    qXb         .       dX                     Xb       .        dXp     t{r}
{m}dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb{r}
{m}9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP{r}
{m} 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP{r}
{m}  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'{r}
{m}    `9XXXXXXXXXXXP' `9XX'          `98v8P'          `XXP' `9XXXXXXXXXXXP'{r}
{m}        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~{r}
{m}                        )b.  .dbo.dP'`v'`9b.odb.  .dX({r}
{m}                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.{r}
{m}                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb{r}
{m}                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb{r}
{m}                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP{r}
{m}                     `'      9XXXXXX(   )XXXXXXP      `'{r}
{m}                              XXXX X.`v'.X XXXX{r}
{m}                              XP^X'`b   d'`X^XX{r}
{m}                              X. 9  `   '  P )X{r}
{m}                              `b  `       '  d'{r}
{m}                               `             '{r}
{m}
{b}   * {h}){k}--{h}(+) {p}Crack berbagai jenis file menggunakan John The Ripper {h}(+){k}--{h}( {b}*{r}
{b}   * {h}){k}--------------{h}(+) {p}Dibuat oleh: Rofi (Fixploit03) {h}(+){k}-------------{h}( {b}*{r}
{b}   * {h}){k}-----------------------{h}(+) {p}Versi: v1.0 {h}(+){k}-----------------------{h}( {b}*{r}
{b}   * {h}){k}-------{h}(+) {p}Github: https://github.com/fixploit03/rcrack {h}(+){k}------{h}( {b}*{r}
""",
fr"""
{b}       __I__{r}
{b}   .-'"  .  "'-.{r}
{b} .'  / . ' . \  '.{r}
{b}/_.-..-..-..-..-._\ {p}.----------------------------------.{r}
{b}         #{c}  _,,_   {p}( Kudengar hari ini akan turun hujan ){r}
{b}         #{c}/`    `\ {p}/'----------------------------------'{r}
{k}         {c}/ / {p}6 6{c}\ \{r}
{k}         {c}\/\  {a}Y{c} /\/       {a}/\-/\{r}
{b}         #{c}/ `'{m}U{c}` \       {a}/{p}a a  {a}\               _{r}
{k}       {c}, (  \   | \     {a}=\ {a}Y{a}  =/-~~~~~~-,_____/ ){r}
{k}       {c}|\|\_/{b}#  {c}\_/       {a}'{m}^{a}--'          ______/{r}
{k}       {c}\/'.  \  /'\         {a}\           /{r}
{k}        {c}\    /=\  /         {a}||  |---'\  \{r}
{k}        {c}/____)/____)       {a}(_(__|   ((__| {h}{program} {versi}{r}
{p}-------------------------------------------------------------{r}
""",
fr"""
{a}                 .'\ _ _ /`.{r}
{a}                |           |{r}
{a}               |             |{r}
{a}               |             |{r}
{a}               |             |{r}
{a}               |             |{r}
{a}               |{m}_  _  _  _  _{a}|       {h}Halo Teman!{r}
{a}               |             |       {h}Saya Otong surotong.{r}
{a}           \{m}= = = = = = = = = = ={a}/{r}
{c}               :             :{r}
{c}           ..._:   .-. .-.   :_...{r}
{c}         .'    '-.({p}o {c}) ({p}o {c}).-'    `.{r}
{c}        :  _    _ _`~(_)~`_ _    _  :{r}
{c}       :  /{p}:   {c}' .-=_   _=-. `   {p};{c}\  :{r}
{c}       :   {p}:|-.._  {c}'     `  {p}_..-|:   {c}:{r}
{c}        :   {p}`:| |`:-:-.-:-:'| |:'   {c}:{r}
{c}         `.   {p}`.| | | | | | |.'   {c}.'{r}
{c}           `.   {p}`-:_| | |_:-'   {c}.'{r}
{c}             `-._   {p}````    {c}_.-'{r}
{c}                 ``-------''{r}
""",
fr"""
{m}#############################################################{r}
{m}#{p}...........................................................{m}#{r}
{m}#{p}............................{b}YAao,{p}..........................{m}#{r}
{m}#{p}.............................{b}Y8888b,{p}.......................{m}#{r}
{m}#{p}...........................{b},oA888888b,{p}.....................{m}#{r}
{m}#{p}.................. {b}_,aaad8888888888888888bo,{p}...............{m}#{r}
{m}#{p}.{cy}HHHHb.dHHHb.HH..{b},|{cy}....{b}`8{cy}..{b}H{cy}..{b}8{cy}..{b}8{cy}...{b}V{cy}..{b}8888888b,{p}..........{m}#{r}
{m}#{p}.{cy}HH.HH.HH.HH.HH.{b},88{cy}..{b}D{cy}..{b}8{cy}..{b}H{cy}..{b}8{cy}..{b}8{cy}......{b}8888888888b,{p}.......{m}#{r}
{m}#{p}.{cy}HH.HH.HH.HH.HH{b},888{cy}....{b},8{cy}.....{b}8{cy}..{b}8{cy}..{b}h{cy}...{b}8888888888888,{p}.....{m}#{r}
{m}#{p}.{cy}HHHHV.VHHHV.P{b}.{cy}...{b}8{cy}..{b}8888{cy}__{b}H{cy}__{b}8{cy}__{b}8{cy}__{b}Ha{cy}__{b}88888888888888b{p}....{m}#{r}
{m}#{p}.............{b}d888888P'{p}....................{b}`Y888888888888,{p}..{m}#{r}
{m}#{p}.............{b}88888P'{p}....................{b}Ybaaaa8888888888b{p}..{m}#{r}
{m}#{p}............{b}a8888'{p}......................{b}`Y8888P'{p}.{b}`V888888{p}..{m}#{r}
{m}#{p}..........{b}d8888888a{p}................................{b}`Y8888{p}..{m}#{r}
{m}#{p}.........{b}AY/'{p}..{b}`\Y8b{p}.................................{b}``Y8b{p}.{m}#{r}
{m}#{p}.........{b}Y'{p}......{b}`YP{p}.......................................{m}#{r}
{m}#{p}..................{b}`'{p}.......................................{m}#{r}
{m}########################################################GGN94{m}
""",
fr"""
{c} __________________________________{r}
{c}/                                  \{r}
{c}|     {p}Selamat datang di {program}     {c}|{r}
{c}|           {h}Versi: {versi}            {c}|{r}
{c}\__________________________________/{r}
{c}                !  !{r}
{c}                !  !{r}
{c}                L{k}_ {c}!{r}
{k}               / _){c}!{r}
{k}              / /__{c}L{r}
{k}        _____/ (____){r}
{k}               (____){r}
{k}        _____  (____){r}
{k}             \_(____){r}
{c}                !  !{r}
{c}                !  !{r}
{c}                \__/{r}
"""
]

print(random.choice(daftar_banner))
