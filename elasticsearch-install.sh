#!/bin/bash

# Download of Elasticsearch
wget https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.2.0/elasticsearch-2.2.0.tar.gz &&
tar -xvf elasticsearch-2.2.0.tar.gz &&
rm elasticsearch-2.2.0.tar.gz

# Path to the Elasticsearch directory
ELASTICSEARCH_DIR="elasticsearch-2.2.0"
CONFIG_FILE="$ELASTICSEARCH_DIR/config/elasticsearch.yml"

# Check if the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: Configuration file not found at $CONFIG_FILE"
  exit 1
fi

# Append the configuration lines if they are not already present
grep -qxF "cluster.name: stackoverflow" "$CONFIG_FILE" || echo "cluster.name: stackoverflow" >> "$CONFIG_FILE"
grep -qxF "index.query.bool.max_clause_count: 4096" "$CONFIG_FILE" || echo "index.query.bool.max_clause_count: 4096" >> "$CONFIG_FILE"

echo "Configuration successfully added to $CONFIG_FILE"

./elasticsearch-2.2.0/bin/elasticsearch -d

echo "Elasticsearch running in Background"
