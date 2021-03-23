# Operating System

My cluster uses a modified version of [Raspberry Pi OS 64-bit][RPiOS] because
of its native support for the CM3+ and it's lightness in weight.

I decided to use the 64-bit version of the OS on my cluster because there are
not that many charts that notively support the `armv7` architecture and I
got tired of having to build my own images and charts. The problem is that
the RPiOS is only released in a full desktop version and so I had to
uninstall all of the X11 related components in order to free up some
disk space on the CM3+.

## Download

Download the latest release of the [RPiOS 64bit][RPiOS].

Alternatively, you can [download the 32-bit Lite version][32bit] that doesn't
need any modifications.

Ubuntu `arm64` was a bit heavy for my CM3+.

## Installation

Installing the operating system on the CM3+ was done using the Turing Pi
using [these instructions][these] from Turing Pi using [usbboot].

Alternatively, a [compute module I/O board][1] can be used to flash the CM3+.

## Modification

To rip out all of the desktop related apps, simply remove any modules that are
related to X11.

```shell
(
  sudo apt --purge remove -y "x11-*"
  sudo apt --purge -y autoremove
  sudo apt update
  sudo apt upgrade -y
)
```

I didn't spend too much time stripping down the OS to the bare essentials
because I wanted to get my cluster up and running. You may reverse
engineer [this guide] to further clean up the OS. Suggestions are always
welcome!

[32bit]: https://www.raspberrypi.org/software/operating-systems/
[RPiOS]: https://downloads.raspberrypi.org/raspios_arm64/images/
[these]: https://docs.turingpi.com/get-started/flashing-compute-modules
[usbboot]: https://github.com/raspberrypi/usbboot
[1]: https://www.amazon.com/Compute-Module-Board-PoE-Development/dp/B08BLC1DVD/
[this guide]: https://www.raspberrypi.org/forums/viewtopic.php?t=133691
