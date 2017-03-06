FROM ruby:2.3.0
MAINTAINER cam <cam@tuq.ca>
RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get update
RUN apt-get install -y --fix-missing graphicsmagick-libmagick-dev-compat

RUN apt-get update

USER root
RUN mkdir /var/unearthed
WORKDIR /var/unearthed
COPY . .
RUN useradd -ms /bin/bash unearthed
RUN chown -R unearthed:unearthed .
USER unearthed
RUN bundle install

EXPOSE 3000

USER root
WORKDIR /var/unearthed
CMD su unearthed -c "cd /var/unearthed && ./deploy"
