# Animikii Dockerizer

This repo is meant to make the docker scripts on Animikii projects a bit more manageable if any of the process needs to change. Running this script should replace the bin/scripts so we can easily keep update our devops process.

Check out `execute.sh` to see how/what it will attempt to replace, here's where the magic happens for updating everyones bin scripts. I've done my best to leave the configuration files untouched.

`execute.sh` can also be used as a template for new projects, there are some code examples in these files.

Dependencies:
 - curl (`brew install curl`)

# Update

Update your bin scripts

```bash
bash <(curl -o- -L https://raw.githubusercontent.com/animikii/docker-initializer/master/execute.sh)
```

# Commands

### Build

Run the docker build process if you haven't ever run this locally

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
bin/exec yarn install
```

# Configuration

At the moment there are 5 configuration files to get a project dockerized

### Dockerfile

Not much to do here, make sure your `apt-get` packages are correct for your project

Notes:

- `mysql` will need `mariadb-client`
- `postgres` will need `postgresql-client`
- ImageMagick is SUPER finicky, I've had to play with tons of configurations and modifying the $PATH variable to make it work properly for older projects
- Yarn needs references updated when installing as a apt-get package

### Docker-compose

I've left templates for common images used like mysql, postgres, and redis. 

Notes:

- Make sure volumes are correctly set, we want to save and persist database changes to your local machine and not to the container. Node modules and gem cache should be saved locally as well but this means that you'll need to purge them and rebuild the image when adding gems and using dockerhub.
- Make sure that the `image` name is correct, you don't want to have to rebuild the image all the time! Hopefully we will get these into DockerHub so that the compilation step can be avoided for everyone except the maintainer
- Remember to use foreman if that's what the project needs as a start `COMMAND`


# README FOR PROJECTS

Here's a sample readme for the any dockerized project, replace/modify/remove as needed:

`````markdown
## Setting up the Development Environment

Things you'll need:

1. Docker if you haven't installed it already (https://docs.docker.com/get-docker/). Ensure that it is started!
2. The `master.key` from the 1Password Devops vault. Search for "MY PROJECT NAME".

Clone the repo and `cd` into the project root and run:

```bash
bin/build-docker
```

grab a coffee/tea/kombucha/milkshake...

## Working with Development

##### `bin/server`

Run the development server, this starts your docker containers, `Command + C` will shutdown those containers as usual.

##### `bin/console`

Use Rails console, `exit` will exit the console as usual.

##### `bin/shell`

Open an interactive shell INSIDE your web container, handy if you need to snoop around inside the web container. You cannot shell into a container that hasn't started so use this alongside `bin/server`.

##### `bin/exec`

Execute a bash command directly INSIDE the web container. A `bin/shell` shortcut if you don't need to interact with the container, you can do things like `bin/exec yarn install`. This has a built in check the ensures that localhost:3000 is responsive before running your command

##### `bin/test`
Run minitests if they are set up. There are three different ways to run this script

1. `bin/test`                                Run the entire test suite
1. `bin/test path/to/test/file.rb`           Run a single file
1. `bin/test path/to/test/file.rb test_name` Run a single test in a file
`````

