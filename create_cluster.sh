#!/bin/bash

# Azure Red Hat OpenShift cluster creation script.
# Marek Martofel - Red Hat Inc.

# Source the environment variables
source ./environment



echo
echo "Your ARO cluster will be created at the following region: " ${LOCATION}
echo "Resource group name is                                  : " ${RESOURCEGROUP}
echo "Your ARO cluster name is                                : " ${CLUSTER}
echo

az provider register -n Microsoft.RedHatOpenShift --wait
az provider register -n Microsoft.Compute --wait
az provider register -n Microsoft.Storage --wait

az group create --name $RESOURCEGROUP --location $LOCATION

az network vnet create \
--resource-group $RESOURCEGROUP \
--name aro-vnet \
--address-prefixes 10.0.0.0/22

az network vnet subnet create \
--resource-group $RESOURCEGROUP \
--vnet-name aro-vnet \
--name master-subnet \
--address-prefixes 10.0.0.0/23 \
--service-endpoints Microsoft.ContainerRegistry

az network vnet subnet create \
--resource-group $RESOURCEGROUP \
--vnet-name aro-vnet \
--name worker-subnet \
--address-prefixes 10.0.2.0/23 \
--service-endpoints Microsoft.ContainerRegistry

az network vnet subnet update \
--name master-subnet \
--resource-group $RESOURCEGROUP \
--vnet-name aro-vnet \
--disable-private-link-service-network-policies true

az aro create \
  --resource-group $RESOURCEGROUP \
  --name $CLUSTER \
  --vnet aro-vnet \
  --master-vm-size ${MASTER_SIZE}  \
  --worker-vm-size ${WORKER_SIZE}  \
  --worker-count   ${WORKER_COUNT} \
  --master-subnet master-subnet \
  --worker-subnet worker-subnet \
  --pull-secret @pull-secret.txt

# Retrieve Red Hat OpenShift console URL.

echo
echo "To access Red Hat OpenShift console plase direct you browser to the following url: "
echo 

az aro show \
    --name $CLUSTER \
    --resource-group $RESOURCEGROUP \
    --query "consoleProfile.url" -o tsv

# Retrieve Red Hat OpenShift kubeadmin password.

echo
echo "... and login with the following credentials: "
echo

az aro list-credentials \
  --name $CLUSTER \
  --resource-group $RESOURCEGROUP


