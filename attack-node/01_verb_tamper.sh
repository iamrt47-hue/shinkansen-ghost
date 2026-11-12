#!/bin/bash
echo "[*] Testing allowed HTTP methods on authentication gate..."
curl --connect-timeout 3 --max-time 3 --max-time 3 -i -X OPTIONS http://192.168.1.168:30085/v1/auth
