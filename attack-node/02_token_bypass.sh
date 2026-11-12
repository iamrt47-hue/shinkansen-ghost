#!/bin/bash
echo "[*] Sending blank JSON to mint a guest rider token..."
curl --connect-timeout 3 --max-time 3 --max-time 3 -i -X POST \
  -H "Content-Type: application/json" \
  -d '{}' \
  http://192.168.1.168:30085/v1/auth/guest-token
