# Using jenkins/inbound-agent as base image
FROM jenkins/inbound-agent

# Run as root user to gain privilege needed for the installation
USER root

# Instal Docker
RUN apt-get -y update && \
 apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
 curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
 echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
 $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
 apt-get update && \
 apt-get -y install docker-ce docker-ce-cli containerd.io

#  Install Docker-Compose
RUN curl -L https://github.com/docker/compose/releases/download/1.25.3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
 chmod +x /usr/local/bin/docker-compose && \
 ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose && \
 docker-compose --version

#  Adding jenkins user inside docker group to run docker as non-root
RUN usermod -aG docker jenkins

# Switch to jenkins user
USER jenkins