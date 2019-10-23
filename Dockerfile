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
ENTRYPOINT ["/opt/openfoam6/platforms/linux64GccDPInt32Opt/bin/decomposePar"]
