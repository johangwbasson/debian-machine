#/bin/bash

show_error() {
  echo -e $'\033[1;31m'"$*"$'\033[' 1>&2
}

show_info() {
  echo -e $'\033[1;32m'"$*"$'\033[0m'
}

show_warning() {
  echo -e $'\033[1;33m'"$*"$'\033[0m'
}

show_question() {
  echo -e $'\033[1;34m'"$*"$'\033[0m'
}

ask_question() {
  read -r -p $'\033[1;34m'"$* "$'\033[0m' var
  echo "${var}"
}

show_success() {
  echo -e $'\033[1;35m'"$*"$'\033[0m'
}

show_header() {
  echo -e $'\033[1;36m'"$*"$'\033[0m'
}

show_listitem() {
  echo -e $'\033[1;37m'"$*"$'\033[0m'
}

function check_installed {
  while read -r package; do
    # Check if package is installed already before installing.
    if dpkg -s "${package}" >/dev/null 2>&1; then
      show_listitem "${package} package already installed. Skipping."
    else
      # First check if the package exists in the repos.
      if ! (apt-cache showsrc "${package}" 2>&1 | grep -q "W: "); then
        show_listitem "Installing ${package}."
        sudo apt-get -y install "${package}"
      else
        show_warning "Package ${package} does not exist in the repos. Skipping."
      fi
    fi
  done < "${1}"
}

function check_uninstalled {
  for package in "${@}"; do
    if dpkg -s "${package}" >/dev/null 2>&1; then
      show_listitem "Purging ${package}."
      sudo apt-get -y purge "${package}"
      sudo apt-get -y autoremove
    else
      show_warning "Package ${package} is not installed. Skipping."
    fi
  done
}

function check_fail {
  EXITSTATUS=${1:-}
  if [[ $EXITSTATUS -gt 0 ]]; then
    show_error "Error code received. Returning to main."
    sleep 3s && main
  fi
}
