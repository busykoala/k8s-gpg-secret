#!/bin/bash

# setup gpg conf dir and keys directory
export GNUPGHOME="./.gnupg"
mkdir -p keys

# generate a key pair based on gpg-batch
gpg --batch --gen-key gpg-batch >> /dev/null 2>&1

# extract key id
KEY_ID=$(gpg --list-keys --keyid-format long 2>/dev/null | grep "pub " | grep -o -P '(?<=/)[A-Z0-9]{16}') >> /dev/null 2>&1

# print public key and export private key
printf "*********************\n-----PUB KEY IS:-----\n*********************\n\n"
gpg --armor --export "$KEY_ID"
gpg --armor --export-secret-keys "$KEY_ID" | tee > "keys/$KEY_ID"

# generate and output kubernetes secret
printf "\n\n*********************\n-----K8S SECRET:-----\n*********************\n\n"
kubectl create secret generic argocd-gpg-keys-secret --from-file "keys/$KEY_ID" --dry-run=client -o yaml

# clean up
rm -Rf keys .gnupg
