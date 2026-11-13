#!/bin/bash
HOSTS="${1:-/etc/hosts}"

echo "Main account - forked"
# check_ip HOST IP DNS_SERVER
# Verifica asocierea host-IP folosind serverul DNS dat
check_ip() {
    local name="$1" ip="$2" dns="$3"
    if ! nslookup "$name" "$dns" 2>/dev/null | tail -n +3 | grep -qwF "$ip"; then
        echo "Bogus IP for $name in $HOSTS!"
    fi
}

while read -r ip name _; do
    [[ -z "$ip" || "$ip" == \#* ]] && continue
    check_ip "$name" "$ip" "8.8.8.8"
done < "$HOSTS"
