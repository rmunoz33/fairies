#!/bin/bash

home_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

###########
# Functions
###########

download_iterm_if_needed() {
    # Check to see if iTerm2 is installed
    iterm_app_name="iTerm.app"
    
    open_iterm_output=`mdfind "kMDItemCFBundleIdentifier == com.googlecode.iterm2"`
    
    if [ ! "${open_iterm_output}" == "/Applications/iTerm.app" ]
    then
        echo "You must install iTerm2 first. Would you like our fairies to do that for you? (y/n)"
        read install_iterm_bool
        
        install_iterm_bool_lower=`echo "${install_iterm_bool}" | tr '[:upper:]' '[:lower:]'`
        if [[ "${install_iterm_bool_lower}" == "y"* ]]
        then
            echo "Installing iTerm2 now. Please be patient..."
            brew install --cask iterm2
        else
            echo "As you wish. Haste ye back!"
            exit 0
        fi
    fi
}

apple_script_to_run_game_in_iterm() {
    echo "running applescipt"
    bash "${home_dir}/start_game.sh" 
}

############
# Executions
############

download_iterm_if_needed
# TODO: figure out how to get it to close iTerm before opening it to run next command 
apple_script_to_run_game_in_iterm
