FROM jenkins/jenkins:lts
MAINTAINER onisuly <onisuly@gmail.com>

# Add jenkins user to docker group
USER root
ARG dockerGid=999
RUN echo "docker:x:${dockerGid}:jenkins" >> /etc/group \ 
    && apt-get update && apt-get install -y libltdl7 \
    && rm -rf /var/lib/apt/list/*

# Install Jenkins plugins
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
