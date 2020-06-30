FROM ruby:2.6.6-buster
MAINTAINER Russell Clare Russell@Clare.io
EXPOSE 8080

RUN bundle config --global frozen 1
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["./api.rb"]
