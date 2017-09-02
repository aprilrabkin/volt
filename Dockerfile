FROM ruby:2.4

# Setup the app directory within the docker image
#RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy Gemfiles prior to the rest of the app so we don’t have to reinstall dependencies every time
# we change app code.
COPY ["Gemfile", "Gemfile.lock", "/usr/src/app/"]

# Install our gems
RUN gem install --no-document --conservative bundler

# Install our bundle gems
RUN bundle install

# Copy our app, except the files specified in .dockerignore
COPY . /usr/src/app

# 9292 is Puma’s default port
EXPOSE 9292

# Default startup command
ENTRYPOINT ["puma", "config.ru"]
