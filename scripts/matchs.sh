#!/bin/bash
# Afficher les matchs d'un round
# Usage : bash scripts/matchs.sh <1-5>

case "$1" in
  1) echo "Round 1 — Injection SQL"
     echo "  Eq1 (Blue/Defenseur) vs Eq2 (Red/Attaquant)"
     echo "  Eq3 (Blue/Defenseur) vs Eq4 (Red/Attaquant)"
     echo "  Eq5 (Blue/Defenseur) vs Eq6 (Red/Attaquant)"
     echo "  Eq7 (Blue/Defenseur) vs Eq8 (Red/Attaquant)"
     ;;
  2) echo "Round 2 — Scan reseau"
     echo "  Eq1 (Blue/Defenseur) vs Eq3 (Red/Attaquant)"
     echo "  Eq2 (Blue/Defenseur) vs Eq5 (Red/Attaquant)"
     echo "  Eq4 (Blue/Defenseur) vs Eq7 (Red/Attaquant)"
     echo "  Eq6 (Blue/Defenseur) vs Eq8 (Red/Attaquant)"
     ;;
  3) echo "Round 3 — Brute-force"
     echo "  Eq1 (Blue/Defenseur) vs Eq4 (Red/Attaquant)"
     echo "  Eq2 (Blue/Defenseur) vs Eq6 (Red/Attaquant)"
     echo "  Eq3 (Blue/Defenseur) vs Eq8 (Red/Attaquant)"
     echo "  Eq5 (Blue/Defenseur) vs Eq7 (Red/Attaquant)"
     ;;
  4) echo "Round 4 — XSS et Upload"
     echo "  Eq1 (Blue/Defenseur) vs Eq5 (Red/Attaquant)"
     echo "  Eq2 (Blue/Defenseur) vs Eq7 (Red/Attaquant)"
     echo "  Eq3 (Blue/Defenseur) vs Eq6 (Red/Attaquant)"
     echo "  Eq4 (Blue/Defenseur) vs Eq8 (Red/Attaquant)"
     ;;
  5) echo "Round 5 — Round IA"
     echo "  Eq1 (Blue/Defenseur) vs Eq6 (Red/Attaquant)"
     echo "  Eq2 (Blue/Defenseur) vs Eq8 (Red/Attaquant)"
     echo "  Eq3 (Blue/Defenseur) vs Eq7 (Red/Attaquant)"
     echo "  Eq4 (Blue/Defenseur) vs Eq5 (Red/Attaquant)"
     ;;
  *)
     echo "Tableau complet des matchs :"
     echo ""
     echo "Equipe 1 :  R1:Blue/Eq2  R2:Blue/Eq3  R3:Blue/Eq4  R4:Blue/Eq5  R5:Blue/Eq6"
     echo "Equipe 2 :  R1:Red/Eq1  R2:Blue/Eq5  R3:Blue/Eq6  R4:Blue/Eq7  R5:Blue/Eq8"
     echo "Equipe 3 :  R1:Blue/Eq4  R2:Red/Eq1  R3:Blue/Eq8  R4:Blue/Eq6  R5:Blue/Eq7"
     echo "Equipe 4 :  R1:Red/Eq3  R2:Blue/Eq7  R3:Red/Eq1  R4:Blue/Eq8  R5:Blue/Eq5"
     echo "Equipe 5 :  R1:Blue/Eq6  R2:Red/Eq2  R3:Blue/Eq7  R4:Red/Eq1  R5:Red/Eq4"
     echo "Equipe 6 :  R1:Red/Eq5  R2:Blue/Eq8  R3:Red/Eq2  R4:Red/Eq3  R5:Red/Eq1"
     echo "Equipe 7 :  R1:Blue/Eq8  R2:Red/Eq4  R3:Red/Eq5  R4:Red/Eq2  R5:Red/Eq3"
     echo "Equipe 8 :  R1:Red/Eq7  R2:Red/Eq6  R3:Red/Eq3  R4:Red/Eq4  R5:Red/Eq2"
     ;;
esac
