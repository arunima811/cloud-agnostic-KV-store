#!/bin/bash

#gcloud compute instances create cc-kv-store-server --image-family=ubuntu-1804-lts \
#    --image-project=ubuntu-os-cloud \
#    --machine-type=e2-micro \
#    --zone=us-central1-c


#SERVER_IP=$(gcloud compute instances describe cc-kv-store-server --zone us-central1-c --format="value(networkInterfaces[].accessConfigs[0].natIP)")
#CLIENT_IP=$(gcloud compute instances describe cc-kv-store-client --zone us-central1-c --format="value(networkInterfaces[].accessConfigs[0].natIP)")
set -ex
gcloud compute instances create cc-kv-store-server --image-family=ubuntu-1804-lts \
    --image-project=ubuntu-os-cloud \
    --machine-type=e2-micro \
    --metadata-from-file startup-script=startup-script-server.sh \
    --zone=us-central1-c


#gcloud compute instances create cc-kv-store-client --image-family=ubuntu-1804-lts \
#    --image-project=ubuntu-os-cloud \
#    --machine-type=e2-micro \
#    --metadata-from-file startup-script=startup-script-client.sh \
#    --zone=us-central1-c

#gcloud compute instances delete cc-kv-store-server
#gcloud compute instances delete cc-kv-store-client
#echo SERVER_IP
#echo CLIENT_IP
#gcloud beta compute ssh --zone "us-central1-c" "cc-kv-store-client"  --project "arunima-shukla-kv-store"
#git clone https://github.com/arunima811/cloud-agnostic-KV-store.git
