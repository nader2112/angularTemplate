FROM jenkins/jenkins:lts-jdk17

USER root

# Installer Node.js et npm (version 18.x)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

# Installer Docker
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

# Créer le groupe Docker et ajouter l'utilisateur Jenkins
RUN groupadd docker
RUN usermod -aG docker jenkins

# Copier le script docker-entrypoint.sh
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Utiliser docker-entrypoint.sh comme point d'entrée
ENTRYPOINT ["docker-entrypoint.sh"]

USER jenkins
