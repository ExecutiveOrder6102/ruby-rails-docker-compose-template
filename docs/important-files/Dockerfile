ARG SOURCE_RUBY_IMAGE_VER=latest
FROM ruby:$SOURCE_RUBY_IMAGE_VER
RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app
CMD bin/rails server -p 3000 -b '0.0.0.0'