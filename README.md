# sakai-docker

A Docker container for the stable version of the [Sakai](https://github.com/sakaiproject/sakai) LMS.

This container was created to help test the [Hypothesis
LMS](https://github.com/hypothesis/lms) integration.

## Usage

Build the docker image using:

```sh
make docker
```

The build process can take 10+ minutes depending on your system and internet
connection.

Once the image has been build, start Sakai in a Docker container using:

```sh
docker create -name sakai -p 8080:8080 hypothesis/sakai:12
```

The Sakai container will take several minutes to initialize when first started.

To see its status use:

```sh
docker logs -f sakai
```

Once initialization has completed, you can access Sakai by browsing to
http://localhost:8080.
