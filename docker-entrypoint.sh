#!/bin/bash
# Démarrer Docker en arrière-plan
nohup dockerd > /var/log/docker.log 2>&1 &

# Attendre que Docker démarre
while (! docker stats --no-stream ); do
  echo "Attente de démarrage de Docker..."
  sleep 1
done

# Changer les permissions du socket Docker
chown root:docker /var/run/docker.sock
chmod 666 /var/run/docker.sock

# Démarrer Jenkins
exec /usr/local/bin/jenkins.sh
