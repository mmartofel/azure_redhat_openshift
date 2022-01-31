#!/bin/bash

# Azure Red Hat OpenShift cluster deletion script.
# Marek Martofel - Red Hat Inc.

# Source the environment variables
source ./environment

az aro delete --resource-group $RESOURCEGROUP --name $CLUSTER

