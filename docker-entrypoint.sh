#!/bin/bash

# Démarrer Docker en arrière-plan
nohup dockerd > /tmp/docker.log 2>&1 &

# Attendre que Docker démarre
max_attempts=30
attempts=0

while (! docker stats --no-stream 2>/dev/null); do
  if [ $attempts -ge $max_attempts ]; then
    echo "Docker n'a pas démarré après $attempts tentatives."
    cat /tmp/docker.log
    exit 1
  fi
  echo "Attente de démarrage de Docker..."
  sleep 1
  attempts=$((attempts + 1))
done

# Changer les permissions du socket Docker pour permettre l'accès
chmod 666 /var/run/docker.sock

# Démarrer Jenkins
exec /usr/local/bin/jenkins.sh
