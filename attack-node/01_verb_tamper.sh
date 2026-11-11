#!/bin/bash
echo "[*] Testing allowed HTTP methods on authentication gate..."
curl -i -X OPTIONS http://192.168.1
