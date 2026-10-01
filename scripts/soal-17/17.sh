cat << 'EOF' >> /etc/bind/db.k07.com
; --- TXT Records Klien Sayap Kiri & Sayap Kanan (Soal 17) ---
alpha    IN    TXT    "alpha"
beta     IN    TXT    "beta"
gamma    IN    TXT    "gamma"
delta    IN    TXT    "delta"
epsilon  IN    TXT    "epsilon"
EOF

rndc reload