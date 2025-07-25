#!/bin/bash
# (c) by it-eddy
# https://github.com/it-eddy/new_system_setup/



### setup ssh
sudo apt install openssh-server -y
# check if ssh is activated on demand, else activate it permanently
systemctl is-enabled ssh.socket || sudo systemctl enable ssh

