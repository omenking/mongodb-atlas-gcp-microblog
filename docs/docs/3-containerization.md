## Contaizer  Sinatra App (Backend)


### Create Containerfile

Create in `app/Dockerfile`

```dockerfile
FROM ruby:3.1.0

ADD . /app
WORKDIR /app
RUN bundle install
EXPOSE 4567
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
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
curl -X GET http://localhost:4567/api/activities/home -H "Accept: application/json" -H "Content-Type: application/json"
```

 ## Check the container logs


 ## If we need to delete the iamge

 ```
 docker image rm backend-sinatra --force
 ```

## Debugging Connection Refused

Great article about networking debugging and how linux networking works.
https://pythonspeed.com/articles/docker-connection-refused/

## Create Dockerfile for React App (Frontend)

## Build Container

Create this in `frontend/Dockerfile`:

```dockerfile
FROM node:12.16.1-alpine

COPY . /frontend
WORKDIR /frontend
RUN npm install
EXPOSE 3000
CMD ["npm", "start"]
```

```
docker build -t frontend-react ./frontend
```

 ## Run Container

 ```
 docker run -p 3000:3000 -it frontend-react
 ```

## Multi-Container with Docker Compose

We'll create the follwoing file in the root of our projects `docker-compose.yml`:

```yaml
version: "3.8"
services:
  app:
    build: ./app
    ports:
      - "4567:4567"
    volumes:
      - ./app:/app
  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/frontend
```