#!/bin/bash
# ============================================================
# Script di setup Solr per il progetto cinema-events
# Eseguire DOPO aver avviato il container Docker con:
#   docker-compose up -d
# ============================================================

SOLR_URL="http://localhost:8983/solr"
CORE="cinema-events"

echo "=== Attendo che Solr sia disponibile... ==="
until curl -sf "$SOLR_URL/$CORE/admin/ping" > /dev/null 2>&1; do
  echo "  Solr non ancora pronto, retry in 5s..."
  sleep 5
done
echo "  Solr è up!"

echo ""
echo "=== Applico lo schema al core '$CORE'... ==="
curl -X POST "$SOLR_URL/$CORE/schema" \
  -H "Content-Type: application/json" \
  -d @"$(dirname "$0")/solr-schema.json"

echo ""
echo ""
echo "=== Setup completato! ==="
echo "Admin UI: $SOLR_URL/#/$CORE"
echo ""
echo "Per avviare il reindex manuale, chiama:"
echo "  POST http://localhost:8080/api/cinemas/events/reindex"

