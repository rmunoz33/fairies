#!/bin/bash

source "./unicode_emojis.sh"

loading_fairy() {
    cols=`tput cols`
    cols=$((${cols} - 1))
    
    fairy_path="${fairy}"
    
    for ((i=0; i < $cols; i++))
    do
        echo -en "\r${fairy_path}"
        fairy_path=" ${fairy_path}"
        sleep .05
    done
    
    echo -en "\r"
}