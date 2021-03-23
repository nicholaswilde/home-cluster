# Home Cluster

My home Kubernetes (k3s) cluster managed by GitOps (Flux2)

## :computer:&nbsp; Software

- [Raspberry Pi OS 64-bit][RPiOS]
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

## :handshake:&nbsp; Thanks

A lot of inspiration for my cluster came from the people that have shared their
clusters over at [awesome-home-kubernetes][awesome].

## :closed_book:&nbsp; License

[Apache 2.0 License][license]

## :pencil:&nbsp; Author

This project was started in 2021 by [Nicholas Wilde].

[awesome]: https://github.com/k8s-at-home/awesome-home-kubernetes
[Nicholas Wilde]: https://github.com/nicholaswilde/
[license]: https://github.com/nicholaswilde/home-cluster/blob/main/LICENSE
[RPiOS]: https://downloads.raspberrypi.org/raspios_arm64/images/
[CM3+]: https://www.raspberrypi.org/products/compute-module-3-plus/
[RPi4]: https://www.raspberrypi.org/products/raspberry-pi-4-model-b/
[case]: https://www.amazon.com/gp/product/B0728DX73X/
[fans]: https://www.amazon.com/gp/product/B00NEMGCIA/
