set -v

curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
sudo bash install-logging-agent.sh

apt-get update

export HOME=/root

git clone https://github.com/arunima811/cloud-agnostic-KV-store.git
cd cloud-agnostic-KV-store
python3 server.py


