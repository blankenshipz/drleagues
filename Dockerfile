FROM ruby:latest

ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg
RUN echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential libpq-dev curl

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN apt-get update && apt-get install -qq -y --no-install-recommends nodejs yarn postgresql-client

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]
