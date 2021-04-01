# Restoration

How to restore a cluster using flux after installing an operating system
on all cluster nodes.

The first step is to get a base K3s installation installed on your cluster.
This can be done be using the [Ansible Install] playbook.

## TL;DR

```shell
task k3s:bootstrap
```

## `flux-system` Namespace

The next thing to do is create a `flux-system` namespace to install the
`sops-gpg` secret so that `flux` can properly unencrypt any secrets in
the repository.

```shell
kubectl create namespace flux-system
```

## Mozilla SOPS

Once the `flux-system` namespace is created, import the `private` gpg
key back into the cluster using whichever method you prefer.

### Restore Private GPG Key using pass

```shell
pass gpg/home-cluster-private |
kubectl create secret generic sops-gpg \
--namespace=flux-system \
--from-file=sops.asc=/dev/stdin
```

!!! Note
    Where `gpg/home-cluster-private` is the location of the home-cluster
    private key in `pass`.

### Restore Private GPG Key from the `gpg` keyring

```shell
gpg --export-secret-keys --armor "${KEY_FP}" |
kubectl create secret generic sops-gpg \
--namespace=flux-system \
--from-file=sops.asc=/dev/stdin
```

!!! Note
    Where `"${KEY_FP}"` is the fingerprint of the `home-cluster` gpg key.

### Restore Using the Flux CLI

Run the bootstrap command:

```shell
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=home-cluster \
  --branch=main \
  --path=./cluster \
  --personal
```

The above command will clone the repository, update the components
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

## Pull the Repo

After flux syncs with the repo, you'll need to perform a `git pull` in order to
update your local repo.

```shell
git pull origin main
```

[Ansible Install]: ./ansible.md#install
[1]: https://docs.github.com/en/developers/overview/managing-deploy-keys#deploy-keys
[pass]: https://www.passwordstore.org/
