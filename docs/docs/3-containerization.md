## Contaizer  Sinatra App (Backend)


### Create Containerfile

Create in `app/Dockerfile`

```dockerfile
FROM ruby:3.1.0

ADD . /app
WORKDIR /app
RUN bundle install
EXPOSE 4567
CMD ["/bin/bash"]
```

### Build Container

```sh
docker build -t  backend-sinatra ./app
 ```

 ## Run Container

 ```
 docker run -p 4567:4567 -it backend-sinatra
 ```


### Send a curl to the server

If we curl the server:
```
curl -X GET http://localhost:4567/api/activities \
-H "Accept: application/json" \
-H "Content-Type: application/json"
```

 ## Check the container logs


## Create Dockerfile for React App (Frontend)

```
docker build -t  backend-sinatra .
```



We'll create the follwoing file in the root of our projects `docker-compose.yml`:

```yaml
version: "3.8"
services:
  app:
    build: ./app
    command: bundle exec rackup --host 0.0.0.0 -p 4567
    ports:
      - "4567:4567"
    volumes:
      - ./app:/app
```