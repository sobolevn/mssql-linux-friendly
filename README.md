# mssql-linux-friendly

[![wemake.services](https://img.shields.io/badge/style-wemake.services-green.svg?label=&logo=data%3Aimage%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAABGdBTUEAALGPC%2FxhBQAAAAFzUkdCAK7OHOkAAAAbUExURQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP%2F%2F%2F5TvxDIAAAAIdFJOUwAjRA8xXANAL%2Bv0SAAAADNJREFUGNNjYCAIOJjRBdBFWMkVQeGzcHAwksJnAPPZGOGAASzPzAEHEGVsLExQwE7YswCb7AFZSF3bbAAAAABJRU5ErkJggg%3D%3D)](http://wemake.services) [![Build Status](https://travis-ci.org/sobolevn/mssql-linux-friendly.svg?branch=master)](https://travis-ci.org/sobolevn/mssql-linux-friendly) [![Dockerhub](https://img.shields.io/docker/pulls/sobolevn/mssql-linux-friendly.svg)](https://hub.docker.com/r/sobolevn/mssql-linux-friendly/) [![image size](https://images.microbadger.com/badges/image/sobolevn/mssql-linux-friendly.svg)](https://microbadger.com/images/sobolevn/mssql-linux-friendly) [![mssql's version](https://img.shields.io/badge/version-2017.CU12-blue.svg)](https://github.com/Microsoft/mssql-docker)

`mssql` image that can be easily extended to load schema and data on startup.

Based on [an original `mssql` image](https://github.com/Microsoft/mssql-docker/tree/master/linux/mssql-server-linux) for Linux.

## Building

```bash
docker build -t mssql:latest .
```

## Configuration

We inherit the same configuration from `mssql`
that is provided by the original image from Microsoft:

- `ACCEPT_EULA=Y` env var, otherwise your container will not work
- `SA_PASSWORD=YOUR_PASSWORD` env var to set `sa` user's password

### Volumes

We also provide a volume with scripts (`./scripts`) to be extended later:

- `./scripts/schema.sql` contains schema definition file
- `./scripts/data.sql` contains your data that should be inserted on startup

They are both empty by default.

To customize these files use [`volumes`](https://docs.docker.com/engine/reference/commandline/run/#mount-volume--v---read-only):

```bash
docker run -v ./your/custom/scripts:/code/scripts -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=MyStrongPassword1' -p 1433:1433 -d mssql
```

## docker-compose

See [`docker-compose.yml`](https://github.com/sobolevn/mssql-linux-friendly/blob/master/docker-compose.yml) for a service example.

## License

MIT.
