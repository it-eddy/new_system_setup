#!/bin/bash
# (c) by it-eddy
# https://github.com/it-eddy/new_system_setup/



### handling variables DEBEMAIL and DEBFULLNAME for Debian packaging (dch)
if [ -z "$DEBEMAIL" ] && [ -z "$DEBFULLNAME" ]; then
	# both DEBEMAIL and DEBFULLNAME not yet set

	read -p "Enter your email address for Debian packaging: " email
	read -p "Enter your full name for Debian packaging: " name

	echo "" >> ~/.bashrc
	echo "# variables for Debian package building (dch)" >> ~/.bashrc
	echo "export DEBEMAIL=\"$email\"" >> ~/.bashrc
	echo "export DEBFULLNAME=\"$name\"" >> ~/.bashrc
	echo "" >> ~/.bashrc

	source ~/.bashrc
	export DEBEMAIL=\"$email\"
	export DEBFULLNAME=\"$name\"

else
	# one or both vars are set

	if [ -n "$DEBEMAIL" ] && [ -n "$DEBFULLNAME" ]; then
		# both vars are set
		# skip
		echo -n ""

	else
		# only one var is set

		# check DEBEMAIL
		if [ -z "$DEBEMAIL" ]; then
			read -p "Enter your email address for Debian packaging: " email
			echo "export DEBEMAIL=\"$email\"" >> ~/.bashrc
			export DEBEMAIL=\"$email\"
		fi

		# check debfullDEBFULLNAMEname
		if [ -z "$DEBFULLNAME" ]; then
			read -p "Enter your full name for Debian packaging: " name
			echo "export DEBFULLNAME=\"$name\"" >> ~/.bashrc
			export DEBFULLNAME=\"$name\"
		fi

		source ~/.bashrc

	fi

fi



### handle bash history search with page-up/page-down keys
line1='if [[ $- == *i* ]]; then bind '\''"\e[5~": history-search-backward'\''; fi'
line2='if [[ $- == *i* ]]; then bind '\''"\e[6~": history-search-forward'\''; fi'

if ! grep -Fxq "$line1" ~/.bashrc && ! grep -Fxq "$line2" ~/.bashrc; then
	# no hanlding yet, add both

	echo "" >> ~/.bashrc
	echo "# handle bash history search with page-up/page-down keys" >> ~/.bashrc
	echo "$line1" >> ~/.bashrc
	echo "$line2" >> ~/.bashrc
	echo "" >> ~/.bashrc
	source ~/.bashrc

elif grep -Fxq "$line1" ~/.bashrc && grep -Fxq "$line2" ~/.bashrc; then
	# both handlers already set
	# skip
	echo -n ""

elif ! grep -Fxq "$line1" ~/.bashrc; then
	echo "$line1" >> ~/.bashrc
	source ~/.bashrc

elif ! grep -Fxq "$line2" ~/.bashrc; then
	echo "$line2" >> ~/.bashrc
	source ~/.bashrc

fi



### change vim settings (to use arrow keys)
if [ -e /etc/vim/vimrc.tiny ]; then
	sudo sed -i '/^set compatible$/s/.*/set nocompatible/' /etc/vim/vimrc.tiny
fi



### git settings
# Check if git user email is not set
if [ -z "$(git config --global user.email)" ]; then
	git config --global user.email "$DEBEMAIL"
fi
# Check if git user name is not set
if [ -z "$(git config --global user.name)" ]; then
	git config --global user.name "$DEBFULLNAME"
fi




### settings for bash history (unlimited with timestamps)
sed -i 's/^HISTSIZE=[0-9]*$/HISTSIZE=-1/' ~/.bashrc
sed -i 's/^HISTFILESIZE=[0-9]*$/HISTFILESIZE=-1/' ~/.bashrc

if ! grep -q "export HISTTIMEFORMAT" ~/.bashrc; then
    sed -i '/^HISTFILESIZE=[0-9-]*$/ a export HISTTIMEFORMAT="%d/%m/%y %T "' ~/.bashrc
else
	sed -i 's/\s*#\?\s*export HISTTIMEFORMAT=.*/export HISTTIMEFORMAT="%d\/%m\/%y %T "/' ~/.bashrc
fi
