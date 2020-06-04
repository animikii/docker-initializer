# Animikii Dockerizer

This repo is meant to make the docker scripts on Animikii projects a bit more manageable if any of the process needs to change. Running this script should replace the bin/scripts so we can easily keep update our devops process.

Check out `update.sh` to see how/what it will attempt to replace, here's where the magic happens for updating everyones bin scripts. I've done my best to leave the configuration files untouched.

`update.sh` can also be used as a template for new projects, there are some code examples in these files.

Dependencies:
 - curl (`brew install curl`)

Note: UNTESTED in the real world so use with caution!


# Update

Update your bin scripts

```bash
bash <(curl -o- -L https://raw.githubusercontent.com/animikii/docker-initializer/master/execute.sh)
```

# Commands

### Build

Run the docker build process if you haven't ever run this locally. The life cycle is as follows:

1. `docker-before-build`
2. `docker-compse build`
3. `docker-after-build`

```bash
bin/build-docker
```

### Server

After your build is complete you should be able to start the development server with 

```bash
bin/server
```

### Shell

Do you need an interactive shell terminal inside the container? 

```bash
bin/shell
```

### Console

I've created a shortcut for Rails terminal

```bash
bin/console
```

### Exec

Sometimes you want to run a bash command directly in the container but don't care to have an interactive shell, try:

```bash
bin/exec
```

Example:

```bash
bin/server yarn install
```

# Configuration

At the moment there are 5 configuration files to get a project dockerized

### Dockerfile

Not much to do here, make sure your `apt-get` packages are correct for your project

- `mysql` will need `mariadb-client`
- `postgres` will need `postgresql-client`
- ImageMagick is SUPER finicky, I've had to play with tons of configurations and modifying the $PATH variable to make it work properly for older projects
- Yarn needs references updated when installing as a apt-get package


### Docker-compose

I've left templates for common images used like mysql, postgres, and redis

### .env

This isn't included in this at the moment, you'll have to manually add your `COMPOSE_PROJECT_NAME` environment variable into your project

### Before build

This script runs before the image is created, common tasks here are to copy the `database.yml`, `secrets.yml`, `master.key`

### After build

Finally after your image has successfully been created this script can run post build tasks like creating databases etc.

This has been the most challenging part of the process as it depends on everything running perfectly before this point. Additionally some containers will crash if the application throws an error. 

How do you run `bundle exec rake db:create` if there's no container? How do you start a container if it crashes because you haven't run `bundle exec rake db:create`? One depends on the other and vice-versa... If anyone knows please enlighten me!
