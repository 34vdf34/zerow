# zerow

External tree for [buildroot](https://buildroot.org) to build Raspberry Pi Zero W based firmware image.

## Building

To build firmware image, you need to install Buildroot environment and clone this repository as 'external tree' to buildroot. Make sure you check buildroot manual for required packages for your host, before building.

```
mkdir ~/build-directory
cd ~/build-directory
git clone https://git.buildroot.net/buildroot
git clone https://codeberg.org/48554e6d/zerow.git
```

Define external tree location to BR2_EXTERNAL variable:

```
export BR2_EXTERNAL=~/build-directory/zerow
```

Make zerow configuration (defconfig) and start building:

```
cd ~/build-directory/buildroot
make rpizero5_defconfig
make
```

After build is completed, you find image file for MicroSD card at:

```
~/build-directory/buildroot/output/images/sdcard.img
```

Use 'dd' to copy this image to your MicroSD card:

```
sudo dd if=output/images/sdcard.img of=/dev/[TARGET_DEVICE] status=progress
```
