# This script is used to quickly bootstrap an ubuntu desktop with stuff i use
#
# Below are the boolean fields of items you can install.  It makes life
# a lot easier once you have done within a script.
#

INSTALL_BOOTSTRAP=true
INSTALL_JAVA=true
INSTALL_SUBLIME=true
INSTALL_HIPCHAT=true
INSTALL_SPOTIFY=true
INSTALL_RUBY=true
INSTALL_VAGRANT=true
INSTALL_FILES=true
INSTALL_STARTUP=true
INSTALL_GOOGLE=true

# CONFIG INFORMATION
BACKUP_DIRECTORY='/mnt/archive/backup'

#
#
# BOOTSTRAP FILES
#
#
if $INSTALL_BOOTSTRAP; then
  echo '-- bootstrapping system'
  sudo apt-get -y install curl git vim indicator-multiload hamster-indicator chromium-browser keepassx virtualbox-qt ubuntu-restricted-extras indicator-cpufreq guake rdiff-backup libxslt-dev libxml2-dev libdvdread4 libavformat-extra-53 libavcodec-extra-53 libnss-myhostname
  sudo apt-get remove unity-lens-shopping
  sudo add-apt-repository -y ppa:gencfsm && sudo apt-get update && sudo apt-get -y install gnome-encfs-manager

  # enable dvd playback
  sudo /usr/share/doc/libdvdread4/install-css.sh

  # disable amazon privacy stuff
  gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"
fi

if $INSTALL_JAVA; then
  sudo add-apt-repository ppa:webupd8team/java
  sudo apt-get update
  sudo apt-get -y install oracle-java7-installer
fi

#
#
# SUBLIME
#
#
if $INSTALL_SUBLIME; then
  echo '-- installing sublime'
  sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
  sudo apt-get update
  sudo apt-get install sublime-text-installer

  echo '-- create directories'
  mkdir -p ~/.config/sublime-text-3/Installed\ Packages
  mkdir -p ~/.config/sublime-text-3/Packages/User

  echo '-- install custom sublime preferences'
  cp $BACKUP_DIRECTORY/preferences_sublime_settings ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings

  cp $BACKUP_DIRECTORY/python_sublime_settings ~/.config/sublime-text-3/Packages/User/Python.sublime-settings

  wget https://sublime.wbond.net/Package%20Control.sublime-package
  mv Package\ Control.sublime-package ~/.config/sublime-text-3/Installed\ Packages/.

  git clone https://github.com/jlope001/Flake8Lint.git "Python Flake8 Lint"
  rm -rf ~/.config/sublime-text-3/Packages/Python\ Flake8\ Lint
  mv Python\ Flake8\ Lint ~/.config/sublime-text-3/Packages/.
fi

if $INSTALL_HIPCHAT; then
  if [ -f  /etc/apt/sources.list.d/atlassian-hipchat.list ]; then
    echo '-- hipchat already installed'
  else
    echo '-- installing hipchat'
    echo "deb http://downloads.hipchat.com/linux/apt stable main" | sudo tee -a /etc/apt/sources.list.d/atlassian-hipchat.list
    wget -O - https://www.hipchat.com/keys/hipchat-linux.key | sudo apt-key add -
    sudo apt-get update
  fi

  sudo apt-get -y install hipchat
fi

#
#
# HIPCHAT
#
#
if $INSTALL_SPOTIFY; then
  echo '-- installing spotify'
  SPOTIFY=$(cat /etc/apt/sources.list | grep spotify | wc -l)
  if [ ! $SPOTIFY -eq 1 ];
  then
    echo '-- installing spotify'
    echo "deb http://repository.spotify.com stable non-free" | sudo tee -a /etc/apt/sources.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
    sudo apt-get update
  else
    echo '-- not installing spotify'
  fi

  sudo apt-get install -y spotify-client
fi

#
#
# RVM
#
#
if $INSTALL_RUBY; then
  echo '-- installing ruby'
  \curl -L https://get.rvm.io | bash -s stable --ruby
  source ~/.rvm/scripts/rvm
  rvm install 1.9.3
  rvm --default use 1.9.3
  RVM_SOURCE=$(cat ~/.bashrc | grep '.rvm/scripts/rvm' | wc -l)
  echo $RVM_SOURCE
  if [ $RVM_SOURCE -ge 1 ];
  then
    echo '-- not adding source entry'
  else
    echo '-- adding source entry'
    echo "source $HOME/.rvm/scripts/rvm" >> ~/.bashrc
  fi
fi

#
#
# VAGRANT
#
#
if $INSTALL_VAGRANT; then
  echo '-- installing vagrant'
  wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb
  sudo dpkg -i vagrant_1.6.3_x86_64.deb
  rm vagrant_1.6.3_x86_64.deb
  vagrant plugin install vagrant-berkshelf
fi

#
#
# FILES
#
#
if $INSTALL_FILES; then
  echo '-- seting up symlinks'
  ln -s /mnt/archive ~/.

  echo '-- installing files'
  cp -r $BACKUP_DIRECTORY/.ssh ~/.
  chmod -R 700 ~/.ssh
  cp -r $BACKUP_DIRECTORY/hamster-applet ~/.local/share/.
  cp $BACKUP_DIRECTORY/bookmarks ~/.config/gtk-3.0/bookmarks
  cp $BACKUP_DIRECTORY/.gitconfig ~/.
  cp $BACKUP_DIRECTORY/.bash_aliases ~/.
fi

#
#
# STARTUP
#
#
if $INSTALL_STARTUP; then
  echo '-- installing startup'
  echo "[Desktop Entry]
Terminal=false
Type=Application
Categories=
GenericName=
NoDisplay=false
Exec=hamster-indicator" | sudo tee /etc/xdg/autostart/hamster-applet.desktop
  echo "[Desktop Entry]
Terminal=false
Type=Application
Categories=
GenericName=
NoDisplay=false
Exec=guake" | sudo tee /etc/xdg/autostart/guake.desktop
  echo "[Desktop Entry]
Terminal=false
Type=Application
Categories=
GenericName=
NoDisplay=false
Exec=indicator-multiload" | sudo tee /etc/xdg/autostart/indicator-multiload.desktop
fi

#
#
# GOOGLE TALK
#
#
if $INSTALL_GOOGLE; then
  echo '-- installing google talk'
  wget https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
  sudo dpkg -i google-talkplugin_current_amd64.deb
  rm google-talkplugin_current_amd64.deb
fi
