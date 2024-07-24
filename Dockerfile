FROM jenkins/jenkins:lts-jdk17

USER root

# Installer Node.js et npm (version 18.x)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

# Ajouter l'utilisateur Jenkins au groupe Docker
RUN usermod -aG docker jenkins

USER jenkins
