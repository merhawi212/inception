# Inception

## Project Overview: Infrastructure Setup with Docker Compose

This project involves creating a small, containerized infrastructure using Docker Compose. The goal is to configure and deploy three key services—NGINX, WordPress, and MariaDB—each running in its own dedicated Docker container. The project emphasizes using Docker Compose to manage the interconnection of these services within a virtual machine environment.

## Purpose

The primary purpose of this project is to:

- **Learn Docker and Docker Compose**: Gain hands-on experience with Docker, Docker Compose, and containerized environments by building and managing Docker containers.
  
- **Build Docker Images from Scratch**: Create your own Docker images using Dockerfiles instead of pulling pre-built images, deepening your understanding of how Docker images are constructed and optimized for performance.

- **Set Up a Secure Web Environment**: Configure NGINX to use TLSv1.2 or TLSv1.3, ensuring secure communications for your WordPress site.

- **Understand Service Isolation**: Run each service (NGINX, WordPress, MariaDB) in a separate container to grasp the concept of service isolation, which enhances security and simplifies management.

- **Manage Data Persistence**: Set up volumes for your WordPress database and website files, ensuring data persists even if containers are stopped or restarted.

- **Network Configuration**: Establish a Docker network that allows the containers to communicate securely and efficiently, mimicking a real-world microservices environment.


## Project Requirements

Please refer to the [project requirements document](en.subject.pdf) for detailed information.

### Docker Containers

- **NGINX**: Configured with TLSv1.2 or TLSv1.3, serving as the web server and reverse proxy.
- **WordPress + PHP-FPM**: Set up in a dedicated container, running PHP code for WordPress.
- **MariaDB**: Running as the database server for WordPress.

### Volumes

- A volume for the WordPress database to store data persistently.
- A volume for the WordPress site files to ensure persistent storage of website content.

### Networking

A Docker network interconnects all containers, enabling secure communication through network segregation and SSL encryption, ensuring efficient and secure interaction between them.

## Build Process

You must create Dockerfiles for each service and build the Docker images locally using the provided Makefile or Docker commands manually. Pulling images from external sources like DockerHub is not allowed, except for Alpine/Debian.

By completing this project, you will develop a strong foundational understanding of Docker and containerization, while setting up a functional, secure web infrastructure.


## Usage

### Prerequisites

- **Docker Desktop**
- **Docker Compose** (For Docker V2, installing Docker Compose separately is not needed)
- **Virtual Machine** (Optional, not needed for local testing)
## Setup
```git clone https://github.com/merhawi212/inception.git && cd inception```
### Running the Service

#### Locally Testing

To build and run the services locally, execute the following command:

```make up ```

  


#### 42 Project Requirements

For the 42 project, the services must run in a virtual machine. Follow these steps to meet the project requirements:

1. **Update Environment Variables**:
   - Edit the `DOMAIN_NAME` in the [.env](srcs/.env) file to your 42 login: `<your 42 login>.42.fr`.

2. **Update NGINX Configuration**:
   - Modify the `server_name` value in the [nginx.conf](srcs/requirements/nginx/conf/nginx.conf) file to your custom domain name: `<your 42 login>.42.fr`.

3. **Configure Hosts File**:
   - Add your custom domain name to the `/etc/hosts` file, mapping it to the loopback address. You don't need to remove the existing hosts.

4. **Update Docker Compose Volumes**:
   - Uncomment the Docker volumes section in the [docker-compose.yml](srcs/docker-compose.yml).
   - Update the volume paths for each service as follows:
     - Change ` ./data/wordpress` to `wordpress`
     - Change `./data/mariadb` to `mariadb`

5. **Update Makefile**:
   - Uncomment the following lines in the Makefile under the `up` rule:
     - `@mkdir -p /home/${USER}/data/db`
     - `@mkdir -p /home/${USER}/data/wp`

6. **Build and Run the Services**:
   - Build and run the services using the command:
     ```bash
     make up
     ```

**Note**: You can also customize the [.env](srcs/.env) file as needed.

Remember, Docker containers are like good friends—reliable, portable, and always there when you need them. Just don't forget to feed them (or, in this case, keep your images up to date)! 😄