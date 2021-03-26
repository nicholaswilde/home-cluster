# Flux

## Installation

```shell
brew install fluxcd/tap/flux
```

## Getting Started

Bash completion

```shell
# ~/.bashrc or ~/.bash_profile
. <(flux completion bash)
```

Check requirements

```shell
flux check --pre
► checking prerequisites
✔ kubectl 1.18.3 >=1.18.0
✔ kubernetes 1.18.2 >=1.16.0
✔ prerequisites checks passed
```

Run the bootstrap command to connect the cluster to a repo.

```shell
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=home-cluster \
  --branch=main \
  --path=./cluster \
  --personal
```

## Helm Example

### values.yaml

```yaml
---
nfs:
  path: /home/pi/nas/nfs
  server: 192.168.1.192
storageClass:
  defaultClass: false
  name: managed-nfs-storage
```

```shell
flux create source helm managed-nfs-storage \
    --url https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/ \
    --export | tee managed-nfs-storage.yaml
```

```shell
flux create helmrelease \
    managed-nfs-storage \
    --source HelmRepository/managed-nfs-storage \
    --values values.yaml \
    --chart nfs-subdir-external-provisioner \
    --target-namespace managed-nfs-storage \
    --interval 30s \
    --export \
    | tee -a managed-nfs-storage.yaml
```

Commit the yaml files and watch your cluster update.

```shell
flux check
watch flux get kustomizations
watch flux get helmreleases
watch flux get sources all -A
```
