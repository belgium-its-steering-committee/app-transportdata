ARG SOLR_IMAGE_VERSION=2.11-solr9

FROM ckan/ckan-solr:${SOLR_IMAGE_VERSION}

USER root

# remove legacy (since Solr 9) managed_schema without xml extension
RUN rm -f $SOLR_SCHEMA_FILE

# add new managed schema with xml extension
# see https://solr.apache.org/guide/solr/latest/indexing-guide/schema-api.html
ENV SOLR_SCHEMA_FILE="$SOLR_CONFIG_DIR/ckan/conf/managed-schema.xml"
ADD ./conf/schema.xml $SOLR_SCHEMA_FILE
RUN chmod 644 $SOLR_SCHEMA_FILE 

USER solr