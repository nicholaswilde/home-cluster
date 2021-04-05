# TLS

How to add TLS certificates to HTTPS ingress resources.

## Generate Certificate Files

The following command will generate `tls.crt` and `tls.key` files that can then
be imported into Kubernetes.

```shell
openssl req \
  -newkey rsa:2048 -nodes -keyout tls.key \
  -x509 -days 365 -out tls.crt
```

## Generate Secret Resource from Certificate

You can then import the certifates into Kubernetes as a secret.

```shell
kubectl create secret generic traefik-cert \
  --from-file=tls.crt \
  --from-file=tls.key
```

Optionally, you can export the secret to a yaml file to save in the repo.

```shell
kubectl create secret generic traefik-cert \
  --from-file=tls.crt \
  --from-file=tls.key \
  --dry-run=client -n kubernetes-dashboard -o yaml \
  | tee traefik-cert-secret.yaml
```

You can also encrypt the secret using [SOPS](./sops.md) before pushing it to
the repo.

```shell
sops --encrypt --in-place traefik-cert-secret.yaml
```

## Optional

You can optionally backup the certificate to a password manager such as `pass`.

### Backup Certificate to `pass`

```shell
pass insert -fm tls/crt < tls.crt
pass insert -fm tls/key < tls.key
```

!!! note
    where `tls/crt` and `tls/key` are the `pass` entries.

### Generate the Secret Resource from `pass`

You can also then create the secret resource file using the certificate from
`pass`.

```shell
kubectl create secret generic traefik-cert \
  --from-literal=tls.cert="$(pass tls/crt)" \
  --from-literal=tls.key="$(pass tls/key)" \
  --dry-run=client -n kubernetes-dashboard -o yaml \
  | tee traefik-cert-secret.yaml
```

## Configure Traefik

You need to configure Traefik to reference the new secret.

### ConfigMap

Edit the Traefik ConfigMap.

```shell
kubectl edit configmap traefik -n kube-system
```

!!! Note "Todo"
    Patch the existing CM instead.

```yaml
...
data:
  traefik.toml: |
    defaultEntryPoints = ["http","https"]
    [entryPoints]
      [entryPoints.http]
      address = ":80"
        [entryPoints.http.redirect]
          entryPoint = "https"
      [entryPoints.https]
      address = ":443"
        [entryPoints.https.tls]
          [[entryPoints.https.tls.certificates]]
          CertFile = "/ssl/tls.crt"
          KeyFile = "/ssl/tls.key"
...
```

### Deployment

Edit the Traefik deployment to reference the new secret.

```shell
kubectl edit deployment traefik -n kube-system
```

!!! Note "Todo"
    Patch the existing Deployment instead.

```yaml
...
    spec:
      volumes:
        - name: ssl
          secret:
            secretName: traefik-cert
...
```

## Ingress

Add the reference to the new secret to the ingress resource.

```yaml
...
spec:
  tls:
    - secretName: traefik-cert
...
```

## References

- [Using Traefik with TLS on Kubernetes][tls]

[tls]: https://medium.com/@patrickeasters/using-traefik-with-tls-on-kubernetes-cb67fb43a948
