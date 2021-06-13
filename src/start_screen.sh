#!/bin/bash

home_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source "${home_dir}/print_colors.sh"
source "${home_dir}/resources/unicode_emojis.sh"

type_message() {
    local message="${1}"

    cols=`tput cols`
    
    for ((i=0; i<${#message}; i++))
    do
        echo "after 30" | tclsh
        printf "${message:$i:1}"  | fold -w "$cols" -s
    done
    
    echo
}

start_screen() {
    clear
    
    cols=`tput cols`
    border=""
    
    for ((i=0; i < $cols; i++))
    do
        border="$border#"
    done
    
    echo "$border"
    echo
    print_green "  ${BOLD}The${NORMAL}"
    echo
    print_green "      ##########"
    print_green "      ##             ${fairy}          ${fairy}     ####      ######"
    print_green "      ######              # ###       ##    ##    ##"
    print_green "      ##     #### #   #   ##   #  #   ########    ######"
    print_green "      ##    #    ##   #   #       #   ##              ##"
    print_green "      ##     ###  #   #   #       #     ##        #####"
    echo
    echo
    echo "$border"
    echo
    read -p "           Press [Enter] to begin" fackEnterKey
    echo
}

run_start_screen() {
    message="
    Up the airy mountain,
    Down the rushy glen,
    We daren’t go a-hunting
    For fear of little men ${fairy}"

    clear
    
    cols=`tput cols`
    border=""
    
    for ((i=0; i < $cols; i++))
    do
        border="$border#"
    done
    
    echo "$border"
    echo
    type_message "${message}" 
    echo
    echo
    echo "$border"
    echo
    sleep 1
    read -p "Press [Enter] key to continue..." fackEnterKey
    
    start_screen
}