FROM ruby:2.6.5

### ----------------------------------- apt-get
RUN apt-get update 

# ImageMagick
# RUN apt-get update && apt-get install -y libmagickwand-dev graphicsmagick-libmagick-dev-compat
# ENV PATH="/usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16:${PATH}"

# nodejs
# RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
# RUN apt-get update && apt-get install -y nodejs

# yarn
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# RUN apt-get update && apt-get install -y yarn

# postgres
# RUN apt-get update && apt-get install -y postgresql-client

# mysql
# RUN apt-get update && apt-get install -y mariadb-client 

### ----------------------------------- Setup the working directory and link it to our host directory
RUN mkdir /app
WORKDIR /app
COPY . /app

### ----------------------------------- Install bundler
RUN gem install bundler

### ----------------------------------- Run bundler
RUN bundle check || bundle install

### ----------------------------------- Run yarn install
# RUN yarn install --check-files

### ----------------------------------- Expose port 3000 to the world
EXPOSE 3000

### ----------------------------------- Start the main process.
CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]
