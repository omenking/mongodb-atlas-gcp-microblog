# Building a Microblogging platform on MongoDB Atlas and GCP

# Motivation

I decided to enter the [MongoDB Atlas Hackathon](https://dev.to/devteam/announcing-the-mongodb-atlas-hackathon-2022-on-dev-2107) for the following reasons:

- I wanted to build a cloud project for folks that they could use on their résumé to get a cloud job
- I wanted to evalute MongoDB for myself as a Learning Record Store (LRS) for my platform
- I'm a GCP Cloud Champion and I wanted to contribute content for this year for modern application development
- I enjoy the MongoDB Lounge at re:Invent 2021, and I'm looking forward to the MongoDB Longue 2022 LOL.

## Goal 

Build a simple microblogging platform to showcase a couple of features of MongoDB hosted on GCP and MongoDB Atlas

## Scope

- users can create an activity with 280 characters
- we can see activity for a specific user
- We will only show a history of the last 100 activity for any feed
- We can search all activity and show 30 results
- we can see changes pushed to the home feed in realtime
- users can create an account with (handle, email, password)

## Out-of-Scope

What is out of scope for this projecet:
- avatars
- advanced media content
- deleting (or editing activity)
- followerships
- liking

These are stretch goals for you to implement 🙃

## Other Considerations

- This app might look ugly LOL
- We aren't using Iac (if we did Terraform is a good choice)
- We aren't implement CI/CD (if we did Github Actions is a good choice)

These are stretch goals for you to implement 🙃

## Instructional Tutorial

This project's step by step instructions are tutorialized
in steps here in the docs directory:

- [Creating a Skeleton Sinatra App as a docker container](docs/1-skeleton.md)
- [Creating a simgple React frontend](docs/2-react.md)
- [Containerizing our fronend and backend](docs/3-containerizing.md)
- [Deploying our container to Google Cloud Run](docs/4-gcp-run.md)
- [Implementing CRUD actions with local MongoDB](docs/5-mongdo-crud.md)
- [Provisoning a production MongoDB Atlas](docs/6-mongdo-atlas.md)
- [Implementing MongoDB Altas Search](docs/7-mongdo-atlas-search.md)
- [Implementing MongoDB Change Streams](docs/8-mongdo-atlas-change-streams.md)
- [Implementing Authenication](docs/9-auth.md)

## Requirements and Technology Choices

- Gitpod Account (For our Cloud Developer Enviroment)
- GCP Account
- MongoDB Atlas Account
- Authenication? (TBD)
- Ruby and Sinatra
- React (no redux!)