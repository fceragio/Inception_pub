The project is designed to run in a Linux environment.
A virtual machine is recommended.

Required tools:
- Docker
- Docker Compose
- Make

A valid `/etc/hosts` entry must exist for the configured domain:

127.0.0.1 fceragio.42.fr in this case


Each service is isolated and has:
- Its own Dockerfile
- Service-specific configuration files
- Optional initialization scripts

The main orchestration is handled by `docker-compose.yml`, located in
the `srcs/` directory.


Non-sensitive configuration is defined in the `.env` file located in
`srcs/.env`.

This file contains:
- Domain configuration
- WordPress setup variables
- Database configuration variables


Sensitive data is handled using Docker secrets.

Secrets are stored in the `secrets/` directory and mounted inside
containers at runtime under `/run/secrets/`.

Each service reads its required secrets during startup through its
entrypoint scripts.


The project uses Docker named volumes to persist data.

Two volumes are defined:
- mariadb_data		found in /home/fceragio/data//data/mariadb
- wordpress_data	found in /home/fceragio/data//data/wordpress

These volumes are mapped to the host filesystem under:

/home/$USER/data/mariadb		in this case
/home/$USER/data/wordpress	in this case

Data persists across container restarts and rebuilds.


All containers are connected through a dedicated Docker network
defined in `docker-compose.yml`.

This allows internal communication between services while exposing
only NGINX to the host machine on port 443.


A Makefile is provided to simplify Docker commands.

make			create everything
make up			build
make down		stop
make prune		remove everything

Of course you can still interact directly with docker compose.
Some usefull commands would be:
Useful Docker commands

docker compose ps        # Check running containers
docker compose logs      # View logs
docker volume ls         # List volumes
docker volume inspect    # Inspect volume details
docker system prune      # Clean unused Docker resources
