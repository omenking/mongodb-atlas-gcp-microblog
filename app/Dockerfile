FROM ruby:3.1.0

ADD . /app
WORKDIR /app
RUN bundle install
EXPOSE 4567
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]