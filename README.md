# PHP Micro

Tiny Docker image for PHP projects development. Based on official [PHP Docker image](https://hub.docker.com/_/php).

**[Docker Hub](https://hub.docker.com/r/x1unix/php-micro)** | **[GitHub](https://github.com/x1unix/docker-php-micro)**

## Contents

This image contains PHP and Composer. This image doesn't contain Apache server and uses plain PHP web-server as container entrypoint.

## Included modules

In addition, to built-in PHP modules, this image also includes several most popular modules:

* curl
* zip
* pdo_mysql
* pdo_pgsql
* mysqli
* pgsql
* mbstring
* opcache
* soap
* xml

To install additional module, use `docker-php-ext-install` tool. (see [Customization](#Customization) section)

## Usage

### Configuration

We recommend to use **docker-compose** with this image.

**Example:**

```yaml
version: '2'
services:
  php:
    image: x1unix/php-micro 
    environment:
      HTTP_DIR: public      # Serve from 'public' directory
    volumes:
      - ./src:/var/www/html                     # Mount 'src' as project directory
      - ./preinstall:/docker-entrypoint-init.d  # Mount additional scripts to setup container
    ports:
      - 8080:8080           # Expose port 8080

```

### Parameters

**Ports:**

* `8080` - PHP web server

**Volumes:**

* `/var/www/html` - PHP project directory
* `/docker-entrypoint-init.d` - Directory for additional setup shell scripts

**Environment variables:**

* `HTTP_DIR` - Directory to serve by PHP's web server (some frameworks use sub-directory, like `public`) (default: `.`)

### Customization

You can run additional shell scripts to install additional PHP module or Composer package
by mounting directory with shell scripts to `/docker-entrypoint-init.d`.

Each script will be executed at first container startup time.

### Composer and global tools

To call Composer command, just call Composer from Docker container:

```
docker exec -it YOUR_CONTAINER composer --version
```

or *docker-compose* variant:

```
docker-compose exec SERVICE_NAME composer --version
```

Also, if you have global package installed, you can call it from Docker in the same way as above.
