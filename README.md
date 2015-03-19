# Docker Arch Linux

This repository contains a **Dockerfile** for an Arch Linux docker image, a **Vagrantfile** for local development, and **shell scripts** for easy startup of container taks. This repository is a part of an automated build, published to the [Docker Hub][docker_hub_repository].

**Base image:** [scratch][docker_hub_base_image]

[docker_hub_repository]: https://registry.hub.docker.com/u/bachelorthesis/archlinux/
[docker_hub_base_image]: https://registry.hub.docker.com/_/scratch/


## Resources

These resources have been helpful when creating this repository:

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