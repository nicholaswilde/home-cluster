# Specs

Specifications for my home cluster.

## :computer:&nbsp; Software

- :strawberry:&nbsp; [Raspberry Pi OS 64-bit](./operating-system.md)
- <img src="../assets/images/k3s.png" width="24" height="24" style="vertical-align:middle"/>&nbsp; [k3s](https://k3s.io/)
- <img src="https://github.com/fluxcd/flux2/raw/gh-pages/_files/flux-icon.svg" width="24" height="24" style="vertical-align:middle"/>&nbsp; [Flux](https://toolkit.fluxcd.io/)

## :gear:&nbsp; Hardware

- :1234:&nbsp; [Turing Pi](https://turingpi.com/) - 1X
- :strawberry:&nbsp; [Raspberry Pi CM3+][CM3+] - 1X master - 6X nodes
- :strawberry:&nbsp; [Raspberry Pi 4 B][RPi4] - 1X serving 5TB via NFS
- :briefcase:&nbsp; [MITXPC MX500-USB3 Compact Mini-ITX Case][case] - 1X
- :ice_cube:&nbsp; [Noctua NF-A4x10 Fans][fans] - 2X

## :robot:&nbsp; Automation

I try to use automaiton as much as possible when developing my projects
so that I don't have to remember or perform the same tasks over and over.
Some of those automations include using pre-commit, go-task, and GitHub
Actions.

## :hammer_and_wrench:&nbsp; Tools

- [Ansible](https://www.ansible.com/)
- [go-task](https://github.com/go-task/task)
- [pre-commit](https://pre-commit.com/)
- [usbboot](https://github.com/raspberrypi/usbboot)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/)
- [krew](https://krew.sigs.k8s.io/)
- [change-ns](https://github.com/juanvallejo/kubectl-ns)

[RPiOS]: https://downloads.raspberrypi.org/raspios_arm64/images/
[CM3+]: https://www.raspberrypi.org/products/compute-module-3-plus/
[RPi4]: https://www.raspberrypi.org/products/raspberry-pi-4-model-b/
[case]: https://www.amazon.com/gp/product/B0728DX73X/
[fans]: https://www.amazon.com/gp/product/B00NEMGCIA/
