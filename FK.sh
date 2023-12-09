#!/data/data/com.termux/files/usr/bash

red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
reset='\033[0m'

is_package_installed() { dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -c "Ok Installed"; }
check_internet() { ping -q -c 1 -W 1 google.com &>/dev/null; }

termux-setup-storage

if [ $? -eq 0 ]; then
    echo -e "${green}Storage Permission Granted.${reset}"

    essential_packages=("python" "python2" "ruby" "git" "php" "perl" "nmap" "bash" "clang" "python3" "macchanger" "nano" "curl" "tar" "unzip" "wget" "wcalc" "openssl" "bmon" "openssh" "proot" "man" "htop" "vim" "tmux" "fish" "neofetch" "figlet")

    echo -e "${green}Checking And Installing Essential Packages...${reset}"

    if check_internet; then
        echo -e "${green}Internet Connection Is Active.${reset}"

        for package in "${essential_packages[@]}"; do
            if is_package_installed "$package"; then
                echo -e "${yellow}Package '$package' is Already Installed. Skipping.${reset}"
            else
                echo -e "${green}Installing Package: $package...${reset}"
                pkg install "$package" -y
                [ $? -eq 0 ] && echo -e "${green}Package '$package' Installed Successfully.${reset}" || echo -e "${red}Failed to Install '$package'.${reset}"
            fi
        done

        echo -e "${red}###########################################"
        echo -e "#                Code By FlashKiss		 #"
        echo -e "#          https://github.com/flashkiss	 #"
        echo -e "#########################################${reset}"

        sleep 4

        clear
        echo -e "${green}Screnn Will Auto-Clear In 5 Seconds...${reset}"
        sleep 3
        clear

        total_storage_used=$(du -sh /data/data/com.termux/files/usr | awk '{print $1}')
        echo -e "${green}Total Storage Used By Installed Packages: $total_storage_used${reset}"

    else
        echo -e "${red}Internet Connection Error. Please Check Your Network Settings.${reset}"
    fi

else
    echo -e "${red}Storage Permission Not Granted. Please Give Storage Permission To Install Packages.${reset}"
fi

exit

