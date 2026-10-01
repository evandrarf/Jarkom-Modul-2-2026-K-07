apt update && apt install -y dnsmasq

dnsmasq -d --no-poll --no-resolv -h --listen-address=127.0.0.1 --server=10.67.1.2 &