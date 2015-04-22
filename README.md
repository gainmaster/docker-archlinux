# Docker Arch Linux

[![Build Status](http://ci.hesjevik.im/buildStatus/icon?job=docker-archlinux)](http://ci.hesjevik.im/job/docker-archlinux/) [![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg?style=plastic)][docker_hub_repository]

This repository contains a **Dockerfiles** for Arch Linux docker images. This repository is a part of an automated build, published to the [Docker Hub][docker_hub_repository].

[docker_hub_repository]: https://registry.hub.docker.com/u/gainmaster/archlinux/

## Docker Hub repository tags

`ganmaster/archlinux` provides multiple tagged images:

* `latest` : Alias to `base`
* `base` : Arch Linux pacstraped with base group
* `base-devel` : Arch Linux pacstraped with base-devel group

## Refrences

These refrences have been helpful when creating this repository:

* [jprjr's Github repository with an Arch Linux Docker image][github_repository_jprjr_docker_archlinux]
* [dotCloud's script for making an Arch Linux image][github_docker_docker_contrib_mkimage_arch]
* [GitHub - Working with large files][github_working_with_large_files]
* [yegor265 - Run as a non-root user inside docker][yegor265_docker_as_non_root]
* [DigitalOcean's tutorial on etcd and confd][digitalocean_tutorial_etcd_confd]
* [Gliderlabs Docker Alpine GitHub repository][gliderlabs_github_docker_alpine]

[github_repository_jprjr_docker_archlinux]: https://github.com/jprjr/docker-archlinux
[github_docker_docker_contrib_mkimage_arch]: https://github.com/docker/docker/blob/master/contrib/mkimage-arch.sh
[github_working_with_large_files]: https://help.github.com/articles/working-with-large-files/
[yegor265_docker_as_non_root]: http://www.yegor256.com/2014/08/29/docker-non-root.html
[digitalocean_tutorial_etcd_confd]: https://www.digitalocean.com/community/tutorials/how-to-use-confd-and-etcd-to-dynamically-reconfigure-services-in-coreos
[gliderlabs_github_docker_alpine]: https://github.com/gliderlabs/docker-alpine