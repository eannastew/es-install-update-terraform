#!/bin/bash
# This scrip will install or update terraform binary

# Check if variables were inputted as arguments
if [ $# -lt 2 ]
then
  echo "Usage : $0 OS version"
	echo "OS Options:"
  echo "           mac"
  echo "           linux"
  exit
fi

# Set terraform version to be installed
tf_version=$2

echo " ########################################################### "
# Use case to set variables for download URL
case "$1" in

mac)  echo " #######  Updating Terraform for $1, Version $2 ####### "
      tf_os=darwin_amd64
      ;;
linux)  echo " #######  Updating Terraform for $1, Version $2 ####### "
        tf_os=linux_amd64
        ;;
esac
echo " ########################################################### "

printf "\n"
echo " ##############  Downloading terraform version $tf_version  ############## "
wget https://releases.hashicorp.com/terraform/${tf_version}/terraform_${tf_version}_${tf_os}.zip -q --show-progress
printf "\n ##############  Deflating ##############  \n"
unzip terraform_${tf_version}_${tf_os}.zip

printf "\n ##############  Moving terraform binary to bin folder ############## \n"
sudo mv terraform /usr/local/bin/
echo .........................

# Remove extracted binary from working directory
echo " ##############  Cleaning up extracted binary ##############  "
rm -rf terraform
echo .........................

# Show version of terraform post installation
echo " ##############  Terraform installed :: Validation next ############## "
terraform version
