# Linux Bootstrap Scripts
This repository is a grouping of scripts I use to backup restore my personal files from a linux operating system.

Below is a description of each folder in this repository and how it is used.

## System Backup/Restore
This folder contains two scripts that will allow you to backup an *entire* system and restore that backup.

### Backup
We accomplish this by creating a system tarball.  It will include today's date so you can potentially run this script via cron.

Credit - http://ubuntuforums.org/showthread.php?t=35087  The backup/restore instructions were found there.

Run the following script as root.

```
sudo system/backup.sh
```

Modify the script to update the exclude directory.

### Restore
TODO

## FAQ
1. Why is this open source?
Nothing found here is really private, but can be adapted to be used to suite your needs.

2. Well I need this feature, how can I help implement it?
Fork it, make the updates, issue pull request, profit!