FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Setup the app directory within the docker image
RUN mkdir /app
WORKDIR /app

# Copy Gemfiles prior to the rest of the app so we don’t have to reinstall dependencies every time
# we change app code.
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]


# Install our gems
RUN gem install --no-document --conservative bundler

# Install our bundle gems
RUN bundle install

ADD . /app
EXPOSE 5432
EXPOSE 9292

# Default startup command
ENTRYPOINT ["puma", "config.ru"]
