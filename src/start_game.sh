#!/bin/bash

home_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

a_script="tell application \"iTerm2\"
set newWindow to (create window with default profile)
tell current session of newWindow
write text \"bash ${home_dir}/run_game.sh\"
end tell
end tell"

echo "${a_script}" | osascript &>/dev/null
