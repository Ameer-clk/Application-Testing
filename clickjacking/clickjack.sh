#!/bin/bash
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
#Coded By Ameer Ali
function banner(){
echo -e ${CP}"  ____ _ _      _          _            _    _             #"
echo -e ${CP}" / ___| (_) ___| | __     | | __ _  ___| | _(_)_ __   __ _    #"
echo -e ${CP}"| |   | | |/ __| |/ /  _  | |/ _\` |/ __| |/ / | '_ \ / _\`|     #"
echo -e ${CP}"| |___| | | (__|   <  | |_| | (_| | (__|   <| | | | | (_| |         #"
echo -e ${CP}" \____|_|_|\___|_|\_\  \___/ \__,_|\___|_|\_\_|_| |_|\__, |           #"
echo -e ${CP}"                                                     |___/               #"
echo -e ${CNC}"        A Simple Tool To Find ClickJacking Vulnerability With POC          #"
echo -e ${YELLOW}"                         Coded By: Ameer Ali                              #"
echo -e ${CP}"                 github: https://github.com/Ameer-clk                           #"
echo -e ${CP}"                                                                                   #"
echo -e ${RED}"#############################################################################\n "
}

function single_url(){
clear
banner
echo -e -n ${BLUE}"\n[+] Enter domain name (e.g http|https://target.com/) : "
read  url
check=$(curl -s -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/81.0" --connect-timeout 5 --head $url ) 
echo "$check" >> temp.txt
sami=$(cat temp.txt | egrep -w 'X-Frame-Options|Content-Security-Policy|x-frame-options|content-security-policy:' )


if [[ $sami = '' ]];
then
echo -e -n "\n[ ✔ ] ${NC}$url ${RED}VULNERABLE \n"
sleep 1
echo -e -n ${BLUE}"\nDo U Want To Open POC In Browser: [y/n]: "
read back_press
if [ $back_press = "y"  ]; then
if [ -f vuln.html ]; then
#echo -e -n ${RED}"[*] Old Vuln.html File Found! Removing Old File! " 
rm vuln.html
fi
if [ -f poc.html ];
then
cat poc.html | sed "s|vuln|$url|" >> vuln.html
open vuln.html
rm temp.txt

else
 echo -e -n ${RED}"[ X ] POC File Not Found! Exiting"    
 exit
fi
elif [ $back_press = "n" ]; then
echo -e -n ${CP}"[+] POC Saved As Vuln.html"
rm temp.txt
cat poc.html | sed "s|vuln|$url|" >> vuln.html
sleep 1
              exit
     fi

else


echo -e -n ${CP}"\n[ X ] $url ${CG}NOT VULNERABLE "
fi
}

function mul_url(){
clear
banner
echo -e -n ${CP}"\n[+] Enter path of lists (e.g http|https://target.com/) : "
read  urls
for sanga in $(cat $urls);
do
res=$(curl -s -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/81.0" --connect-timeout 5 --head $sanga )
echo "$res" >> temp.txt

sami=$(cat temp.txt | egrep -w 'X-Frame-Options|Content-Security-Policy|x-frame-options|content-security-policy:' )

if [[ $sami = '' ]];
then



echo -e -n ${BLUE2}"\n[ ✔ ] ${CG}$sanga ${RED}VULNERABLE \n" 
echo "$sanga" >> vulnerable_urls.txt
else

echo -e -n ${CP}"\n[ X ] ${NC}$sanga ${YELLOW}NOT VULNERABLE "
fi

done
rm temp.txt
}
trap ctrl_c INT
ctrl_c() {
clear
echo -e ${RED}"[*] (Ctrl + C ) Detected, Trying To Exit... "
echo -e ${RED}"[*] Stopping Services... "
if [ -f temp.txt ]; then
rm temp.txt
fi
sleep 1
echo ""
echo -e ${YELLOW}"[*] Thanks For Using CLICK-J1CK3R  :)"
exit
}

menu()
{
clear
banner
echo -e ${YELLOW}"\n[*] Choose Scanning Type: \n "
echo -e "  ${NC}[${CG}"1"${NC}]${CNC} Single Domain Scan"
echo -e "  ${NC}[${CG}"2"${NC}]${CNC} Multiple Domains Scan"
echo -e "  ${NC}[${CG}"3"${NC}]${CNC} Exit"

echo -n -e ${YELLOW}"\n[+] Select: "
        read redi_play
                if [ $redi_play -eq 1 ]; then
                        single_url
                elif [ $redi_play -eq 2 ]; then
                        mul_url
                elif [ $redi_play -eq 3 ]; then
                      exit
                fi
}
menu
#Coded By Ameer Ali
