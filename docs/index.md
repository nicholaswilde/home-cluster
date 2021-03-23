# Home Cluster

My home Kubernetes (k3s) cluster managed by GitOps (Flux2)

## :information_source:&nbsp; Background

My cluster computing journey started last year when [Jeff Geerling] released
his [Turing Pi Cluster YouTube series][1]. Now, I've always been into the
Raspberry Pi ever since the release of version 1 and playing around with
home networking projects such as running a [Pi Hole] server or a CUPS
printer server, etc. The Turing Pi was a great "cheat" and compact
way for my to branch out into cluster computing since I was tired
of trying to remember which application I was running on which
Raspberry Pi.

After getting the Turing Pi 1, I noticed that there weren't very many charts
available period, let alone for `armv7` architectures. That led me into
building my own [Docker images] and creating my [Helm Charts repo]. That
then led me to collaborating with the awesome [k8s@home team]. Now, here I
am, rebuilding my cluster and diving into the GitOps world :globe_with_meridians:.

## :handshake:&nbsp; Thanks

A lot of inspiration for my cluster came from the people that have shared their
clusters over at [awesome-home-kubernetes][awesome].

## :scales:&nbsp; License

[Apache 2.0 License][license]

## :pencil:&nbsp; Author

This project was started in 2021 by [Nicholas Wilde].

[awesome]: https://github.com/k8s-at-home/awesome-home-kubernetes
[Nicholas Wilde]: https://github.com/nicholaswilde/
[license]: https://github.com/nicholaswilde/home-cluster/blob/main/LICENSE
[Jeff Geerling]: https://www.jeffgeerling.com/
[1]: https://www.youtube.com/watch?v=kgVz4-SEhbE&list=PL2_OBreMn7Frk57NLmLheAaSSpJLLL90G
[k8s@home team]: https://github.com/k8s-at-home
[Helm Charts repo]: https://github.com/nicholaswilde/helm-charts
[Docker images]: https://hub.docker.com/u/nicholaswilde
[Pi Hole]: https://pi-hole.net/
