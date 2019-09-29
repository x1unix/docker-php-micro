# PHP Micro

Tiny Docker image for PHP projects development. Based on official [PHP Docker image](https://hub.docker.com/_/php).

* **[Docker Hub](https://hub.docker.com/r/x1unix/php-micro)**
* **[GitHub](https://github.com/x1unix/docker-php-micro)**

## Contents

This image contains PHP and Composer. This image doesn't contain Apache and uses plain PHP web-server as container entrypoint.

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
      COMPOSER_REQUIRE: laravel/installer   # Install Laravel CLI globally
      HTTP_DIR: public      # Serve from 'public' directory
    volumes:
      - ./src:/var/www/html # Mount 'src' as project directory
    ports:
      - 8080:8080           # Expose port 8080

```

**Ports:**

* `8080` - PHP web server

**Volumes:**

* `/var/www/html` - PHP project directory

**Environment variables:**

* `COMPOSER_REQUIRE` - Multiline list of global Composer packages to install
* `HTTP_DIR` - Directory to serve by PHP's web server (some frameworks use sub-directory, like `public`) (default: `.`)

### Composer

To call Composer command, just call Composer from Docker container:

```
docker exec -it YOUR_CONTAINER composer --version
```

or *docker-compose* variant:

```
docker-compose exec SERVICE_NAME composer --version
```

Also, if you have global package installed, you can call it from Docker in the same way as above.

