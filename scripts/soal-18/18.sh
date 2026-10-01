#!/bin/bash

ZONE_FILE="/etc/bind/db.k07.com"

# 1. Generate IP Fiktif Acak (Format valid IPv4)
OCTET2=$(( (RANDOM % 200) + 10 ))
OCTET3=$(( (RANDOM % 200) + 10 ))
OCTET4=$(( (RANDOM % 200) + 10 ))
IP_FIKTIF="198.51.$OCTET2.$OCTET4"

echo "IP Fiktif yang dihasilkan: $IP_FIKTIF"

# 2. Naikkan Serial SOA di file zona (+1)
# OLD_SERIAL=$(grep -E ";\s*serial" "$ZONE_FILE" | awk '{print $1}')
# NEW_SERIAL=$((OLD_SERIAL + 1))
# sed -i -E "s/([0-9]+)(\s*;\s*serial)/$NEW_SERIAL\2/" "$ZONE_FILE"
# echo "Serial SOA dinaikkan: $OLD_SERIAL -> $NEW_SERIAL"

# 3. Ubah A record abbey menjadi TTL 15 detik dan arahkan ke IP fiktif
sed -i -E "s/^abbey(\s+[0-9]+)?\s+IN\s+A\s+.*/abbey\t15\tIN\tA\t$IP_FIKTIF/" "$ZONE_FILE"

# 4. Validasi & Muat ulang service BIND
if named-checkzone k07.com "$ZONE_FILE" > /dev/null; then
    rndc reload
    echo "[STATUS] Konfigurasi nomor 18 berhasil dimuat di prab."
else
    echo "[ERROR] Terjadi kesalahan sintaks pada file zona."
    exit 1
fi