FROM ubuntu:16.04
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install apt-file
RUN apt-get -y install software-properties-common
RUN apt-get -y install wget
RUN sh -c "wget -O - http://dl.openfoam.org/gpg.key | apt-key add -"
RUN add-apt-repository http://dl.openfoam.org/ubuntu
RUN apt-get -y install apt-transport-https
RUN apt-get -y update
RUN apt-get -y install openfoam6
RUN echo "source /opt/openfoam6/etc/bashrc" >> ~/.bashrc
RUN apt install unzip
RUN apt install awscli -y
RUN apt-get install sudo
RUN wget https://downloads.whamcloud.com/public/lustre/lustre-2.10.6/ubuntu1604/client/lustre-client-modules-4.4.0-131-generic_2.10.6-1_amd64.deb
RUN wget https://downloads.whamcloud.com/public/lustre/lustre-2.10.6/ubuntu1604/client/lustre-utils_2.10.6-1_amd64.deb
RUN apt-get install -y ./lustre-*_2.10.6*.deb; exit 0
ADD cfdrun.sh /opt/openfoam6/platforms/linux64GccDPInt32Opt/bin/cfdrun.sh
ENTRYPOINT ["/opt/openfoam6/platforms/linux64GccDPInt32Opt/bin/cfdrun.sh"]
