#!/bin/bash

home_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source "${home_dir}/resources/unicode_emojis.sh"

# All scenes have four (4) parts:
#     clear
#     A message that narrates what's happening
#     A question, giving the user a choice
#     Actions (at least 1; no more than 3) for the user to choose from (or the carry_on function)

message() {
    local message="${1}"
    
    echo "#############################################################################"
    echo
    echo "${message}" | fold -w 80 -s
    echo
    echo
    echo "#############################################################################"
    echo
}

question() {
    local question="${1}"
    
    echo "${question}" | fold -w 80 -s
    echo
}

carry_on() {
    read -p "Press [Enter] key to continue..." fackEnterKey
}

actions() {
    local answer_1="${1}"
    local answer_2="${2}"
    local answer_3="${3}"
    
    answer_array=()
    answer_array+=("${answer_1}")
    
    if [ ! -z "${answer_2}" ]
    then
        answer_array+=("${answer_2}")
    fi
    
    if [ ! -z "${answer_3}" ]
    then
        answer_array+=("${answer_3}")
    fi
    
    answer_array+=("Leave Game")
    
    select final_answer in "${answer_array[@]}"
    do
        if [[ "${final_answer}" == "Leave Game" ]]
        then
            exit_game
        else
            next_scene=`echo "${final_answer}" | tr '[:upper:]' '[:lower:]' | tr ' ' '_'`
            eval "$next_scene=$next_scene"
            "$next_scene"
            break
        fi
    done
}

exit_game() {
    killall afplay
    clear
    exit 0
}

trap exit_game EXIT

# ######
# scenes
# ######

scene_1_intro() {
    local message="
    Up the airy mountain,
    Down the rushy glen,
    We daren’t go a-hunting
    For fear of little men ${fairy}"
    
    local question="Are you sure you want to enter?"
    
    clear
    message "${message}"
    question "${question}"
    actions "Enter the game" "Run away" "What is this"
}

enter_the_game() {
    clear
    local message="You've entered the game. Good luck!"

    message "${message}"
    carry_on
    exit_game
}

run_away() {
    clear
    local message="You ran away, you coward! Probably for the best though."

    message "${message}"
    carry_on
    exit_game
}

what_is_this() {
    clear
    local message="Why are you even here?"

    message "${message}"
    carry_on
    exit_game
}

scene_1_intro