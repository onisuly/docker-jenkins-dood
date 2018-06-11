# Jenkins with DooD (Docker outside of Docker)

[![Docker Build Status](https://img.shields.io/docker/build/onisuly/docker-jenkins-dood.svg)](https://github.com/onisuly/docker-jenkins-dood) [![Docker Automated build](https://img.shields.io/docker/automated/onisuly/docker-jenkins-dood.svg)](https://github.com/onisuly/docker-jenkins-dood) [![Docker Stars](https://img.shields.io/docker/stars/onisuly/docker-jenkins-dood.svg)](https://github.com/onisuly/docker-jenkins-dood) [![Docker Pulls](https://img.shields.io/docker/pulls/onisuly/docker-jenkins-dood.svg)](https://github.com/onisuly/docker-jenkins-dood)

This Dockerfile build an image for [Jenkins](https://jenkins.io/) with capabilities of using Docker outside of Docker.

![Jenkins](https://github.com/onisuly/docker-jenkins-dood/raw/master/images/jenkins-dood.png "Jenkins")  

## Quick Start

```shell
docker run -d -p 8080:8080 -p 50000:50000 --name jenkins --restart=always \
-v $(which docker):/usr/bin/docker \
-v /var/run/docker.sock:/var/run/docker.sock onisuly/docker-jenkins-dood
```

NOTE: read below the _build executors_ part for the role of the `50000` port mapping.

This will store the workspace in /var/jenkins_home. All Jenkins data lives in there - including plugins and configuration.
You will probably want to make that an explicit volume so you can manage it and attach to another container for upgrades :

```shell
docker run -d -p 8080:8080 -p 50000:50000 --name jenkins --restart=always \
-v /path/to/your/jenkins_home:/var/jenkins_home \
-v $(which docker):/usr/bin/docker \
-v /var/run/docker.sock:/var/run/docker.sock onisuly/docker-jenkins-dood
```

this will automatically create a 'jenkins_home' [docker volume](https://docs.docker.com/storage/volumes/) on the host machine, that will survive the container stop/restart/deletion.

NOTE: Avoid using a [bind mount](https://docs.docker.com/storage/bind-mounts/) from a folder on the host machine into `/var/jenkins_home`, as this might result in file permission issues (the user used inside the container might not have rights to the folder on the host machine). If you _really_ need to bind mount jenkins_home, ensure that the directory on the host is accessible by the jenkins user inside the container (jenkins user - uid 1000) or use `-u some_other_user` parameter with `docker run`.

---

Read [Jenkins documentation](https://github.com/jenkinsci/docker/blob/master/README.md) for more usages.