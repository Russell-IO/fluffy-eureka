FROM ruby:2.1-onbuild
MAINTAINER Russell Clare Russell@Clare.io

EXPOSE 4567

CMD ["./api.rb"]
