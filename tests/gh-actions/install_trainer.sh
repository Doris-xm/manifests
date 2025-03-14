#!/bin/bash
set -euo pipefail
echo "Installing trainer ..."

cd apps/trainer/upstream
kustomize build overlays/kubeflow | kubectl apply --server-side --force-conflicts -f -
kubectl wait --for=condition=Ready pods --all --all-namespaces --timeout=600s \
  --field-selector=status.phase!=Succeeded
cd -
