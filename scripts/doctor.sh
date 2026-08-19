#!/usr/bin/env bash
set -euo pipefail

echo "== Host =="
uname -a

if [[ -f /etc/os-release ]]; then
  echo
  echo "== OS =="
  cat /etc/os-release
fi

echo
echo "== User =="
id

echo
echo "== Docker =="
if command -v docker >/dev/null 2>&1; then
  docker --version
else
  echo "docker: not installed"
fi

if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
  docker compose version
else
  echo "docker compose: not installed"
fi

echo
echo "== Firewall tools =="
command -v ufw || true
command -v firewall-cmd || true

echo
echo "== Memory =="
if command -v free >/dev/null 2>&1; then
  free -h
else
  vm_stat || true
fi

echo
echo "== Disk =="
df -h .

echo
echo "== Minecraft port =="
if command -v ss >/dev/null 2>&1; then
  ss -ltnp | grep 25565 || true
else
  echo "ss: not installed"
fi
