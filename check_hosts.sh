#!/bin/bash
# Verifica daca IP-urile din fisierul hosts corespund cu cele date de DNS
HOSTS="${1:-/etc/hosts}"

while read -r ip name _; do
    # sarim peste liniile goale si peste comentarii
    [[ -z "$ip" || "$ip" == \#* ]] && continue
    if ! nslookup "$name" 2>/dev/null | tail -n +3 | grep -qwF "$ip"; then
        echo "Bogus IP for $name in $HOSTS!"
    fi
done < "$HOSTS"
