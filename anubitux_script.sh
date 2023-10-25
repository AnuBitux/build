#!/bin/bash

# VARIABLES
SPARROW="1.7.9"
EXODUS="23.10.23"
ATOMIC="2.76.4"
# https://get.atomicwallet.io/download/latest-debian.txt
ZEC="1.8.8"
VERACRYPT="1.26.7"
BITBOX="4.39.0"
BITBOX2="4.39.0_amd64"
ELECTRUM="4.4.6"
ELECTRON="4.3.1"
ELECTRUM_LTC="4.2.2.1"
GREEN="1.2.8"
FEATHER="2.5.2"
MYMONERO="1.3.2"
MYCRYPTO="1.7.17"
MYCRYPTO2="1.7.17_MyCrypto"
TREZOR="23.10.1"
KEEPKEY="2.1.20"
COINOMI="1.3.0"
TORBROWSER="13.0"
TORBROWSER2="13.0_ALL"
BITWARDEN="2023.9.3"
BCVAULT="setup_2.0.1"
MONEROCLI="0.18.3.1"

# COLORS
RED='\033[0;31m'
NC='\033[0m'

apt update
apt upgrade
apt -y install linux-image-amd64 linux-headers-amd64 cinnamon firmware-linux firmware-linux-nonfree firmware-misc-nonfree firmware-realtek firmware-atheros firmware-bnx2 firmware-bnx2x firmware-brcm80211 firmware-ipw2x00 firmware-intelwimax firmware-iwlwifi firmware-libertas firmware-netxen firmware-zd1211 b43-fwcutter firmware-b43-installer firmware-b43legacy-installer intel-media-va-driver-non-free libva-drm2 libva-x11-2 mesa-va-drivers i965-va-driver-shaders libnvcuvid1 xorg intel-microcode printer-driver-all fonts-crosextra-caladea fonts-crosextra-carlito wireshark tshark ffmpeg qrencode searchmonkey testdisk kleopatra keepassxc zulucrypt-gui firefox-esr ntfs-3g exfat-fuse wkhtmltopdf libsecp256k1-0 evince python3-tk python3-pip hashcat gedit libreoffice-writer libreoffice-calc tor secure-delete git python3-pip libwxgtk3.0-gtk3-0v5 qtqr scdaemon firmware-intel-sound firmware-sof-signed zstd macchanger curl flameshot wget gnupg iptables ntp zenity make python3-full whois libusb-1.0-0-dev libudev-dev git libccid pcscd libopengl-dev

apt -y --purge remove libreoffice-math libreoffice-draw apache2-bin
apt -y --purge autoremove

# disable dot net telemetry
export DOTNET_CLI_TELEMETRY_OUTPUT=1

# add Kali repo to download bulkextractor
cp /etc/apt/sources.list /etc/apt/sources.list.backup
echo deb http://http.kali.org/kali kali-rolling main contrib non-free >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ED444FF07D8D0BF6
apt update
apt -y install bulk-extractor
apt -y install printer-driver-all
cp /etc/apt/sources.list.backup /etc/apt/sources.list
rm -rf /etc/apt/sources.list.backup
apt update

# Downloading and placing customization files
cd /etc/skel/
mkdir Desktop
mkdir Documents
mkdir Pictures
mkdir Templates
mkdir .bitcoinlib
mkdir .cinnamon
mkdir .config
mkdir .icons
mkdir .local
mkdir .mozilla
mkdir .openjfx
mkdir .themes

cd

