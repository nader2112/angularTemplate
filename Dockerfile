FROM jenkins/jenkins:lts-jdk17

USER root

# Installer Node.js et npm
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

USER jenkins
