set -v

export HOME=/root
git clone https://github.com/arunima811/cloud-agnostic-KV-store.git
cd cloud-agnostic-KV-store
python3 client.py
echo Hi