git clone https://github.com/AnuBitux/custom_files
cd custom_files
zip -F customs.zip --out single-archive.zip
unzip single-archive.zip
cd home/anubitux/temp_git
ls -l
cp -r -p Desktop /etc/skel/
chmod +x /etc/skel/Desktop/*
cp -r -p Documents /etc/skel/
cp -r grub/* /usr/share/desktop-base/homeworld-theme/grub/
cp -r -p homeworld/* /usr/share/plymouth/themes/homeworld/
cp -r lightdm/* /etc/lightdm
cp -r Pictures/ /etc/skel/
cp -r Templates /etc/skel/
cp -r -p .bitcoinlib /etc/skel/
cp -r -p .cinnamon/ /etc/skel/
cp -r -p .config /etc/skel/
cp -r -p .icons /etc/skel/
cp -r -p .local /etc/skel/
cp -r -p .mozilla /etc/skel/
cp -r -p .openjfx /etc/skel/
cp -r -p .themes /etc/skel/
cp hosts /etc/
cp .bashrc /etc/skel/
cp .dmrc /etc/skel/
cp .face /etc/skel/
cp .gtkrc-2.0 /etc/skel/
cp .profile /etc/skel/
cp .Xauthority /etc/skel/
cd

# Adding the anubitux user - answer prompted questions 
echo ' '
echo '==========================='
echo -e ${RED}if you want to install the distro, please set anubitux as username to get all the tools working properly${NC}
echo '==========================='
echo ' '
adduser anubitux

cd custom_files/home/anubitux/temp_git
cp .bashrc /home/anubitux/
cp .profile /home/anubitux/
cp sudoers /etc/
cd
rm -rf custom_files

cd /home/anubitux
mkdir Tools
cd /home/anubitux/Tools
mkdir AddressGen
mkdir Cryptography
mkdir FFdisclaimer
mkdir Privacy
mkdir Recovery
mkdir UsefulTools
mkdir Wallets
mkdir WalletTools
cd Wallets
mkdir HW

# DEBs
cd
cd /home/anubitux/Downloads

# Sparrow
wget --user-agent="Mozilla" https://github.com/sparrowwallet/sparrow/releases/download/$SPARROW/sparrow_$SPARROW-1_amd64.deb
dpkg -i sparrow*
rm -rf sparrow*

# BitBox
wget --user-agent="Mozilla" https://github.com/digitalbitbox/bitbox-wallet-app/releases/download/v$BITBOX/bitbox_$BITBOX2.deb
dpkg -i bitbox*
rm -rf bitbox*

# Kalitorify
systemctl enable ufw
systemctl disable tor
git clone https://github.com/brainfucksec/kalitorify
cd kalitorify
make install
cd..

# exodus
wget --user-agent="Mozilla" https://downloads.exodus.com/releases/exodus-linux-x64-$EXODUS.deb
dpkg -i exodus*
rm -rf exodus*

# BitWarden
wget --user-agent="Mozilla" https://github.com/bitwarden/clients/releases/download/desktop-v$BITWARDEN/Bitwarden-$BITWARDEN-amd64.deb
dpkg -i Bitwarden*
rm -rf Bitwarden*

# Atomic
wget --user-agent="Mozilla" https://get.atomicwallet.io/download/atomicwallet-$ATOMIC.deb
dpkg -i atomic*
rm -rf atomic*

# VeraCrypt
wget --user-agent="Mozilla" https://launchpad.net/veracrypt/trunk/$VERACRYPT/+download/veracrypt-$VERACRYPT-Debian-11-amd64.deb
dpkg -i veracrypt*
rm -rf veracrypt*

# Samsung printer drivers
wget --user-agent="Mozilla" https://ftp.hp.com/pub/softlib/software13/printers/SS/SL-C4010ND/uld_V1.00.39_01.17.tar.gz
tar -xf uld*
cd uld
chmod +x install.sh
./install.sh
cd ..
rm -rf uld*

# PYTHON TOOLS
pip3 install virtualenv

#VeraDecrypt
cd /home/anubitux/Tools/Recovery
git clone https://github.com/AnuBitux/VeraDecrypt
cd VeraDecrypt
virtualenv vdve
source vdve/bin/activate
deactivate
chmod +x veradecrypt.sh

# SeedCheck
cd /home/anubitux/Tools/WalletTools/
git clone https://github.com/AnuBitux/SeedCheck
cd SeedCheck
virtualenv scve
source scve/bin/activate
pip3 install -r requirements.txt
deactivate
chmod +x seedcheck.sh

# DiceTracker
cd /home/anubitux/Tools/AddressGen/
git clone https://github.com/AnuBitux/DiceTracker
cd DiceTracker
virtualenv dtve
source dtve/bin/activate
pip3 install -r requirements.txt
deactivate
chmod +x dicetracker.sh

# Dice2Seed
cd /home/anubitux/Tools/AddressGen/
git clone https://github.com/AnuBitux/Dice2Seed
cd Dice2Seed
virtualenv dsve
chmod +x Dice2Seed.sh

# LastWord
cd /home/anubitux/Tools/AddressGen/
git clone https://github.com/AnuBitux/LastWord
cd LastWord
virtualenv lwve

# btcrecover
cd /home/anubitux/Tools/Recovery
git clone https://github.com/AnuBitux/btcrecover
cd btcrecover
virtualenv brve
source brve/bin/activate
pip3 install -r requirements.txt
pip3 install -r requirements-full.txt
deactivate
chmod +x btcrecover.sh
chmod +x seedrecover.sh

# SeedSearch
cd /home/anubitux/Tools/Recovery
git clone https://github.com/AnuBitux/SeedSearch
cd SeedSearch
virtualenv ssve
source ssve/bin/activate
pip3 install -r requirements.txt
deactivate
chmod +x seedsearch.sh

# BtcKeySearch
cd /home/anubitux/Tools/Recovery
git clone https://github.com/AnuBitux/BTCKeySearch
cd BTCKeySearch
virtualenv bkve
source bkve/bin/activate
pip3 install -r requirements.txt
deactivate
chmod +x btckeysearch.sh

# SeedBF
cd /home/anubitux/Tools/Recovery
git clone https://github.com/AnuBitux/SeedBF
cd SeedBF
virtualenv sbve
source sbve/bin/activate
pip3 install -r requirements.txt
deactivate
chmod +x seedbf.sh
cd

# Creating commands
ln -s /home/anubitux/Tools/AddressGen/Dice2Seed/Dice2Seed.py /usr/bin/
ln -s /home/anubitux/Tools/AddressGen/DiceTracker/dicetracker.py /usr/bin/
ln -s /home/anubitux/Tools/WalletTools/SeedCheck/seedcheck.py /usr/bin/
ln -s /home/anubitux/Tools/WalletTools/SeedCheck/seedchecklist.py /usr/bin/
ln -s /home/anubitux/Tools/Recovery/btcrecover/btcrecover.py /usr/bin/
ln -s /home/anubitux/Tools/Recovery/btcrecover/seedrecover.py /usr/bin/
ln -s /home/anubitux/Tools/Recovery/BTCKeySearch/btckeysearch.py /usr/bin/
ln -s /home/anubitux/Tools/Recovery/SeedSearch/seedsearch.py /usr/bin/
ln -s /home/anubitux/Tools/Recovery/SeedSearch/seedsearchpro.py /usr/bin/
ln -s /home/anubitux/Tools/Recovery/VeraDecrypt/VeraDecrypt.py /usr/bin/
ln -s /home/anubitux/Tools/AddressGen/LastWord/lastword.py /usr/bin/
ln -s /home/anubitux/Tools/Recovery/SeedBF/seedbf.py /usr/bin/
chmod +x /usr/bin/Dice2Seed.py
chmod +x /usr/bin/dicetracker.py
chmod +x /usr/bin/seedcheck.py
chmod +x /usr/bin/seedchecklist.py
chmod +x /usr/bin/btcrecover.py
chmod +x /usr/bin/seedrecover.py
chmod +x /usr/bin/btckeysearch.py
chmod +x /usr/bin/seedsearch.py
chmod +x /usr/bin/seedsearchpro.py
chmod +x /usr/bin/VeraDecrypt.py
chmod +x /usr/bin/lastword.py
chmod +x /usr/bin/seedbf.py 

# Appimages
#DOWNLOAD
cd /home/anubitux/Tools/Wallets
wget --user-agent="Mozilla" https://download.electrum.org/$ELECTRUM/electrum-$ELECTRUM-x86_64.AppImage
mv electrum-4* electrum-btc.AppImage
wget --user-agent="Mozilla" https://electroncash.org/downloads/$ELECTRON/win-linux/Electron-Cash-$ELECTRON-x86_64.AppImage
mv Electron-Cash-* Electron-Cash.AppImage
wget --user-agent="Mozilla" https://electrum-ltc.org/download/electrum-ltc-$ELECTRUM_LTC-x86_64.AppImage
mv electrum-ltc* electrum-ltc.AppImage
wget --user-agent="Mozilla" https://greenupdate.blockstream.com/desktop/$GREEN/BlockstreamGreen-x86_64.AppImage
wget --user-agent="Mozilla" https://featherwallet.org/files/releases/linux-appimage/feather-$FEATHER.AppImage
mv feather-* feather.AppImage
wget --user-agent="Mozilla" https://github.com/mymonero/mymonero-app-js/releases/download/v$MYMONERO/MyMonero-$MYMONERO.AppImage
mv MyMonero-* MyMonero.AppImage
wget --user-agent="Mozilla" https://github.com/MyCryptoHQ/MyCrypto/releases/download/$MYCRYPTO/linux-x86-64_$MYCRYPTO2.AppImage
mv linux-x86-64* MyCrypto.AppImage
wget --user-agent="Mozilla" https://github.com/adityapk00/zecwallet-lite/releases/download/v$ZEC/Zecwallet.Lite-$ZEC.AppImage
mv Zecwallet* Zecwallet.Lite.AppImage
wget --user-agent="Mozilla" https://storage.coinomi.com/binaries/desktop/coinomi-wallet-$COINOMI-linux64.tar.gz
tar -xf coinomi*
rm -rf coinomi-wallet-$COINOMI-linux64.tar.gz
chmod +x *

cd HW
wget --user-agent="Mozilla" https://download.live.ledger.com/latest/linux
mv ledger* ledger-live.AppImage
mv linux ledger-live.AppImage
wget --user-agent="Mozilla" https://github.com/trezor/trezor-suite/releases/download/v$TREZOR/Trezor-Suite-$TREZOR-linux-x86_64.AppImage
mv Trezor-Suite* Trezor-Suite.AppImage
wget --user-agent="Mozilla" https://github.com/keepkey/keepkey-desktop/releases/download/v$KEEPKEY/KeepKey-Desktop-$KEEPKEY.AppImage
mv KeepKey-D* KeepKey.AppImage
wget --user-agent="Mozilla" https://data.trezor.io/udev/trezor-udev_2_all.deb
wget --user-agent="Mozilla" https://dl.update.bc-vault.com/downloads/$BCVAULT.tar.gz
tar -xf setup*
./setup*
rm -rf setup*
chmod +x *

cd /home/anubitux/Tools/Privacy
wget --user-agent="Mozilla" https://www.torproject.org/dist/torbrowser/$TORBROWSER/tor-browser-linux64-$TORBROWSER2.tar.xz
tar -xf tor-browser-linux*
rm -rf tor-browser-linux*
mv tor-browser tor-browser_en-US
chown -R anubitux ./tor-browser_en-US

apt --fix-broken install

# Hardware wallets setup
cd /home/anubitux
wget --user-agent="Mozilla" -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh | sudo bash
python3 -m pip install trezor[hidapi]
python3 -m pip install btchip-python ecdsa
python3 -m pip install keepkey
python3 -m pip install hidapi
python3 -m pip install bitbox02
python3 -m pip install safet
python3 -m pip install ckcc-protocol
python3 -m pip install pyserial cbor
cd Downloads
git clone https://github.com/AnuBitux/udev
sudo cp /home/anubitux/Downloads/udev/*.rules /etc/udev/rules.d
rm -rf udev
sudo groupadd plugdev
sudo usermod -aG plugdev $(whoami)
sudo udevadm control --reload-rules && sudo udevadm trigger

cd /home/anubitux

# downloading and placing scripts
git clone https://github.com/AnuBitux/AnuBituxScripts
cd AnuBituxScripts
chmod +x *
cp -p AnonsurfOFF.sh /home/anubitux/Tools/Privacy
cp -p AnonsurfON.sh /home/anubitux/Tools/Privacy
cp -p Disclaimer.sh /home/anubitux/Tools
cp -p bulkextractor.sh /home/anubitux/Tools/Recovery
cp -p checkIP.sh /home/anubitux/Tools/Privacy
cp -p hashcat.sh /home/anubitux/Tools/Recovery
cp -p mac_random.sh /home/anubitux/Tools/Privacy
cp -p offline.sh /home/anubitux/Tools
cp -p online.sh /home/anubitux/Tools
cp -p photorec.sh /home/anubitux/Tools/Recovery
cp -p udev.sh /home/anubitux/Tools/Wallets/HW
cp -p qrencode.sh /home/anubitux/Tools/AddressGen 
cp -p disclaimerpage.html /home/anubitux/Tools/FFdisclaimer
cp -p logo.png /home/anubitux/Tools/FFdisclaimer
cd ..
rm -rf AnubituxScripts

# Other tools
cd /home/anubitux/Tools/AddressGen/
git clone https://github.com/bccaddress/bccaddress.org
git clone https://github.com/pointbiz/bitaddress.org
git clone https://github.com/litecoin-project/liteaddress.org
git clone https://github.com/JollyMort/monero-wallet-generator
wget --user-agent="Mozilla" https://downloads.getmonero.org/cli/monero-linux-x64-v$MONEROCLI.tar.bz2
tar -xf monero-linux*
rm -rf monero-linux
mv monero-x86_64* monero-cli
git clone https://github.com/dashpay/paper.dash.org
cd /home/anubitux/Tools/UsefulTools
git clone https://github.com/ASeriousMister/passgen.py
cd /home/anubitux/Tools/WalletTools
wget --user-agent="Mozilla" https://github.com/iancoleman/bip39/releases/download/0.5.6/bip39-standalone.html
git clone https://github.com/jlopp/xpub-converter
git clone https://github.com/BitcoinQnA/seedtool
git clone https://github.com/luigi1111/xmr.llcoins.net

update-initramfs -u

# Cleaning useless files
rm -rf /usr/share/backgrounds/gnome/*.jpg
rm -rf /usr/share/desktop-base/joy-inksplat-theme
rm -rf /usr/share/desktop-base/joy-theme
rm -rf /usr/share/desktop-base/lines-theme
rm -rf /usr/share/desktop-base/moonlight-theme
rm -rf /usr/share/desktop-base/softwaves-theme
rm -rf /usr/share/desktop-base/spacefun-theme
rm -rf /usr/share/plymouth/themes/futureprototype
rm -rf /usr/share/plymouth/themes/joy
rm -rf /usr/share/plymouth/themes/lines
rm -rf /usr/share/plymouth/themes/moonlight
rm -rf /usr/share/plymouth/themes/softwaves
rm -rf /usr/share/plymouth/themes/spacefun

# Starting the bulding process
echo -e type ${RED}exit${NC} to start the iso creation process
