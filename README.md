# Build AnuBitux
How we build AnuBitux and how to build it by yourself 

## Prerequisites
Before starting install the following tools
```
sudo apt install live-build squashfs-tools syslinux-common syslinux-utils xorriso isolinux
```
## Preparation
Then create a working directory to use for the process
```
mkdir distro
```
Move into it
```
cd distro
```
Configure the iso parameters
```
lb config -b iso --cache true --apt-recommends true -a amd64 --binary-images iso --debian-installer live --linux-flavours amd64 --mode debian --debian-installer-gui true --archive-areas "main contrib non-free" --security true --win32-loader false --interactive shell --updates true --iso-application anubitux --iso-publisher https://anubitux.org --iso-volume anubitux --memtest none
```
Obtain root privileges
```
sudo -s
```
Start the building, creating a chroot environment
```
lb build
```
Wait until it finishes...it may take a while

## Building
Now open another terminal, download the anubitux_script.sh and copy it into the chroot environment
```
sudo cp anubitux_script.sh $HOME/distro/chroot
```
Now, in the terminal you are using for the building process, give executions right to the scipt
```
chmod +x anubitux_script.sh
```
and run it
```
./anubitux_script.sh
```
Now wait until it finishes and answer to the prompted questions
When over, type 
```
exit
```
to start the iso creation process.
Before burning it to a USB stick, type
```
isohybrid iso_name.iso
```



