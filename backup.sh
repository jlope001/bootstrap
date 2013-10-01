# CONFIG INFORMATION
BACKUP_DIRECTORY='/mnt/archive/backup'

# copy over all of the required files into a directory
cp ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings $BACKUP_DIRECTORY/preferences_sublime_settings
cp ~/.config/sublime-text-3/Packages/User/Python.sublime-settings $BACKUP_DIRECTORY/python_sublime_settings
cp ~/.gitconfig $BACKUP_DIRECTORY/.
cp ~/.bash_aliases $BACKUP_DIRECTORY/.
cp ~/.config/gtk-3.0/bookmarks $BACKUP_DIRECTORY/.
cp -rf ~/.local/share/hamster-applet $BACKUP_DIRECTORY/.
cp -rf ~/.ssh $BACKUP_DIRECTORY/.