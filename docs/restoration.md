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

!!! Note
    If you are having trouble restoring you cluster, try deleting the
    [deploy key][1] from your cluster repo.

## Mozilla SOPS

### Public GPG Key

The public GPG key is stored in the cluster and can be imported after
cloning the repo.

Using `Task` from the repo root directory.

```shell
task gpg:import
```

Using `gpg` from the repo root directory.

```shell
gpg --import ./cluster/.sops.pub.asc
```

### Private GPG Key

Restore the `secret key` from [pass].

```shell
pass gpg/home-cluster-private |
kubectl create secret generic sops-gpg \
--namespace=flux-system \
--from-file=sops.asc=/dev/stdin
```

!!! Note
    Where `gpg/home-cluster-private` is the location of the home-cluster
    private key in `pass`.

Restore the `secret key` from `gpg` keyring.

```shell
gpg --export-secret-keys --armor "${KEY_FP}" |
kubectl create secret generic sops-gpg \
--namespace=flux-system \
--from-file=sops.asc=/dev/stdin
```

!!! Note
    Where `"${KEY_FP}"` is the fingerprint of the `home-cluster` gpg key.

[1]: https://docs.github.com/en/developers/overview/managing-deploy-keys#deploy-keys
[pass]: https://www.passwordstore.org/
