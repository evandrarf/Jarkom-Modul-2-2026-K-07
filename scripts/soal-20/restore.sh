#!/bin/bash

# ==============================================================================
# Script Pemulihan (Restore) Konfigurasi DNS Abbey ke IP Asli (Soal 20)
# Dijalankan di node: prab (DNS Master - 10.67.1.2)
# ==============================================================================

ZONE_FILE="/etc/bind/db.k07.com"
DOMAIN="k07.com"
IP_ASLI_ABBEY="10.67.4.2"
IP_SLAVE_TEDD="10.67.1.3"

echo "=========================================================="
echo " [SOAL 20] Pemulihan Konfigurasi DNS Abbey ke IP Asli"
echo "=========================================================="

# Validasi keberadaan file zona
if [ ! -f "$ZONE_FILE" ]; then
    echo "[ERROR] File zona $ZONE_FILE tidak ditemukan pada server ini!"
    echo "Pastikan script ini dijalankan di node prab (DNS Master)."
    exit 1
fi

# 1. Mengembalikan A record abbey ke IP asli (menghapus TTL 15s dan IP fiktif)
echo -e "\n[1/4] Mengembalikan A record abbey ke IP asli ($IP_ASLI_ABBEY)..."
sed -i -E "s/^abbey(\s+[0-9]+)?\s+IN\s+A\s+.*/abbey\tIN\tA\t$IP_ASLI_ABBEY/" "$ZONE_FILE"

# 2. Menaikkan Serial SOA agar slave (tedd) menyinkronkan data terbaru
echo "[2/4] Memperbarui serial SOA di master..."
if grep -q -E -i ";\s*serial" "$ZONE_FILE"; then
    OLD_SERIAL=$(grep -E -i ";\s*serial" "$ZONE_FILE" | awk '{print $1}' | head -n 1)
    NEW_SERIAL=$((OLD_SERIAL + 1))
    sed -i -E "s/([0-9]+)(\s*;\s*serial)/$NEW_SERIAL\2/I" "$ZONE_FILE"
    echo "      Serial SOA berhasil dinaikkan: $OLD_SERIAL -> $NEW_SERIAL"
elif grep -q -E "\(\s*[0-9]+" "$ZONE_FILE"; then
    OLD_SERIAL=$(grep -E -o "\(\s*[0-9]+" "$ZONE_FILE" | grep -E -o "[0-9]+" | head -n 1)
    NEW_SERIAL=$((OLD_SERIAL + 1))
    sed -i -E "s/(\(\s*)$OLD_SERIAL/\1$NEW_SERIAL/" "$ZONE_FILE"
    echo "      Serial SOA berhasil dinaikkan: $OLD_SERIAL -> $NEW_SERIAL"
else
    echo "      [PERINGATAN] Pola serial SOA tidak terdeteksi otomatis, silakan periksa file zona."
fi

# 3. Validasi sintaks file zona menggunakan named-checkzone
echo "[3/4] Memvalidasi sintaks zona $DOMAIN..."
if named-checkzone "$DOMAIN" "$ZONE_FILE"; then
    echo "      [OK] Sintaks file zona valid."
else
    echo "      [ERROR] Terjadi kesalahan sintaks pada file zona $ZONE_FILE!"
    exit 1
fi

# 4. Reload BIND dan kirim notifikasi ke slave
echo "[4/4] Memuat ulang service BIND & memberi notifikasi ke slave (tedd)..."
rndc reload "$DOMAIN" 2>/dev/null || service named reload 2>/dev/null || service bind9 reload 2>/dev/null
rndc notify "$DOMAIN" 2>/dev/null

echo -e "\n=========================================================="
echo " Verifikasi Hasil Pemulihan"
echo "=========================================================="
echo -n "Query ke prab (Master)       : "
dig @127.0.0.1 abbey.$DOMAIN +short

echo -n "Query ke tedd (Slave - $IP_SLAVE_TEDD): "
dig @$IP_SLAVE_TEDD abbey.$DOMAIN +short

echo -e "\n[STATUS] BERHASIL: Record abbey.$DOMAIN telah dikembalikan ke IP normal ($IP_ASLI_ABBEY)!"
