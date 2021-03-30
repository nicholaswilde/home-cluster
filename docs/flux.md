# Flux

## :floppy_disk:&nbsp; Installation

```shell
brew install fluxcd/tap/flux
```

## :man_running:&nbsp; Getting Started

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

!!! Note
    Ensure that you have the `GITHUB_USER` environmental variable set
    and that you are already logged into the git repository.

```shell
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=home-cluster \
  --branch=main \
  --path=./cluster \
  --personal
```

## Cluster Directory Layout

```shell
./cluster
  ├── flux-system
  │   ├── gotk-components.yaml
  │   ├── gotk-sync.yaml
  │   ├── gotk-patches.yaml
  │   ├── helm
  │   └── kustomization.yaml
  ├── namespace1
  │   ├── helm-release.yaml
  │   └── namespace1.yaml
  ├── namespace2
  │   ├── namespace2.yaml
  │   ├── chart2
  │   │   └── helm-release.yaml
  │   └── chart3
  │       └── helm-release.yaml
  └── sources
      └── some-repo-charts.yaml
```

!!! Hint
    The above chart files use the `helm-release.yaml` file name so that
    Renovate can correctly find the chart version.

## Namespaces

Each cluster namespace gets its own directory in the `cluster` directory and
the namespace is creates via a `namespace.yaml` manifest located in the
namespace directory.

```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: <namespace name>
```

### Create a namespace using Task

A namespace can also be created using `task`. The task will create a directory
if it doesn't already exist as well as the `namespace.yaml` manifest.

From the repo root directory, run the following:

```shell
task ns:create NAME=<namespace name>
```

## Helm Charts

Helm charts live inside the namespace directory. Whether or not the charts get
their own directory depends on if there are multiple charts inside that
namespace.

## :wheel_of_dharma:&nbsp; HelmRelease Example

### Source

The source file is typically added to the `./cluster/sources` directory.

```shell
flux create source helm repo-name-charts \
    --url https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/ \
    --export | tee repo-name-charts.yaml
```

All below commands are performed inside the `./cluster/<namespace name>`
directory.

### values.yaml

#### Chart Specific

```yaml
---
nfs:
  path: /home/pi/nas/nfs
  server: 192.168.1.192
storageClass:
  defaultClass: false
  name: managed-nfs-storage
```

#### Resources

```yaml
resources:
  limits:
    cpu: '200m'
    memory: '256Mi'
  requests:
    cpu: '100m'
    memory: '128Mi'
```

### HelmRelease

The latter part of `source` parameter needs to match the name of the
`helm source`.

```shell
flux create helmrelease \
    chart-name \
    --source HelmRepository/repo-name-charts \
    --values values.yaml \
    --chart chart-name \
    --chart-version 1.0.0 \
    --target-namespace namespace-name \
    --export \
    | tee helm-release.yaml
```

Commit the yaml files and watch your cluster update.

```shell
flux check
watch flux get kustomizations
watch flux get helmreleases
watch flux get sources all -A
```

## Task

WIP
