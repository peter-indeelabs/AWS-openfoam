Step 1:
Create instance 

Step 2:
create container 

Step 3:
Create FSX and Attach Lustre file system

Step 3a: https://docs.aws.amazon.com/fsx/latest/LustreGuide/install-lustre-client.html

Step 3b: 
Open a terminal
Create a new directory on your EC2 instance, for example /fsx
sudo mkdir /fsx
sudo mount -t lustre -o noatime,flock fs-03f7dae7c222360f2.fsx.us-west-2.amazonaws.com@tcp:/fsx /fsx

Step 4:
install openfoam
https://github.com/peter-indeelabs/AWS-openfoam/blob/master/aws-scripts.sh

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install apt-file
sudo apt-get -y install software-properties-common
sudo sh -c "wget -O - http://dl.openfoam.org/gpg.key | apt-key add -"
sudo add-apt-repository http://dl.openfoam.org/ubuntu
sudo apt-get -y install wget
sudo apt-get -y install apt-transport-https
sudo apt-get -y update
sudo apt-get -y install openfoam6
sudo echo "source /opt/openfoam6/etc/bashrc" >> ~/.bashrc
sudo apt install unzip
sudo apt install awscli

Step 5:
create virtual machine


