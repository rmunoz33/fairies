#!/bin/bash

home_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

play_music_bowerlake() {
    killall afplay    
    afplay "${home_dir}/resources/audio/bowerlake.mp3" &
}
