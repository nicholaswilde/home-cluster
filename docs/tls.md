# TLS

How to add TLS certificates to HTTPS ingress resources.

## Generate Certificates

```shell
openssl req \
  -newkey rsa:2048 -nodes -keyout tls.key \
  -x509 -days 365 -out tls.crt
```

## Create Secret

```shell
kubectl create secret generic traefik-cert \
  --from-file=tls.crt \
  --from-file=tls.key
```

## Configure Traefik

```toml
# traefik.toml
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
```

## Configure Deployment

```yaml
...
    spec:
      volumes:
        - name: ssl
          secret:
            secretName: traefik-cert
...
```

## References

- [Using Traefik with TLS on Kubernetes][tls]

[tls]: https://medium.com/@patrickeasters/using-traefik-with-tls-on-kubernetes-cb67fb43a948
