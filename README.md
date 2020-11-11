# Installation

There's a `Dockerfile` included that can be used to build and run a
Docker container. (Containers are basically lightweight virtual
machines; you can read more about them on the [Docker
website](https://docs.docker.com/get-started/#docker-concepts).

The Docker container runs an embedded Ruby server. The server will
automatically reflect changes made in your project directory.

- [Install Docker](https://docs.docker.com/install/#server)
- [Install `docker-compose`](https://docs.docker.com/compose/install/#install-compose)
- Check out this project: `git clone git@github.com:code4sac/citygram-sacramento-api`
- Change into the project directory: `cd citygram-sacramento-api`
- Build the Docker container: `docker-compose build`
- Start the container up: `docker-compose up`
- Check that the server is running: http://localhost:1850/
- If you see the text `Hello World!`, then everything worked!
- Check out the [[app.rb]] file for other available routes.

