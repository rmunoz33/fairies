#!/bin/bash

home_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

###############
# Sourced Files
###############

source "${home_dir}/background_music.sh"
source "${home_dir}/scene.sh"

###########
# Functions
###########

setup_window() {
    # set terminal window to 100x500 characters
    printf '\e[8;50;100t'
    # move terminal window to top/left corner of the display
    printf '\e[3;0;0t'
}

run_scene() {
    while true
    do
        clear
        "${1}"
    done
}

############
# Executions
############
play_music_bowerlake

run_scene "scene_1_intro"
