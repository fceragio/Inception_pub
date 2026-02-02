*This project has been created as part of the 42 curriculum by fceragio.*

--Description--
Inception is a system administration and DevOps project whose goal is to design and deploy a small web infrastructure using Docker and Docker Compose. The whole thing is an excuse to practice containerization in a hands-on way.

The infrastructure is composed of multiple isolated services running in dedicated containers:
- NGINX as a secure reverse proxy (TLS only)
- WordPress running with PHP-FPM
- MariaDB as the database backend

All services are built from scratch using custom Dockerfiles based on Alpine Linux.  
The project focuses on containerization principles, networking, persistent storage, and secure configuration using environment variables and secrets.

The stack includes:
- An NGINX container exposing only port 443 (TLSv1.2 / TLSv1.3)
- A WordPress container running PHP-FPM (no web server inside)
- A MariaDB container handling the database
- A Docker bridge network connecting the containers
- Two persistent Docker volumes:
  - WordPress files
  - MariaDB database data

Prerequisites
- Linux virtual machine
- Docker
- Docker Compose
- make

Virtual Machines vs Docker
A Virtual Machine emulates an entire operating system, including its own kernel.
So virtual machines have actually stronger isolation, but are way more heavy.

Docker containers share the host kernel and isolate applications at the process level.
So they are less isolated, but way lighter.


Secrets vs Environment Variables
Environment variables are used to configure applications dynamically without hardcoding values.
They are easy to use and supported natively by Docker.
Not secure for sensitive data if committed or logged

Docker secrets are designed to store sensitive information securely.
Not exposed in container logs and theyr access is limited to the container that needs them


Docker Network vs Host Network
Using the host network means containers share the host’s networking stack.
This compromises isolation, and is therefore forbidden by the assignment

A Docker bridge network provides an isolated virtual network.
Containers communicate using service names (DNS) instead of directly.
This requires more configuration, but grants proper isolation and safety.
In this project case the bridge:
	Allow NGINX to communicate with WordPress
	Allow WordPress to communicate with MariaDB
	Prevent direct external access to internal services
	Only NGINX exposes a port to the host (443).


Docker Volumes vs Bind Mounts
Bind mounts map a specific host path directly into a container.
Tightly coupled to host filesystem therefore less portable.

Docker volumes are managed by Docker itself.
Safer and more portable
In this project we have 2 docker volumes:
	One for MariaDB data
	One for WordPress files



--Instructions--

-make 		: first time start. It will create the necessary dirs and start the docker compose
-make up	: starts the containers
-make down	: stops the containers
-make fclean: resets everything

--AI Usage--
This project made limited use of AI tools for:
- Clarifying Docker and Docker Compose concepts.
- Reviewing documentation structure and wording.
- Assisting with troubleshooting configuration issues.

All architectural decisions, configuration files, and scripts were designed,
implemented, and validated manually.


--Resources--
Docker documentation
https://docs.docker.com/

Docker Compose
https://docs.docker.com/compose/

NGINX documentation
https://nginx.org/en/docs/

PHP-FPM documentation
https://www.php.net/manual/en/install.fpm.php

WordPress CLI
https://developer.wordpress.org/cli/

MariaDB documentation
https://mariadb.com/kb/en/documentation/

