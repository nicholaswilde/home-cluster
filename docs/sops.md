# Mozilla SOPS

I'm currently using [Mozilla SOPS][sop] :key:&nbsp; to manage secrets on my
cluster.

## :passenger_ship:&nbsp; Deployment

I used the [Flux Mozilla SOPS Guide][flux] to help setup `SOPS` on my cluster
excluding the [Configure in-cluster secrets decryption][config] section. The
biggest problem I had was understanding the [asymmetric encryption][asym]
mechanism that `SOPS` uses. I found that the
[Manage Kubernetes Secrets with Mozilla SOPS & Flux 2 (with Leigh Capili)][yt]
:film_frames:&nbsp; video on YouTube helped understand the concept a lot.

I also didn't spend the time to figure out how to patch the
`./flux-system/gotk-sync.yaml` with a separate file and so I just ended up
editing the file directly.

```yaml
# ./flux-system/gotk-sync.yaml
...
spec:
  decryption:
    provider: sops
    secretRef:
      name: sops-gpg
...
```

Make sure that the `flux-system` Kustomization file updates properly after
applying the patch.

```shell
kubectl get Kustomization -n flux-system
```

Make sure that the `basic-auth` was created successfully.

```shell
kubectl describe Kustomization flux-system -n flux-system | grep basic-auth
secret/basic-auth created
```

## :computer:&nbsp; Commands

Here are some commands that I found helpful when setting up `SOPS`.

Encrypt the `basic-auth.yaml` secret with SOPS using your GPG key:

```shell
sops --encrypt --in-place basic-auth.yaml
```

Output decoded secrets without external tools. Used when testing the
`basic-auth` example.

```shell
kubectl get secret my-secret -o go-template='{{range $k,$v := .data}}{{"### "}}{{$k}}{{"\n"}}{{$v|base64decode}}{{"\n\n"}}{{end}}'
```

## :key:&nbsp; Import the Public GPG Key Using Task

Task may be used to import the public key.

```shell
task gpg:import
```

## Check for Unencrypted Secrets Using pre-commit

I use a custom `pre-commit` hook that runs [this script] to check that
resources of kind secret are encrypted using `SOPS`.

```shell
pre-commit run check-sops-secrets
```

!!! Note
    The scipt does not check if the secret is out of date!

[asym]: https://en.wikipedia.org/wiki/Public-key_cryptography
[sop]: https://github.com/mozilla/sops
[config]: https://toolkit.fluxcd.io/guides/mozilla-sops/#configure-in-cluster-secrets-decryption
[yt]: https://www.youtube.com/watch?v=8pbdXAd-F44
[flux]: https://toolkit.fluxcd.io/guides/mozilla-sops/
[this script]: https://github.com/nicholaswilde/home-cluster/blob/main/hack/check-sops-secrets-hook.sh
