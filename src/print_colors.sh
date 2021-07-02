#!/bin/bash

# Color variables
YELLOW='\033[1;33m'
RED="\033[0;31m"
GREEN="\033[0;32m"
LIGHT_RED="\033[1;31m"
LIGHT_GREEN="\033[1;32m"
NO_COLOR="\033[0m"
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

function print_green() {
  echo -e "${GREEN}$1${NO_COLOR}"
}

function print_red() {
  echo -e "${RED}$1${NO_COLOR}"
}

function print_yellow() {
  echo -e "${YELLOW}$1${NO_COLOR}"
}

function print_light_green() {
  echo -e "${LIGHT_GREEN}$1${NO_COLOR}"
}

function print_light_red() {
  echo -e "${LIGHT_RED}$1${NO_COLOR}"
}