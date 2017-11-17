FROM ubuntu:14.04
MAINTAINER Christian Geymonat


RUN apt-get update && apt-get install -y \
    apt-transport-https software-properties-common wget \
 && rm -rf /var/lib/apt/lists/*


RUN wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_9.4.6~kxstudio1_all.deb

RUN dpkg -i kxstudio-repos_9.4.6~kxstudio1_all.deb && \
	dpkg --add-architecture i386 

RUN apt-get update && apt-get install -y lmms-vst-full:i386 lmms cadence kxstudio-meta-wine kxstudio-default-settings \
 && rm -rf /var/lib/apt/lists/*



RUN useradd -ms /bin/bash developer
RUN addgroup developer audio
RUN echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER developer
WORKDIR /home/developer


