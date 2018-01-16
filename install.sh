#!/bin/bash
CONFIGURE(){
WORKDIR=~/RetroPie-Podcatcher
ROMSDIR=~/RetroPie/roms
PODCATCHDIR=~/RetroPie/roms/podcatcher
CURNTHEME=/etc/emulationstation/themes/carbon
NEWTHEME=/opt/retropie/configs/all/emulationstation/themes/carbon-custom
NEWART=~/RetroPie-Podcatcher/theme/art
CONFIGDIR=/opt/retropie/configs/podcatcher
}

INSTALL(){
sudo apt-get update && sudo apt-get upgrade -y
cp -R $WORKDIR/podcatcher $ROMSDIR/podcatcher
echo "Please choose eighter 'podfox' 'podcatcher' 'greg' 'bashpodder' or 'mashpodder'"
read CATCHER
if [[ $CATCHER = podfox ]];
then
echo "Selected podcatcher: $CATCHER"
cd ~/
git clone https://github.com/brtmr/podfox
cd podfox
sudo pip install podfox
nano ~/.podfox.json
echo "Usage:"
echo "    podfox.py import <feed-url> [<shortname>]"
echo "    podfox.py update [<shortname>]"
echo "    podfox.py feeds"
echo "    podfox.py episodes <shortname>"
echo "    podfox.py download [<shortname> --how-many=<n>]"
fi

if [[ $CATCHER = podcatcher ]];
then
echo "Selected podcatcher: $CATCHER"
cd ~/
git clone https://github.com/doga/podcatcher
cd podcatcher
# Optional security step (do this once)
gem cert --add <(curl -Ls https://raw.githubusercontent.com/doga/podcatcher/master/certs/doga.pem)
gem install podcatcher --trust-policy HighSecurity
podcatcher --version
gem install gem-man # do this once
gem man podcatcher # shows podcatcher MAN page
gem man podcatcher # shows podcatcher MAN page
man podcatcher
fi

if [[ $CATCHER = greg ]];
then
echo "Selected podcatcher: $CATCHER"
cd ~/
git clone https://github.com/manolomartinez/greg
cd greg
pip3 install --user greg
echo "This installs greg to ~/.local/bin. Ensure this directory is included in your system path by adding these lines to ~/.profile:"

echo "# set PATH so it includes user's .local/bin if it exists" >> ~/.profile
echo 'if [ -d "$HOME/.local/bin" ] ; then' >> ~/.profile
echo 'PATH="$HOME/.local/bin:$PATH"' >> ~/.profile
echo "fi" >> ~/.profile
source ~/.profile
mkdir -p ~/.config/greg && cp `greg retrieveglobalconf` ~/.config/greg/greg.conf
nano ~/.config/greg/greg.conf
fi

if [[ $CATCHER = bashpodder ]];
then
echo "Selected podcatcher: $CATCHER"
cd ~/
mkdir -p ~/bashpodder
wget http://lincgeek.org/bashpodder/bashpodder.shell -O $WORKDIR/bashpodder/bashpodder.shell
wget http://lincgeek.org/bashpodder/parse_enclosure.xsl -O $WORKDIR/bashpodder/parse_enclosure.xsl
wget http://lincgeek.org/bashpodder/bp.conf -O $WORKDIR/bashpodder/bp.conf
wget http://lincgeek.org/bashpodder/gui/bpgui.sh -O $WORKDIR/bashpodder/bpgui.sh
wget http://lincgeek.org/bashpodder/gui/convert.sh -O $WORKDIR/bashpodder/convert.sh
fi

if [[ $CATCHER = mashpodder ]];
then
echo "Selected podcatcher: $CATCHER"
cd ~/
git clone https://github.com/chessgriffin/mashpodder/
cd mashpodder
fi

}
CREATEMENU(){
echo " = = = = = = = = = = = = = = = = = = = = "
echo "Setting up EmulationStation menu options...(STILL WIP)..."
echo " = = = = = = = = = = = = = = = = = = = = "
mkdir -p $CONFIGDIR
cp -u $WORKDIR/menu/es_systems.cfg $CONFIGDIR/es_systems.cfg
cp -u $WORKDIR/menu/emulators.cfg $CONFIGDIR/emulators.cfg
echo " = = = = = = = = = = = = = = = = = = = = "
echo "Please edit /opt/retropie/configs/all/emulationstation/es_systems.cfg so that is includes the following:"
cat $WORKDIR/menu/es_systems.cfg
echo " = = = = = = = = = = = = = = = = = = = = "
read -rsp $'Press any key to continue...\n' -n 1 key
}
CREATETHEME(){
echo " = = = = = = = = = = = = = = = = = = = = "
echo "Installing custom emulationstation theme..."
echo " = = = = = = = = = = = = = = = = = = = = "
cp -u $CURNTHEME $NEWTHEME
cp -u $NEWART $NEWTHEME/podcatcher/art
cp -u $WORKDIR/theme/theme.xml $NEWTHEME/podcatcher/theme.xml
echo "A new cutom theme has been set up at $NEWTHEME"
echo "Select it in emulationstation to use it"
read -rsp $'Press any key to continue...\n' -n 1 key
}
##############################
CONFIGURE
INSTALL
CREATEMENU
CREATETHEME