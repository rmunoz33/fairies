#!/bin/bash

home_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source "${home_dir}/print_colors.sh"
source "${home_dir}/resources/unicode_emojis.sh"

start_screen() {
    clear
    
    cols=$(tput cols)
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
    print_green "      ##     ###  #   #   #       $     ##        #####"
    echo
    echo
    echo "$border"
    echo
    read -p "           Press [Enter] to begin" fackEnterKey
    echo
}
