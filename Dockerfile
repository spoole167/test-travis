FROM ruby:2.3.0

RUN apt-get update

RUN apt-get install -y gem bundler

RUN apt-get install -y software-properties-common python-software-properties nodejs

RUN apt-get update

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -I google-chrome-stable_current_amd64.deb

RUN mkdir /dashboard
WORKDIR /dashboard
ADD ./Gemfile /dashboard/Gemfile
ADD ./Gemfile.lock /dashboard/Gemfile.lock
RUN gem update
RUN gem install bundler
RUN bundle install
