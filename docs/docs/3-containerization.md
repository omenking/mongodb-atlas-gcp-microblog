## Contaizer  flask App (Backend)


### Create Containerfile

Create in `app/Dockerfile`

```dockerfile
FROM python:3.10-slim-buster
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
COPY . .
EXPOSE ${PORT}
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=4567"]
```

### Build Container

```sh
docker build -t  backend-flask ./app
 ```

 ## Run Container

 ```
 docker run -p 4567:4567 -it backend-flask
 ```


### Send a curl to the server

If we curl the server:
```
curl -X GET http://localhost:4567/api/activities/home -H "Accept: application/json" -H "Content-Type: application/json"
```

 ## Check the container logs


 ## If we need to delete the iamge

 ```
 docker image rm backend-flask --force
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
RUN npm instalGl
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
    environment:
      FRONTEND_URL: "https://3000-omenking-mongodbatlasgc-at0turkspl0.ws-us77.gitpod.io"
      BACKEND_URL: "https://4567-omenking-mongodbatlasgc-at0turkspl0.ws-us77.gitpod.io"
    build: ./app
    ports:
      - "4567:4567"
    volumes:
      - ./app:/app
  frontend:
    environment:
      REACT_APP_BACKEND_URL: "https://4567-omenking-mongodbatlasgc-at0turkspl0.ws-us77.gitpod.io"
    build: ./frontend
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/frontend
```

```
docker compose -p cruddur build
```

```
docker compose -p up build
```

> We are using the -p flag so that the prepended name is not the folder name but instead an easier name to work with

## Considerations

- We had to remove the ENV Var set in the npm start
- We had to do npm install before we did a build of the frontend file