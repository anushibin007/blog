FROM jetbrains/teamcity-server

RUN \
apt update && \
# install necessary stuffs
apt install wget gnupg -y && \
# Add the Perforce packaging key to your APT keyring
wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add - && \
# Add the Perforce repository to your APT configuration.
echo "deb http://package.perforce.com/apt/ubuntu bionic release" > /etc/apt/sources.list.d/perforce.list && \
# Update your package list
apt-get update && \
# Install P4CLI
apt-get install helix-p4d -y
