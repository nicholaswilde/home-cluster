# Restoration

How to restore a cluster using flux.

Run the bootstrap command:

```shell
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=home-cluster \
  --branch=main \
  --path=./cluster \
  --personal
```

The above command will clone the repository, it will update the components
manifest in <path>/flux-system/gotk-components.yaml and it will push the
changes to the remote branch.

Tell Flux to pull the manifests from Git and upgrade itself with:

```shell
flux reconcile source git flux-system
```

Verify that the controllers have been upgrade with:

```shell
flux check
```
