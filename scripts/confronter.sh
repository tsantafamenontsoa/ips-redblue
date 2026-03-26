#!/bin/bash
# =============================================================================
#  confronter.sh — RED TEAM
#  Deploie les regles adverses et lance les attaques
#  Usage : bash scripts/confronter.sh <equipe_adverse> <round>
#  Exemple : bash scripts/confronter.sh 3 1
# =============================================================================
ADVERSE=$1
ROUND=$2
if [ -z "$ADVERSE" ] || [ -z "$ROUND" ]; then
  echo "Usage : bash scripts/confronter.sh <equipe_adverse> <round>"
  exit 1
fi

RULES="rules/equipe-${ADVERSE}/local.rules"
if [ ! -f "$RULES" ]; then
  echo "ERREUR : $RULES introuvable. Faites git pull."
  exit 1
fi

echo "=== RED TEAM vs Equipe $ADVERSE — Round $ROUND ==="
echo "[1] Deploiement des regles adverses..."
cp "$RULES" suricata/rules/local.rules
docker exec suricata suricatasc -c reload-rules
sleep 2
docker exec suricata suricatasc -c ruleset-stats

echo "[2] Vidage fast.log pour un test propre..."
docker exec suricata sh -c "echo '' > /var/log/suricata/fast.log"

echo "[3] Lancez vos attaques depuis Kali (terminal separe) :"
echo "    docker exec -it kali bash"
echo "    Puis executez vos payloads depuis attacks/equipe-X/payloads.sh"
echo ""
echo "[4] Pour voir les alertes en direct :"
echo "    docker exec suricata tail -f /var/log/suricata/fast.log"
echo ""
echo "=== Fin : notez les resultats dans resultats/equipe-X/R${ROUND}.md ==="
