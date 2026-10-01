!/bin/bash

# Ganti sesuai environment
DOMAIN="k07.com"
IP_PRAB="10.67.1.2"
IP_TEDD="10.67.1.3"

echo "=== 1. Test Query AXFR dari tedd ke prab ==="
dig axfr @$IP_PRAB $DOMAIN +short

echo -e "\n=== 2. Pengecekan Serial SOA ==="
SERIAL_PRAB=$(dig +short SOA @$IP_PRAB $DOMAIN | awk '{print $3}')
SERIAL_TEDD=$(dig +short SOA @$IP_TEDD $DOMAIN | awk '{print $3}')

echo "Serial di prab (Master): $SERIAL_PRAB"
echo "Serial di tedd (Slave) : $SERIAL_TEDD"

if [ -n "$SERIAL_PRAB" ] && [ "$SERIAL_PRAB" == "$SERIAL_TEDD" ]; then
    echo -e "\n[STATUS] BERHASIL: Nilai serial SOA identik ($SERIAL_PRAB). Zone transfer tersinkronisasi."
else
    echo -e "\n[STATUS] GAGAL: Nilai serial berbeda atau salah satu server tidak merespons query SOA."
fi