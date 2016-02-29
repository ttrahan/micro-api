#!/bin/bash -x

cd /root/micro-api

# get the pre installed nodemodules to here to save demo time
# comment this out to do native install
mv /root/micro-image/node_modules .

# install node modules. the above mv will make this zip through as nothing new is installed
npm install

# install gcloud cli
echo "================= Adding gclould binaries ============ "
CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk
