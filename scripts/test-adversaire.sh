#!/bin/bash
# =============================================================================
#  test-adversaire.sh — BLUE TEAM
#  Teste les payloads adverses sur VOS regles
#  Usage : bash scripts/test-adversaire.sh <equipe_adverse> <round>
# =============================================================================
ADVERSE=$1
ROUND=$2
if [ -z "$ADVERSE" ] || [ -z "$ROUND" ]; then
  echo "Usage : bash scripts/test-adversaire.sh <equipe_adverse> <round>"
  exit 1
fi

echo "=== BLUE TEAM — Test payloads Equipe $ADVERSE — Round $ROUND ==="
echo "[1] Vos regles chargees :"
docker exec suricata suricatasc -c ruleset-stats

echo "[2] Vidage fast.log pour test propre..."
docker exec suricata sh -c "echo '' > /var/log/suricata/fast.log"

PAYLOADS="attacks/equipe-${ADVERSE}/payloads.sh"
if [ ! -f "$PAYLOADS" ]; then
  echo "ERREUR : $PAYLOADS introuvable. Faites git pull."
  exit 1
fi

echo "[3] Execution des payloads de l'equipe $ADVERSE..."
bash "$PAYLOADS"
sleep 2

echo ""
echo "=== Alertes generees par vos regles ==="
docker exec suricata cat /var/log/suricata/fast.log
echo ""
echo "=== Fin : notez les resultats dans resultats/equipe-X/R${ROUND}.md ==="
