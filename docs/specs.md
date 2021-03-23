# Specs

Specifications for my home cluster.

## :computer:&nbsp; Software

- [Raspberry Pi OS 64-bit](./operating-system.md)
- [k3s](https://k3s.io/)
- [Flux](https://toolkit.fluxcd.io/)

## :gear:&nbsp; Hardware

- [Turing Pi](https://turingpi.com/) - 1X
- [Raspberry Pi CM3+][CM3+] - 1X master - 6X nodes
- [Raspberry Pi 4 B][RPi4] - 1X serving 5GB via NFS
- [MITXPC MX500-USB3 Compact Mini-ITX Case][case] - 1X
- [Noctua NF-A4x10 Fans][fans] - 2X

## :wrench:&nbsp; Tools

- [Ansible](https://www.ansible.com/)
- [go-task](https://github.com/go-task/task)
- [pre-commit](https://pre-commit.com/)
- [usbboot](https://github.com/raspberrypi/usbboot)
- [kubectl]()
- [krew](https://krew.sigs.k8s.io/)
  - [change-ns](https://github.com/juanvallejo/kubectl-ns)

[RPiOS]: https://downloads.raspberrypi.org/raspios_arm64/images/
[CM3+]: https://www.raspberrypi.org/products/compute-module-3-plus/
[RPi4]: https://www.raspberrypi.org/products/raspberry-pi-4-model-b/
[case]: https://www.amazon.com/gp/product/B0728DX73X/
[fans]: https://www.amazon.com/gp/product/B00NEMGCIA/
