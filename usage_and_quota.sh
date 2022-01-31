#!/bin/bash

# Azure Red Hat OpenShift cluster creation script.
# Marek Martofel - Red Hat Inc.

# Source the environment variables
source ./environment

az vm list-usage --location ${LOCATION} --out table | grep "Total Regional vCPUs"
az vm list-usage --location ${LOCATION} --out table | grep "Standard DSv3 Family vCPUs"


