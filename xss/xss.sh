#!/bin/bash

# Colors
NC='\033[0m'
RED='\033[1;38;5;196m'
GREEN='\033[1;38;5;040m'
ORANGE='\033[1;38;5;202m'
BLUE='\033[1;38;5;012m'
BLUE2='\033[1;38;5;032m'
PINK='\033[1;38;5;013m'
GRAY='\033[1;38;5;004m'
NEW='\033[1;38;5;154m'
YELLOW='\033[1;38;5;214m'
CG='\033[1;38;5;087m'
CP='\033[1;38;5;221m'
CPO='\033[1;38;5;205m'
CN='\033[1;38;5;247m'
CNC='\033[1;38;5;051m'

# Coded by Ameer Ali
# Banner function
function banner() {
    echo -e "${CP}                                                                        #"
    echo -e "${CP}                                                                        #"
    echo -e "${CP}                             ██╗  ██╗███████╗███████╗               #"
    echo -e "${CP}                             ╚██╗██╔╝██╔════╝██╔════╝               #"
    echo -e "${CP}                              ╚███╔╝ ███████╗███████╗               #"
    echo -e "${CP}                              ██╔██╗ ╚════██║╚════██║               #"
    echo -e "${CP}                             ██╔╝ ██╗███████║███████║               #"
    echo -e "${CP}                             ╚═╝  ╚═╝╚══════╝╚══════╝               #"
    echo -e "${CNC}                       A Tool To Find XSS Vulnerability                        #"
    echo -e "${GREEN}                           Coded By: Ameer Ali                        #"
    echo -e "${CP}                Follow me: Github: https://github.com/Ameer-clk         #"
    echo -e "${CP}                                                                        #"
    echo -e "${RED}#######################################################################\n "
}

# Scan single domain function
function scan_single_domain() {
    local url
    clear
    banner
    echo -e -n "${BLUE}Enter domain name (e.g http|https://target.com/): "
    read -r url

    local response=$(curl -s -I -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/81.0" --connect-timeout 5 "$url")
    echo -e "$response" >> temp.txt

    if grep -q -E '(X-Frame-Options|Content-Security-Policy|x-frame-options|content-security-policy):' temp.txt; then
        echo -e -n "\n${BLUE}[+] $url ${RED}VULNERABLE\n"
        #... (rest of the code remains the same)
    else
        echo -e -n "${CP}\n[ X ] $url ${YELLOW}NOT VULNERABLE\n"
    fi
}

# Scan multiple domains function
function scan_multiple_domains() {
    clear
    banner
    echo -e -n "${CP}\n[+] Enter path of list (e.g http|https://target.com/): "
    read urls

    for url in $(cat "$urls"); do
        response=$(curl -s -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/81.0" --connect-timeout 5 --head "$url")
        echo "$response" >> temp.txt

        if grep -q -w 'X-Frame-Options|Content-Security-Policy|x-frame-options|content-security-policy:' temp.txt; then
            echo -e -n "${BLUE2}\n[ X ] $url ${YELLOW}NOT VULNERABLE\n"
        else
            echo -e -n "${BLUE2}\n[ ✔ ] $url ${RED}VULNERABLE\n"
            echo "$url" >> vulnerable_urls.txt
        fi
    done

    rm temp.txt
}

# Scan URLs from a file function
function scan_urls_from_file() {
    clear
    banner
    echo -e -n "${CP}\n[+] Enter path of URL list file: "
    read urls_file

    if [ ! -f "$urls_file" ]; then
        echo -e "${RED}[-] File not found: $urls_file"
        sleep 2
        return
    fi

    while IFS= read -r url; do
        response=$(curl -s -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/81.0" --connect-timeout 5 --head "$url")
        echo "$response" >> temp.txt

        if grep -q -w 'X-Frame-Options|Content-Security-Policy|x-frame-options|content-security-policy:' temp.txt; then
            echo -e -n "${BLUE2}\n[ X ] $url ${YELLOW}NOT VULNERABLE\n"
        else
            echo -e -n "${BLUE2}\n[ ✔ ] $url ${RED}VULNERABLE\n"
            echo "$url" >> vulnerable_urls.txt
        fi
    done < "$urls_file"

    rm temp.txt
}


# Trap Ctrl+C
trap ctrl_c INT

function ctrl_c() {
    clear
    echo -e "${RED}[*] (Ctrl + C) Detected, Trying To Exit... "
    echo -e "${RED}[*] Stopping Services... "
    if [ -f temp.txt ]; then
        rm temp.txt
    fi
    sleep 1
    echo ""
    echo -e "${YELLOW}[*] Thanks For Using XSSCkecker :)\n"
    exit
}

# Main menu function
function main_menu() {
    clear
    banner
    echo -e "${YELLOW}\n[*] Choose Scanning Type: \n "
    echo -e "  ${NC}[${CG}1${NC}]${CNC} Single Domain Scan"
    echo -e "  ${NC}[${CG}2${NC}]${CNC} Multiple Domains Scan"
    echo -e "  ${NC}[${CG}3${NC}]${CNC} Scan URLs from a file"
    echo -e "  ${NC}[${CG}4${NC}]${CNC} Exit\n"

    echo -n -e "${YELLOW}[+] Select: "
    read menu_choice

    if [ "$menu_choice" -eq 1 ]; then
        scan_single_domain
    elif [ "$menu_choice" -eq 2 ]; then
        scan_multiple_domains
    elif [ "$menu_choice" -eq 3 ]; then
        scan_urls_from_file
    elif [ "$menu_choice" -eq 4 ]; then
        exit
    fi
}

main_menu
#Coded by Ameer Ali
