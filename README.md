# IPS Lab — Red vs Blue

## Workflow par round (20 min prépa + 20 min confrontation + 15 min débrief)

### Phase 1 — Préparation (simultanée, 20 min)

**Blue Team** — dans votre lab :
```bash
# Écrire vos règles
notepad suricata\rules\local.rules   # Windows
# ou
nano suricata/rules/local.rules        # Linux/Mac

# Tester que les règles chargent
docker exec suricata suricatasc -c reload-rules
docker exec suricata suricatasc -c ruleset-stats

# Pousser sur Git
git add rules/equipe-X/local.rules
git commit -m "R1 - regles equipe X"
git push
```

**Red Team** — dans votre lab :
```bash
# Tester vos payloads sur VOTRE propre DVWA (port 8080 direct, sans Suricata)
# pour valider qu'ils fonctionnent techniquement

# Écrire le script d'attaque
nano attacks/equipe-X/payloads.sh
chmod +x attacks/equipe-X/payloads.sh

# Pousser sur Git
git add attacks/equipe-X/
git commit -m "R1 - payloads equipe X"
git push
```

### Phase 2 — Confrontation (simultanée, 20 min)

```bash
# Récupérer les fichiers adverses
git pull

# Blue teste les payloads de l'adversaire sur SON propre Suricata
bash scripts/test-adversaire.sh <num_equipe_adverse> <num_round>

# Red déploie les règles de l'adversaire et lance ses payloads
bash scripts/confronter.sh <num_equipe_adverse> <num_round>
```

### Phase 3 — Publication des résultats

```bash
# Pousser les résultats
git add resultats/equipe-X/
git commit -m "R1 - resultats equipe X"
git push
```

## Tableau de matchs

| Round | Domaine | Match 1 | Match 2 | Match 3 | Match 4 |
|---|---|---|---|---|---|
| R1 | Injection SQL | Eq1🔵 vs Eq2🔴 | Eq3🔵 vs Eq4🔴 | Eq5🔵 vs Eq6🔴 | Eq7🔵 vs Eq8🔴 |
| R2 | Scan réseau | Eq1🔵 vs Eq3🔴 | Eq2🔵 vs Eq5🔴 | Eq4🔵 vs Eq7🔴 | Eq6🔵 vs Eq8🔴 |
| R3 | Brute-force | Eq1🔵 vs Eq4🔴 | Eq2🔵 vs Eq6🔴 | Eq3🔵 vs Eq8🔴 | Eq5🔵 vs Eq7🔴 |
| R4 | XSS & Upload | Eq1🔵 vs Eq5🔴 | Eq2🔵 vs Eq7🔴 | Eq3🔵 vs Eq6🔴 | Eq4🔵 vs Eq8🔴 |
| R5 | Round IA | Eq1🔵 vs Eq6🔴 | Eq2🔵 vs Eq8🔴 | Eq3🔵 vs Eq7🔴 | Eq4🔵 vs Eq5🔴 |

## Structure des dossiers

```
rules/equipe-X/local.rules     ← règles Suricata de l'équipe X
attacks/equipe-X/payloads.sh   ← script d'attaque de l'équipe X
attacks/equipe-X/payloads.md   ← description des payloads
resultats/equipe-X/RN.md       ← résultats du round N
scripts/                        ← scripts utilitaires
```
