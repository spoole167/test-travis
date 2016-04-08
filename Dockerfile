FROM ruby:2.2.2

RUN apt-get update

RUN apt-get install -y gem bundler 

RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get update
RUN apt-get install -y nodejs

RUN mkdir /dashboard
WORKDIR /dashboard
ADD ./Gemfile /dashboard/Gemfile
ADD ./Gemfile.lock /dashboard/Gemfile.lock
RUN bundle install
