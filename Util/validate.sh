#!/bin/bash
clear

azure config mode arm
subscriptionId="f1766062-4c0b-4112-b926-2508fecc5bdf"
azure account set $subscriptionId

storageAccountName="rgcb"
containerName="deployrg"

# Create Resource Group
newResourceGroupName="rgcb1234"
location="westus"

azure group create --name $newResourceGroupName --location $location

# Validate template
templateUri="https://$storageAccountName.blob.core.windows.net/$containerName/mainTemplate.json"
#parametersFiles="./Params/mainTemplate.mds.password.newVNet.parameters.json ./Params/mainTemplate.nonMds.password.newVNet.parameters.json"
parametersFiles="./Params/mainTemplate.nonMds.password.newVNet.parameters.json"


for param in $parametersFiles
do
    echo "Testing $param"
    azure group template validate --resource-group $newResourceGroupName --template-uri $templateUri --parameters-file $param
done
