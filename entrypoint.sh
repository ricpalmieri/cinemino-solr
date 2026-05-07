#!/bin/bash

# Avvia Solr in background e crea il core
solr-precreate cinema-events &

# Aspetta che Solr sia pronto, poi applica lo schema
SOLR_URL="http://localhost:8983/solr"
CORE="cinema-events"

echo "Attendo Solr..."
until curl -sf "$SOLR_URL/$CORE/admin/ping" > /dev/null 2>&1; do
  sleep 5
done

echo "Applico schema..."
curl -X POST "$SOLR_URL/$CORE/schema" \
  -H "Content-Type: application/json" \
  -d @/opt/solr-setup/solr-schema.json

echo "Setup completato!"

# Mantieni il processo in foreground
wait
