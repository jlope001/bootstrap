#!/bin/bash

# Determine OS platform
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [ "$UNAME" == "linux" ]; then
    # If available, use LSB to identify distribution
    if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
        export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    # Otherwise, use release info file
    else
        export DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
    fi
fi
# For everything else (or if above failed), just use generic identifier
[ "$DISTRO" == "" ] && export DISTRO=$UNAME
unset UNAME

if [ "$DISTRO" == "Ubuntu" ]; then
  sudo apt-get install curl wget
elif [[ $DISTRO == centos* ]]; then
  sudo yum install curl wget
fi

# install rvm and add source
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -L https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm
RVM_SOURCE=$(cat ~/.bashrc | grep '.rvm/scripts/rvm' | wc -l)
if [ $RVM_SOURCE -ge 1 ];
then
  echo '-- not adding rvm source entry'
else
  echo '-- adding rvm source entry'
  echo "source $HOME/.rvm/scripts/rvm" >> ~/.bashrc
fi

# remove rvm 2.x and install 1.x
rvm remove ruby-2
rvm install ruby-1.9
rvm use ruby-1.9
rvm default ruby-1.9

# install required dependencies
bundle install

echo -e "\e[0m---"
echo -e ""
echo -e "\e[97m\e[40m\e[1mTo start the bootstrap in this terminal, you need to run \`source /home/$USER/.rvm/scripts/rvm\`"
echo -e ""
echo -e "\e[0m---"
