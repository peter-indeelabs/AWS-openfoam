sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install apt-file
sudo apt-get -y install software-properties-common
sudo apt-get -y install wget
sudo sh -c "wget -O - http://dl.openfoam.org/gpg.key | apt-key add -"
sudo add-apt-repository http://dl.openfoam.org/ubuntu
sudo apt-get -y install apt-transport-https
sudo apt-get -y update
sudo apt-get -y install openfoam6
sudo echo "source /opt/openfoam6/etc/bashrc" >> ~/.bashrc
sudo apt install unzip
sudo apt install awscli
