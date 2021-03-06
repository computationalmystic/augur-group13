# Developer Installation and Deployment Instructions
------------

## Installation
------------
Installation follows the standard Augur installation as documented [here](https://github.com/computationalmystic/augur-group13/blob/master/README.md) for Vagrant installation and [here](https://github.com/computationalmystic/augur-group13/blob/master/docs/python/source/dev-guide/2-install.rst) for local installation. For the sake of brevity, I won't repeat the entirety of those here. 

As we are only adding a plugin to Augur to hit our REST API, and our DoSOCSv2 deployment only has to be completed once (by us), developers will not need to worry about installing any additional dependencies or programs.

## Deployment
------------
The DoSOCSv2 API that our plugin will use will only need to be installed once, on a remote server that we (the maintainers) have set up. As a result, the only deployment necessary deployment instructions are the ones provided with Augur.

To install and deploy from source, it's recommended to set up an Ubuntu server, perhaps using AWS or DigitalOcean. Once the server is up and running, follow the local installation documentation mentioned above. For Ubuntu:

```
echo "Installing NodeSource..."
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

echo "Installing node.js..."
sudo apt-get install -y nodejs

echo "Installing pip3..."
sudo apt-get install -y python3-pip

echo "Installing Python3.7..."
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt-get update -y
sudo apt-get install python3.7 -y

sudo pip3 install -e .

echo "Installing Augur..."
# we need sudo for npm
sudo make install-dev

cat vagrant.config.json > augur.config.json
```

Then, run `nohup make dev-start &` to start the server on port 3333.

For this wanting to use Docker: https://github.com/computationalmystic/augur-group13/blob/master/docs/python/source/docker-install.rst

