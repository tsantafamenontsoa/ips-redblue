#!/bin/bash
# =============================================================================
#  setup.sh — A executer une seule fois par equipe au debut de l'atelier
#  Usage : bash scripts/setup.sh <num_equipe> <url_git>
# =============================================================================
MON_EQUIPE=$1
GIT_URL=$2
if [ -z "$MON_EQUIPE" ] || [ -z "$GIT_URL" ]; then
  echo "Usage : bash scripts/setup.sh <num_equipe> <url_git>"
  exit 1
fi
git clone "$GIT_URL" ips-redblue && cd ips-redblue
git config user.email "equipe${MON_EQUIPE}@ips-lab.local"
git config user.name "Equipe ${MON_EQUIPE}"
echo "=== Pret ! Equipe $MON_EQUIPE ==="
echo "  Regles    : rules/equipe-${MON_EQUIPE}/local.rules"
echo "  Attaques  : attacks/equipe-${MON_EQUIPE}/payloads.sh"
echo "  Resultats : resultats/equipe-${MON_EQUIPE}/"
