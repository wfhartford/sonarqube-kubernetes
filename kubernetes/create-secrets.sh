#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

password() {
  dd if=/dev/urandom bs=30 count=1 status=none | base64 -w 0
}

passwordB64() {
  password | base64 -w 0
}

cat > postgres-secret.yaml << EOF
apiVersion: v1
kind: Secret
metadata:
  namespace: sonarqube
  name: postgres
type: Opaque
data:
  # The password used by SonarQube to access postgres, required every time
  # SonarQube runs.
  password: $(passwordB64)
EOF
