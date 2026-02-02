#!/bin/bash

# Setup script for ckanext-harvest
# This script initializes the harvest database tables and sets up supervisor configurations

if [[ $CKAN__PLUGINS == *"harvest"* ]]; then
   echo "Setting up ckanext-harvest..."
   
   # Initialize harvest database tables
   echo "Initializing harvest database tables..."
   ckan -c $CKAN_INI db upgrade -p harvest
else
   echo "Not configuring Harvest"
fi

