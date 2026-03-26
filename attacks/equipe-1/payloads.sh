#!/bin/bash
# =============================================================================
#  payloads.sh — Equipe 1 — Round 1 (Injection SQL)
#
#  Usage (apres avoir deploye les regles adverses) :
#    bash attacks/equipe-1/payloads.sh <ip_dvwa>
#
#  Par defaut cible : dvwa (nom Docker)
# =============================================================================

TARGET="${1:-dvwa}"
PORT="80"
COOKIE_FILE="/tmp/dvwa_eq1.txt"

echo "=== Equipe 1 — Attaques R1 (Injection SQL) ==="
echo "Cible : $TARGET:$PORT"
echo ""

# Authentification DVWA
curl -s -c "$COOKIE_FILE" \
  -d "username=admin&password=password&Login=Login" \
  "http://$TARGET:$PORT/login.php" -L -o /dev/null
echo "[*] Cookie recupere"
echo ""

# ── Payload 1 — REMPLACEZ PAR VOTRE ATTAQUE ────────────────────────────────
echo "[1] Payload basique..."
RESULT=$(curl -s -b "$COOKIE_FILE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=TEST1&Submit=Submit" \
  -o /dev/null -w "%{http_code}")
echo "    HTTP $RESULT"

# ── Payload 2 ───────────────────────────────────────────────────────────────
echo "[2] Payload avance..."
RESULT2=$(curl -s -b "$COOKIE_FILE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=TEST2&Submit=Submit" \
  -o /dev/null -w "%{http_code}")
echo "    HTTP $RESULT2"

# ── Payload 3 ───────────────────────────────────────────────────────────────
echo "[3] Payload evasion..."
# A completer

echo ""
echo "=== Fin des attaques. Verifiez fast.log pour les alertes. ==="
