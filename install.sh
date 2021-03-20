#!/bin/bash

. lib/functions.sh

function purge_packages {
  show_header "Purging unwanted packaged often installed by default."
  check_uninstalled `cat packages/purge.list`
  check_fail
  show_success "Packages purged."
}

function install_list {
  show_header "Installing $1"
  check_installed "./packages/$1"
  check_fail
  show_success "Packages installed"
}

function install_base {
  show_header "Installing base packages and their config files."
  check_installed "./packages/base.list"
  check_fail
  show_success "Base packages installed."
}


function main() {
    purge_packages
    install_list "base.list"
    install_list "apps.list"
    install_list "cinnamon.list"
    install_list "codecs.list"
    install_list "console.list"
    install_list "dev.list"
    install_list "discover.list"
    install_list "firmware.list"
    install_list "fonts.list"
    install_list "printer.list"
    install_list "system.list"
    install_list "theme.list"
    install_list "utils.list"
    install_list "vim.list"
    install_list "virtualbox.list"
}

main
