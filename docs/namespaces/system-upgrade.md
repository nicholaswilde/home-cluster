# system-upgrade

The `system-upgrade` namespace just houses the
[k3s automated upgrade deployment][k3s] which uses Rancher's
`system-upgrade-controller` to leverage a
[custom resource definition (CRD)][crd], the **plan**, and a [controller] to
schedule upgrades based on the configured plans.

[crd]: https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#custom-resources
[controller]: https://kubernetes.io/docs/concepts/architecture/controller/
[k3s]: https://rancher.com/docs/k3s/latest/en/upgrades/automated/
