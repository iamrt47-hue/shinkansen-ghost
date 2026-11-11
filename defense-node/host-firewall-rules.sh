#!/bin/bash
# Enforcing perimeter guarding via Sōteigai no haiju whitelisting rules
sudo firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="192.168.1.15" port protocol="tcp" port="30085" accept'
sudo firewall-cmd --reload
