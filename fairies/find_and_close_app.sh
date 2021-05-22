#!/bin/bash

app_name="${1}"

# Create temporary directory
scratch=$(mktemp -d -t tmp.XXXXXXXXXX)
function cleanup {
    rm -rf "${scratch}"
}
trap cleanup EXIT

ps -ax | grep "${app_name}" > "${scratch}"/iterm_pid.txt

while IFS= read -r line
do
    if [[ "${line}" == *"??"* ]] && [[ "${line}" == *"Applications"* ]]
    then
        pid=`echo "${line}" | cut -d" " -f 1`
        kill "${pid}"
    fi
done < "${scratch}"/iterm_pid.txt
