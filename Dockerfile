FROM ruby:2.2.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libevent-dev

RUN mkdir /indiana-search
WORKDIR /indiana-search

ADD Gemfile /indiana-search/Gemfile
ADD Gemfile.lock /indiana-search/Gemfile.lock
ADD . /indiana-search

RUN bundle install
