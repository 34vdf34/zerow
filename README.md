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

# Wireguard router example

You can utilize image as USB plugable wireguard router:

**/etc/systemd/network/wg0.netdev**

```
[NetDev]
Name=wg0
Kind=wireguard
Description=WireGuard tunnel

[WireGuard]
ListenPort=[WG PORT]
PrivateKey=[WG PRIVATE KEY]

[WireGuardPeer]
PublicKey=[WG PUBLIC KEY]
PresharedKey=[WG PSK]
AllowedIPs=10.0.0.0/24, 0.0.0.0/0 
Endpoint=[WG HOST IP]:[WG HOST PORT]
PersistentKeepalive=30
```

**/etc/systemd/network/wg0.network**

```
[Match]
Name=wg0 

[Network] 
Address=10.0.XX.XX/24
```

Enable systemd-networkd:

```
systemctl enable systemd-networkd;
```

To route all traffic through you wireguard server: 

```
#!/bin/sh
DEFAULT_GW=[DEFAULT GW IP]
WG_HOST=[WG HOST EXT IP]
WG_HOST_IP=[WG HOST WG IP]

# Add route to wireguard server via current default gw:
ip r add $WG_HOST via $DEFAULT_GW 
# Delete current default gw:
ip r del default via $DEFAULT_GW 
# Route all traffic through wireguard server:
ip r add default via $WG_HOST_IP 
exit 0
```

On VPS do masquerade (between Zero (10.0.XX.XX) and eth0):

```
iptables -t nat -A POSTROUTING -s 10.0.XX.XX/32 -o eth0 -j MASQUERADE
```




