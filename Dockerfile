FROM ruby:2.5-slim

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn vim

ENV HOME /var/www/myapp

RUN mkdir -p $HOME
WORKDIR $HOME

COPY Gemfile* $HOME
COPY . ./

ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

RUN bundle install
RUN bundle config --global frozen 1

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN apt-get update && apt-get upgrade -y
EXPOSE 3000

CMD bundle exec puma -C config/puma.rb
