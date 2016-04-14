FROM dashboard
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get -y update
RUN apt-get install -y -q wget
RUN echo "deb http://mozilla.debian.net/ jessie-backports firefox-release" > /etc/apt/sources.list.d/mozilla.list

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
RUN apt-get update -y
RUN apt-get install -y --force-yes firefox
RUN apt-get install -y -q \
  google-chrome-beta \
  openjdk-7-jre-headless \
  x11vnc \
  xvfb \
  xfonts-100dpi \
  xfonts-75dpi \
  xfonts-scalable \
  xfonts-cyrillic
RUN useradd -d /home/seleuser -m seleuser
RUN mkdir -p /home/seleuser/chrome
RUN chown -R seleuser /home/seleuser
RUN chgrp -R seleuser /home/seleuser

RUN wget -qO- https://deb.nodesource.com/setup_5.x | sudo bash -
RUN sudo apt-get install -y nodejs
#ADD ./scripts/ /home/root/scripts
RUN npm install -g selenium-standalone@5.0.0
RUN npm install -g phantomjs-prebuilt@2.1.4 
RUN apt-get install -y unzip
RUN wget -N http://chromedriver.storage.googleapis.com/2.20/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN chmod +x chromedriver
RUN mv -f chromedriver /usr/local/share/chromedriver
RUN ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
RUN ln -s /usr/local/share/chromedriver /usr/bin/chromedriver
ADD xvfb.init /etc/init.d/xvfb 
RUN chmod +x /etc/init.d/xvfb 
RUN update-rc.d xvfb defaults
