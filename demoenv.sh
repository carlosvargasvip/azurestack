#!/bin/bash
# Script to build Demo Environment

#####################
# Variables
####################
#$logfilename=demobuildout-`date +%m%d%y%I%M%S`.log

print "Starting of Demo Build Out Script... "

clear
echo "Welcome to the Demo Azure Build Environment Script"
echo ""
echo "What's your username? Example: jsmith"
read demouser

echo "Type passwords for your vm's. 12 Characters minimum Example: P@ssw0rd1234"
read -s vmpass

#Test Variables
#echo $demouser
#echo $vmpass

# Create Resource Group for Demo Environment
echo "Creating Demo Resource Group... "
az group create -l eastus -n $demouser-DEMO-RG --tags "owner"="$demouser"

# Create Network for Demo Environment
echo "Creating Demo Network..."
az network vnet create -g $demouser-DEMO-RG -n DemoNetwork --address-prefix 10.0.0.0/16 --subnet-name DemoSubnet --subnet-prefix 10.0.0.0/24

# Create VM for Demo Environment
echo "Creating VM1 for Demo... - Please wait"
az vm create -n $demouser-vm1 -g $demouser-DEMO-RG --image Win2016Datacenter --size Standard_B2s --admin-username $demouser --admin-password $vmpass

echo "Creating VM2 for Demo... - Please wait"
az vm create -n $demouser-vm2 -g $demouser-DEMO-RG --image Win2016Datacenter --size Standard_B2s --admin-username $demouser --admin-password $vmpass

# Create Restore Resource Group
echo "Creating Resource Group for Restore Test..."
az group create -l eastus -n datto-restore --tags "owner"="$demouser"

#Crete Restore Network
echo "Creating Network Resources for Restore Test..."
 az network vnet create -g datto-restore -n datto-restore-vnet-eastus --address-prefix 10.0.0.0/16 --subnet-name default --subnet-prefix 10.0.0.0/24

#Finish Script
