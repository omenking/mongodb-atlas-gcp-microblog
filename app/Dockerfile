FROM ruby:3.1.0

# sets the default port (it can still be overriden)
ENV PORT=4567

ADD . /app
WORKDIR /app
RUN bundle install
EXPOSE ${PORT}
CMD [ "sh", "-c", "bundle exec rackup --host 0.0.0.0 -p $PORT"]