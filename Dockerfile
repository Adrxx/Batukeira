FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
#Install ImageMagick
RUN apt-get install -y \
    wget \
    imagemagick
RUN mkdir /Batukeira
WORKDIR /Batukeira
ADD Gemfile /Batukeira/Gemfile
ADD Gemfile.lock /Batukeira/Gemfile.lock
RUN bundle install --without development test
ADD . /Batukeira