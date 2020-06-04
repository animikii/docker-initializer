#!/usr/bin/env bash

if [ ! -f "Gemfile" ]; then
  echo "[EXITING] Unable to find a Gemfile, are you sure your are at the root of your project directory?"
  exit
fi

if [ ! -f ".env" ]; then
  echo "[EXITING] Unable to find a .env, make sure you create one with a valid COMPOSE_PROJECT_NAME variable?"
  exit
fi

COMPOSE_PROJECT_NAME=$(grep COMPOSE_PROJECT_NAME .env | cut -d '=' -f2)
RAW_URL=https://raw.githubusercontent.com/animikii/docker-initializer/master

# Download a file from the repo
download_file(){
  if [[ "$1" == *"bin/"* ]]; then
    if [ ! -d "bin" ]; then mkdir -p bin; fi
  fi
  
  echo "downloading... $RAW_URL/$1 to $1"
  curl -s $RAW_URL/$1 > $1

  if [ -n "$2" ]; then
    echo "updating permissions to $2 on $1"
    chmod $2 $1
  fi
}

update_file(){
  if [ -f "$1" ]; then
    echo "$1 exists, would you like to replace it?"
    read -p '[y/n]: ' TRY_AGAIN
    if [[ $TRY_AGAIN == 'y' ]]; then
      download_file $1 $2
    else
      echo "skipping $1"
    fi
  else
    download_file $1 $2
  fi
}

update_file 'bin/shell' 755
update_file 'bin/build-docker' 755
update_file 'bin/console' 755
update_file 'bin/exec' 755
update_file 'bin/server' 755
update_file 'bin/wait-for-it.sh' 755
update_file 'bin/docker-before-build.sh' 755
update_file 'bin/docker-after-build.sh' 755

update_file '.dockerignore'
update_file 'Dockerfile'
update_file 'docker-compose.yml'

if [ ! -f "docker-compose.yml" ]; then
  echo "  setting COMPOSE_PROJECT_NAME as \"$COMPOSE_PROJECT_NAME\" in docker-compose.yml"
  sed -i "" "s/COMPOSE_PROJECT_NAME/$COMPOSE_PROJECT_NAME/g" docker-compose.yml
fi
