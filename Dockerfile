FROM ubuntu:14.04
MAINTAINER Christian Geymonat


RUN apt-get update && apt-get install -y \
    apt-transport-https software-properties-common wget \
 && rm -rf /var/lib/apt/lists/*


#wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_9.4.6~kxstudio1_all.deb

RUN  wget https://launchpad.net/~kxstudio-debian/+archive/ubuntu/kxstudio/+files/kxstudio-repos_9.4.8~kxstudio1_all.deb

RUN dpkg -i kxstudio-repos_9.4.8~kxstudio1_all.deb && \
	dpkg --add-architecture i386 

RUN apt-get update && apt-get install -y lmms-vst-full:i386  && rm -rf /var/lib/apt/lists/* 
#lmms cadence \
#kxstudio-meta-wine kxstudio-meta-audio kxstudio-meta-audio-plugins kxstudio-meta-restricted-extras kxstudio-default-settings \
# && rm -rf /var/lib/apt/lists/*


#reinstall wine from ubuntu repository
#RUN apt-get update && apt-get install -y wine:i386 \
 #&& rm -rf /var/lib/apt/lists/*

#new wine 3.0
RUN wget -nc https://dl.winehq.org/wine-builds/Release.key
RUN apt-key add Release.key
RUN apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/

RUN apt-get update &&  apt-get install -y --install-recommends winehq-stable:i386
#-new wine 3.0

ENV WINEARCH=win32

RUN useradd -ms /bin/bash developer
RUN addgroup developer audio
RUN usermod -a -G users developer
RUN echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER developer
WORKDIR /home/developer

ADD ./initwine.sh  /home/developer/initwine.sh

