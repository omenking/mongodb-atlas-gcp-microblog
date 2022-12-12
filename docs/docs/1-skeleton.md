# Creating a Skeleton Flask App as a docker containe

I want to keep this application is simple as possible.
Rails has alot of great built-in stuff, but when we are building modern applications and want to best leverage serverless or managed cloud services with a cloud-first approach, alot of the framework gets abstracted away.

We are going to try to keep the code as much as possible in a single file.

## Create a Flask web-app directory and file structure

Create an new directory called app with the following files:

```
mkdir app
cd app
touch app.py requirements.txt Dockerfile
```

- app.py - will contain on programming code
- requirements.txt -  will contain the python pip depencies for our backend
- Dockerfile - the build instructions for our backend container

We will end up with a directory structure that looks like this:

```
- app
  - app.py
  - requirements.txt
  - Dockerfile
```

## Defining Our API

Our sintra app will be responsbile for serving up our API as JSON.
Lets first describe our endpoints before we implement them:

- GET /api/activities/home - the activity for entire website (the townsquare)
- GET /api/activities/user/:handle - the activity for a specific user
- POST /api/activities - a user creating an activity
- GET /api/activities/search?term=term - being able to search across all activity

> There will be more api endpoints later we implement Authenication


