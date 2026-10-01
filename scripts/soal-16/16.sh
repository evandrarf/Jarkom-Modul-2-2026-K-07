apt-get update
apt-get install -y apache2-utils

cat << 'EOF' > /root/benchmark.sh
#!/bin/bash

TARGETS=("http://www.k07.com/" "http://static.k07.com/")

for URL in "${TARGETS[@]}"; do
    echo "=========================================================="
    echo " Menjalankan Benchmark: $URL (n=250, c=10)"
    echo "=========================================================="
    
    ab -n 250 -c 10 "$URL"
    
    echo ""
done
EOF

chmod +x /root/benchmark.sh
/root/benchmark.sh