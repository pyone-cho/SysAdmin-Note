# Docker Command List and Expressions

## Basic Commands

- `docker --version`
    - Displays the Docker version installed on your system.

- `docker info`
    - Provides detailed information about the Docker installation.

- `docker help`
    - Lists all available Docker commands and their usage.

## Image Management

- `docker images [OPTIONS] [REPOSITORY[:TAG]]`
    - Lists images.
    - eg `docker images --tree ubuntu:latest`

- `docker pull [OPTIONS] NAME[:TAG|@DIGEST]`
    - Pulls an image or a repository from a registry.
    - eg `docker pull -q ubuntu:latest`

- `docker build [OPTIONS] PATH | URL | -`
    - Builds an image from a Dockerfile.

- `docker rmi [OPTIONS] IMAGE [IMAGE...]`
    - Removes one or more images.

## Container Management

- `docker ps`
    - Lists all running containers.

- `docker ps -a`
    - Lists all containers.

- `docker run [OPTIONS] IMAGE [COMMAND] [ARG...]`
    - Runs a command in a new container.

- `docker start [OPTIONS] CONTAINER [CONTAINER...]`
    - Starts one or more stopped containers.

- `docker stop [OPTIONS] CONTAINER [CONTAINER...]`
    - Stops one or more running containers.

- `docker restart [OPTIONS] CONTAINER [CONTAINER...]`
    - Restarts one or more containers.

- `docker rm [OPTIONS] CONTAINER [CONTAINER...]`
    - Removes one or more containers.


## Network Management

- `docker network ls`
    - Lists all networks.

- `docker network create [OPTIONS] NETWORK`
    - Creates a new network.

- `docker network rm NETWORK [NETWORK...]`
    - Removes one or more networks.

## Volume Management

- `docker volume ls`
    - Lists all volumes.

- `docker volume create [OPTIONS] [VOLUME]`
    - Creates a new volume.

- `docker volume rm VOLUME [VOLUME...]`
    - Removes one or more volumes.

## Docker Compose

- `docker-compose up [OPTIONS] [SERVICE...]`
    - Builds, (re)creates, starts, and attaches to containers for a service.

- `docker-compose down [OPTIONS]`
    - Stops containers and removes containers, networks, volumes, and images created by `up`.

## Useful Expressions

- `docker exec [OPTIONS] CONTAINER COMMAND [ARG...]`
    - Runs a command in a running container.

- `docker logs [OPTIONS] CONTAINER`
    - Fetches the logs of a container.

- `docker inspect [OPTIONS] NAME|ID [NAME|ID...]`
    - Returns low-level information on Docker objects.
