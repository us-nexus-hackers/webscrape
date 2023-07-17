#!/bin/bash

Black="\e[1;90m"
Red="\e[1;91m"
Green="\e[1;92m"
Yellow="\e[1;93m"
Blue="\e[1;94m"
Purple="\e[1;95m"
White="\e[1;97m"
clear
banner () {
echo -e "
   
${Red}╭╮╱╭┳━━━╮╭━╮╱╭┳━━━┳━╮╭━┳╮╱╭┳━━━╮
${Red}┃┃╱┃┃╭━╮┃┃┃╰╮┃┃╭━━┻╮╰╯╭┫┃╱┃┃╭━╮┃
${Red}┃┃╱┃┃╰━━╮┃╭╮╰╯┃╰━━╮╰╮╭╯┃┃╱┃┃╰━━╮
${Red}┃┃╱┃┣━━╮┃┃┃╰╮┃┃╭━━╯╭╯╰╮┃┃╱┃┣━━╮┃
${Red}┃╰━╯┃╰━╯┃┃┃╱┃┃┃╰━━┳╯╭╮╰┫╰━╯┃╰━╯┃
${Red}╰━━━┻━━━╯╰╯╱╰━┻━━━┻━╯╰━┻━━━┻━━━╯ 
                                                                                                                  "
printf "\n\e[1;77m     A web scraper to get emails and phone numbers from websites      \e[0m\n\n"
printf "\n\e[1;77m    এই টুলস এর মাধ্যমে আপনারা যে কোনো ওয়েবসাইট এর ফোন নম্বর আর ইমেইল পাবেন    \e[0m\n\n"
echo -e "\e[0;96m                Developed by: ${Red}USNEXUSCYBER(t.me/usnexushacker)\n\n\n"                      
#echo -e "\e[0;96m                     Version: ${Red}0.58 Stable\n\n\n"                  
}
scanner () {
sleep 0.5
read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Enter URL to begin : \e[1;97m' url
url_validity='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
if [[ $url =~ $url_validity ]]
then 
read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Scrape emails from website (y/n) : \e[1;97m' email
read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Scrape phone numbers from website (y/n) : \e[1;97m' phone
if [ "$email" = "Y" ] || [ "$email" = "y" ] || [ "$phone" = "Y" ] || [ "$phone" = "y" ]; then
echo -e "$White[${Red}!$White] ${Red}Scraping started"
scraper
fi
sleep 0.4
echo -e "$White[${Red}!$White] ${Red}Exiting....\n"
exit
else
echo -e "$White[$Red!$White] ${Red}Check your url (invalid)"
scanner
fi
}
scraper () {
curl -s $url > temp.txt
if [ "$email" = "Y" ] || [ "$email" = "y" ]; then
email_scraping
fi
if [ "$phone" = "Y" ] || [ "$phone" = "y" ]; then
phone_scraping
fi
rm temp.txt
if [[ -f "email.txt" ]] || [[ -f "phone.txt" ]] ; then
sleep 0.4
read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Do you want to save the output (y/n) : \e[1;97m' save_output
if [ "$save_output" = "Y" ] || [ "$save_output" = "y" ]; then
output
fi
fi
sleep 0.4
echo -e "$White[${Red}!$White] ${Red}Exiting....\n"
rm email.txt phone.txt 2> /dev/null 
exit
}
email_scraping () {
grep -i -o '[A-Z0-9._%+-]\+@[A-Z0-9.-]\+\.[A-Z]\{2,4\}' temp.txt | sort -u > email.txt
if [[ -s email.txt ]]; then
echo -e "$White[${Yellow}*$White] ${Yellow}Emails success${White}"
cat email.txt
else 
echo -e "$White[${Red}!$White] ${Red}No Emails found"
rm email.txt
fi
}
phone_scraping () {
grep -o '\([0-9]\{3\}\-[0-9]\{3\}\-[0-9]\{4\}\)\|\(([0-9]\{3\})[0-9]\{3\}\-[0-9]\{4\}\)\|\([0-9]\{10\}\)\|\([0-9]\{3\}\s[0-9]\{3\}\s[0-9]\{4\}\)' temp.txt | sort -u > phone.txt
if [[ -s phone.txt ]]; then
echo -e "$White[${Yellow}*$White] ${Yellow}Phone numbers success${White}"
cat phone.txt
else 
echo -e "$White[${Red}!$White] ${Red}No phone numbers found"
rm phone.txt
fi
}
output () {
sleep 0.4
read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Enter folder name : \e[1;97m' folder_name
if [ -d "$folder_name" ] 
then
echo -e "$White[${Red}!$White] ${Red}Folder already exists"
output
fi
mkdir $folder_name
mv email.txt $folder_name 2> /dev/null
mv phone.txt $folder_name 2> /dev/null
sleep 0.3
echo -e "$White[${Green}*$White] ${Yellow}Output saved"
sleep 0.4
echo -e "$White[${Red}!$White] ${Red}Exiting....\n"
exit
}
internet () {
sleep 0.5
echo -e "$White[$Red!$White] ${Red}Checking internet connection TEAM NEXUS"
wget -q --spider http://google.com
if [ $? -eq 0 ]; then
echo -e "$White[$Yellow*$White] ${Yellow}Connected TEAM NEXUS"
else
sleep 0.5
echo -e "$White[$Red!$White] ${Red}No internet try later TEAM NEXUS"
exit 
fi
}
banner
internet
scanner