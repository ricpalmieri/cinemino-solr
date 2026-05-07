FROM solr:9.6

USER root
RUN mkdir -p /var/solr/data && chown -R solr:solr /var/solr

# Copia lo schema e lo script
COPY solr-schema.json /opt/solr-setup/solr-schema.json
COPY solr-setup.sh /opt/solr-setup/solr-setup.sh
RUN chmod +x /opt/solr-setup/solr-setup.sh

# Script di entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER solr
EXPOSE 8983

CMD ["/entrypoint.sh"]
