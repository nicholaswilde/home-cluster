# Operating System

My cluster uses a modified version of [Raspberry Pi OS 64-bit][RPiOS]
:strawberry: because of its native support for the CM3+ and it's
lightness in weight.

I decided to use the 64-bit version of the OS on my cluster because there are
not that many charts that notively support the `armv7` architecture and I
got tired of having to build my own images and charts. The problem is that
the RPiOS is only released in a full desktop version and so I had to
uninstall all of the X11 related components in order to free up some
disk space on the CM3+.

## :floppy_disk:&nbsp;  Download

Download the latest release of the [RPiOS 64-bit][RPiOS].

I've recently started [building my own] RPiOS 64-bit lite version since the
official version has been [stuck in beta for so long][beta] and it is only
offered in the desktop/full version.

Alternatively, you can [download the 32-bit Lite version][32bit] that doesn't
need any modifications.

Ubuntu `arm64` was a bit heavy for my CM3+.

## :inbox_tray:&nbsp; Installation

Installing the operating system on the CM3+ was done using the Turing Pi
using [these instructions][these] from Turing Pi using [usbboot].

Alternatively, a [compute module I/O board][1] can be used to flash the CM3+.

## :wrench:&nbsp; Modification

!!! Note:
    This step may be skipped if you are already using the `lite` version.

To rip out all of the desktop related apps in the full version, simply remove
any modules that are related to X11.

```shell
(
  sudo apt --purge remove -y "x11-* lxsession"
  sudo apt --purge -y autoremove
  sudo apt update
  sudo apt upgrade -y
)
```

I didn't spend too much time stripping down the OS to the bare essentials
because I wanted to get my cluster up and running. You may reverse
engineer [this guide] to further clean up the OS. Suggestions are always
welcome!

You can also go through the `stage3, 4, & 5` folders in the official [pi-gen]
repo and remove all of those packages as well.

Reboot if needed.

```shell
sudo reboot
```

## :gear:&nbsp; Other Settings

### :abcd:&nbsp; Hostname

The hostname can be changed with the following:

```shell
sudo hostnamectl set-hostname <hostname>
```

### :key:&nbsp; SSH Key

[Import your public SSH key][ssh] :computer:&nbsp; so that you don't need to enter the dang
password anywhere when logging into each node.

!!! Note
    Your public key needs to exist on GiHub at https://github.com/username.keys

```shell
ssh-import-id-gh <username>
```

## :whale2:&nbsp; Docker

Last thing I need to do is [install Docker][docker] on the master and each node.

!!! Note
    This setup is only for `arm64` architectures on a Debian/RPiOS OS.

```shell
(
  sudo apt-get update
  sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker $(whoami)
)
```

Be sure to reboot.

```shell
sudo reboot
```

Test to make sure that Docker can run without using `sudo`.

```shell
docker run --rm hello-world
```

[32bit]: https://www.raspberrypi.org/software/operating-systems/
[RPiOS]: https://downloads.raspberrypi.org/raspios_arm64/images/
[these]: https://docs.turingpi.com/get-started/flashing-compute-modules
[usbboot]: https://github.com/raspberrypi/usbboot
[1]: https://www.amazon.com/Compute-Module-Board-PoE-Development/dp/B08BLC1DVD/
[this guide]: https://www.raspberrypi.org/forums/viewtopic.php?t=133691
[ssh]: https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
[docker]: https://docs.docker.com/engine/install/debian/#install-using-the-repository
[beta]: https://www.raspberrypi.org/forums/viewtopic.php?f=117&t=275370
[building my own]: https://github.com/nicholaswilde/pi-gen/releases
[pi-gen]: https://github.com/RPi-Distro/pi-gen
