#!/bin/bash

# Démarrer Docker en arrière-plan
nohup dockerd > /var/log/docker.log 2>&1 &

# Attendre que Docker démarre
while (! docker stats --no-stream ); do
  echo "Attente de démarrage de Docker..."
  sleep 1
done

# Vérifier l'état de Docker
docker info
if [ $? -ne 0 ]; then
  echo "Docker ne fonctionne pas correctement"
  exit 1
fi

# Démarrer Jenkins
exec /usr/local/bin/jenkins.sh
