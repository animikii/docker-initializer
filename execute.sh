#!/usr/bin/env bash

if [ ! -f "Gemfile" ]; then
  echo "[EXITING] Unable to find a Gemfile, are you sure your are at the root of your project directory?"
  exit
fi

if [ ! -f ".env" ]; then
  echo "[EXITING] Unable to find a .env, make sure you create one with a valid COMPOSE_PROJECT_NAME variable?"
  exit
fi

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
    echo "Skipping $1: File exsists"
  else
    download_file $1 $2
  fi
}

download_file 'bin/shell' 755
download_file 'bin/console' 755
download_file 'bin/exec' 755
download_file 'bin/server' 755
download_file 'bin/wait-for-it.sh' 755
download_file '.dockerignore'

update_file 'bin/build-docker' 755
update_file 'Dockerfile'
update_file 'docker-compose.yml'
