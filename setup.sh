INSTALL_BOOTSTRAP=true
INSTALL_SUBLIME=true
INSTALL_HIPCHAT=true
INSTALL_SPOTIFY=true
INSTALL_RUBY=true
INSTALL_VAGRANT=true
INSTALL_FILES=true
INSTALL_STARTUP=true

if $INSTALL_BOOTSTRAP; then
  echo '-- bootstrapping system'
  sudo apt-get -y install curl git vim indicator-multiload hamster-indicator chromium-browser keepassx virtualbox-qt ubuntu-restricted-extras indicator-cpufreq guake
  sudo apt-get remove unity-lens-shopping
fi

if $INSTALL_SUBLIME; then
  echo '-- installing sublime'
  sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
  sudo apt-get update
  sudo apt-get install sublime-text-installer
	
  echo '-- create directories'
  mkdir -p ~/.config/sublime-text-3/Installed\ Packages
  mkdir -p ~/.config/sublime-text-3/Packages/User
  
  echo '-- install custom sublime preferences'
  echo '
// Settings in here override those in "Default/Preferences.sublime-settings",
// and are overridden in turn by file type specific settings.
{
    // The number of spaces a tab is considered equal to
    "tab_size": 2,

    // Set to true to insert spaces when tab is pressed
    "translate_tabs_to_spaces": true,

    // Set to true to removing trailing white space on save
    "trim_trailing_white_space_on_save": true,
}' > ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings

  echo '
// Settings in here override those in "Default/Preferences.sublime-settings",
// and are overridden in turn by file type specific settings.
{
    // The number of spaces a tab is considered equal to
    "tab_size": 4,
}' > ~/.config/sublime-text-3/Packages/User/Python.sublime-settings

  wget https://sublime.wbond.net/Package%20Control.sublime-package
  mv ~/Package\ Control.sublime-package ~/.config/sublime-text-3/Installed\ Packages/.

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

if $INSTALL_VAGRANT; then
  echo '-- installing vagrant'
  wget http://files.vagrantup.com/packages/7e400d00a3c5a0fdf2809c8b5001a035415a607b/vagrant_1.2.2_x86_64.deb
  sudo dpkg -i vagrant_1.2.2_x86_64.deb
  rm vagrant_1.2.2_x86_64.deb
  vagrant plugin install vagrant-berkshelf
fi

if $INSTALL_FILES; then
  echo '-- seting up symlinks'
  ln -s /mnt/archive ~/.

  echo '-- installing files'
  cp -r ~/archive/backup/.ssh ~/.
  chmod -R 700 ~/.ssh
  cp -r ~/archive/backup/hamster-applet ~/.local/share/.
fi

if $INSTALL_STARTUP; then
  echo '-- installing startup'
  echo "[Desktop Entry]
Terminal=false
Type=Application
Categories=
GenericName=
NoDisplay=true
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
NoDisplay=true
Exec=indicator-multiload" | sudo tee /etc/xdg/autostart/indicator-multiload.desktop
fi

