# Generate GPG Secret

Edit the gpg-batch file with user+mail and then run:

```bash
# generates key pair and stuffs the private key into a secret
# it ouputs the public key and the according secret
./generate-secret.sh
```

## GPG Info of ArgoCD

```bash
kubectl -n argocd exec -ti deploy/argocd-repo-server -- bash
```
