# Bootstrap System
Whenever installing a new linux desktop, I always find myself installing the same pieces of software over, and over again.

My first stab at automating setup was a bash script.  It quickly became too complicated and difficult to maintain.  Enter [chef](http://www.getchef.com/chef/), specifically [chef-solo](http://docs.opscode.com/chef_solo.html).  Chef allows you to quickly, cleany provision your machine with minimal effort.

## Setup
In order to bootstrap the system, you will need to install some pieces of software.

What we will install is RVM, chef, berkshelf.

```
$ make setup
```

### Software Installed
* rvm
* chef
* berkshelf

### Post Setup
If you are planning to install right after the setup command, you will need to source RVM from your current terminal with:

```
echo "source $HOME/.rvm/scripts/rvm" >> ~/.bashrc
```

## Installation
Once the requirements have been met, simply run the install command.

```
$ make install
```

### Software Installed
Below is a list of all software installed during the chef run.

| software            | reason                          |
| ------------------- | ------------------------------- |
| vim                 | development                     |
| git                 | development                     |
| chromium            | browse all the internets        |
| keepassx            | password manager                |
| nfs-common          | vm shared folder setup          |
| nfs-kernel-server   | vm shared folder setup          |
| gnome-encfs-manager | gnome encfs manager             |
| hipchat             | chat software                   |
| java                | oracle java                     |
| spotify             | music                           |
| sublime             | development                     |
| vagrant             | manage vms                      |
| guake               | terminal                        |
| indicator-multiload | visual display of resources     |
| hamster-indicator   | track how you utilize your time |
| indicator-cpufreq   | control cpu utilization         |
| google-talkplugin   | google hangouts                 |
| my-weather-indicator| weather applet                  |
| variety             | rotate wallpaper                |
| plex                | stream video via DLNA           |
| steam               | video games                     |
| zsh                 | terminal                        |
