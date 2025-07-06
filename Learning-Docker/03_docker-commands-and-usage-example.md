# docker commands and usage example
Let's explore some common Docker commands with usage examples:

##### 1. Image Management:

- `docker pull <image_name>:<tag>:`
    - Downloads an image from a registry (like Docker Hub). If no tag is specified, `latest` is assumed.
    - Example: `docker pull ubuntu:latest` (downloads the latest Ubuntu image)
- `docker images:`
    - Lists all locally stored images.
    - Example: `docker images` (shows all images)
- `docker rmi <image_id> or <image_name>:<tag>:` 
    - Removes one or more images.
    - Example: `docker rmi ubuntu:latest` (removes the Ubuntu image with the latest tag)
- `docker build -t <image_name>:<tag> <path_to_Dockerfile>:`
    - Builds an image from a Dockerfile.
    - Example: `docker build -t my-app:v1 .` (builds an image named `my-app` with tag `v1` from the Dockerfile in the `current directory`)

##### 2. Container Management:

- `docker run <options> <image_name>:<tag> <command>:`
    - Creates and starts a new container. Many options are available:
        - `-d:` Detached mode (runs in the background).
        - `-p <host_port>:<container_port>:` Publishes a container's port to the host.
        - `-v <host_path>:<container_path>:` Mounts a volume (for persistent data).
        - `--name <container_name>:` Assigns a name to the container.
        - Example: `docker run -d -p 8080:80 --name my-web-app my-app:v1` (runs the `my-app` image in detached mode, maps `port 8080` on the host to `port 80` in the container, and names the container `my-web-app`)
- `docker ps:` 
    - Lists running containers.
    - Example: `docker ps` (shows running containers)
- `docker ps -a:`
    - Lists all containers (running and stopped).
    - Example: `docker ps -a` (shows all containers)
- `docker start <container_id> or <container_name>:`
    - Starts a stopped container.
    - Example: `docker start my-web-app` (starts the container named my-web-app)
- `docker stop <container_id> or <container_name>:`
    - Stops a running container.
    - Example: `docker stop my-web-app` (stops the container named my-web-app)
- `docker restart <container_id> or <container_name>:`
    - Restarts a container.
    - Example: `docker restart my-web-app` (restarts the container named my-web-app)
- `docker rm <container_id> or <container_name>:`
    - Removes a stopped container.
    - Example: `docker rm my-web-app` (removes the container named my-web-app)
- `docker exec -it <container_id> or <container_name> <command>:`
    -   Executes a command inside a running container. -it provides an interactive terminal.
    -   Example: `docker exec -it my-web-app bash` (opens a bash shell inside the my-web-app container)
- `docker logs <container_id> or <container_name>:`
    - Shows the logs of a container.
    - Example: `docker logs my-web-app` (shows the logs of the my-web-app container)
- `docker inspect <container_id> or <container_name>:`
    - Displays detailed information about a container.
    - Example: `docker inspect my-web-app` (shows details about the my-web-app container)

##### Copy files between host and container
```bash
docker cp file.txt container_name:/path
docker cp container_name:/path/file.txt ./
```

##### Networking:
```bash
# Network management
docker network ls                      # List networks
docker network create mynetwork        # Create network
docker network connect mynetwork container_name  # Connect container to network

# Run container in specific network
docker run --network=mynetwork nginx
docker network ls                      # List networks
docker network create mynetwork        # Create network
docker network connect mynetwork container_name  # Connect container to network

# Run container in specific network
docker run --network=mynetwork nginx
```

##### 3. Docker Compose (for multi-container applications):

-   `docker-compose up -d:`
    - Builds and starts the services defined in a docker-compose.yml file in detached mode.
- `docker-compose down:`
    - Stops and removes the services defined in a docker-compose.yml file.

Example docker-compose.yml:
```YAML
version: "3.9"
services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
  db:
    image: postgres:latest
    environment:
      POSTGRES_USER: myuser
      POSTGRES_PASSWORD: mypassword
```
Workfloe Example:
1. Docker compose Up: `docker compose up -d`
2. Check running containers: `docker ps`
3. Inspect container details: `docker inspect container_name`
4. Execute commands in running container(Get interactive shell): `docker exec -it container_name bash`
(Run specific command): `docker exec container_name ls /app`
5. Stop a container: `docker compose down`


Docker 
Workflow Example:

1. Build an image: `docker build -t my-app:v1 .`
2. Run a container: `docker run -d -p 8080:80 --name my-app-container my-app:v1`
3. Check running containers: `docker ps`
4. Stop a container: `docker stop my-app-container`
5. Remove a container: `docker rm my-app-container`
6. Remove an image: `docker rmi my-app:v1`
This covers a wide range of common Docker commands.  Remember to consult the official Docker documentation for a complete list and detailed explanations of all available options.  Practice with these commands to become comfortable with Docker.