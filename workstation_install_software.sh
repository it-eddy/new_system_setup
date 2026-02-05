#!/bin/bash
# (c) by it-eddy
# https://github.com/it-eddy/new_system_setup/

# curl
sudo apt install curl

# git
sudo apt install git

# cisco anyconnect (work VPN)
sudo apt install openconnect network-manager-openconnect network-manager-openconnect-gnome

# ms visual code
sudo snap install code --classic
# alternative use debian package directly from ms
# curl -sSL 'https://packages.microsoft.com/keys/microsoft.asc' | gpg --dearmor | sudo tee '/usr/share/keyrings/microsoft.gpg' > /dev/null && echo -e "Types: deb\nURIs: https://packages.microsoft.com/repos/code\nSuites: stable\nComponents: main\nArchitectures: amd64 arm64 armhf\nSigned-By: /usr/share/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/vscode.sources >/dev/null && sudo apt update && sudo apt install code

# windscribe vpn
wget 'https://windscribe.com/install/desktop/linux_deb_x64' -O '/tmp/windscribe_currnt.deb' -q && sudo dpkg -i '/tmp/windscribe_currnt.deb'

# google chrome browser
wget 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb' -O '/tmp/gchromeb.dep' -q && sudo dpkg -i '/tmp/gchromeb.dep'

# fix broken deps (important after manual dep installation)
sudo apt-get -f install

# linux tools
sudo apt install aptitude moreutils

# for sound config
sudo apt install pavucontrol libasound2-plugins-extra

# basic dev (svn)
sudo apt install subversion

# dev tools for debian
sudo apt install devscripts debhelper

# editor
sudo apt install vim

# perl libs/modules
sudo apt install libconfig-simple-perl librest-client-perl

# mouse/keyboard sharing
sudo apt install barrier

# auto deactivate and reactivate mousepad when using external mouse
# from https://www.addictivetips.com/ubuntu-linux-tips/automatically-disable-touchpad-when-mouse-is-connected-ubuntu/
sudo add-apt-repository ppa:atareao/atareao
sudo apt-get update
sudo apt-get install touchpad-indicator

# mariadb treiber for perl
sudo apt-get install libdbd-mariadb-perl
# # fallback: load mariaDB dev files and perl module from cpan # currently needed for Ubuntu 22 and 24
# sudo aptitude install libmariadb-dev
# sudo aptitude install cpanminus
# cpanm DBD::MariaDB
