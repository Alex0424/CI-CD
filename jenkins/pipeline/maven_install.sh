#!/bin/bash

# This script installs the latest Apache Maven on Ubuntu 24.04
# Works in Jenkins or local environments

set -e

echo "Updating system and installing dependencies..."
sudo apt update
sudo apt install -y wget tar default-jdk

java -version

###############################################################################################################################

echo "Fetching the latest Maven version..."
LATEST_VERSION=$(wget -qO- https://maven.apache.org/download.cgi | grep -oP 'apache-maven-\K[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)

echo "Latest Maven version is: $LATEST_VERSION"

cd /tmp
wget https://downloads.apache.org/maven/maven-3/$LATEST_VERSION/binaries/apache-maven-$LATEST_VERSION-bin.tar.gz

sudo tar xzf apache-maven-$LATEST_VERSION-bin.tar.gz -C /opt/

echo "Configuring environment variables..."
sudo tee /etc/profile.d/maven.sh > /dev/null <<EOF
export JAVA_HOME=/usr/lib/jvm/default-java
export M3_HOME=/opt/apache-maven-$LATEST_VERSION
export MAVEN_HOME=/opt/apache-maven-$LATEST_VERSION
export PATH=\${M3_HOME}/bin:\${PATH}
EOF

sudo chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh

mvn -version