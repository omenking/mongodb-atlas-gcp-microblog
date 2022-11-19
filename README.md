# Building a Microblogging platform on MongoDB Atlas and GCP

# Motivation

I decided to enter the [MongoDB Atlas Hackathon](https://dev.to/devteam/announcing-the-mongodb-atlas-hackathon-2022-on-dev-2107) for the following reasons:

- I wanted to build a cloud project for folks that they could use on their résumé to get a cloud job
- I wanted to evalute MongoDB for myself as a Learning Record Store (LRS) for my platform
- I'm a GCP Cloud Champion and I wanted to contribute content for this year for modern application development
- I enjoy the MongoDB Lounge at re:Invent 2021, and I'm looking forward to the MongoDB Longue 2022 LOL.

## Scope

Lets build a simple microblogging project that allows users
to sign up and post simple 280 characters.

Things we might not implement so we can focus on cloud:
- profile pages
- followerships
- likings posts

This app might look ugly LOL.

We might not bother with IaC or CI/CD but if we did I'd use Github Actions and Terraform.

## Instructional Tutorial

This project's step by step instructions are tutorialized
in steps here in the docs directory:

- [Creating a Skeleton Sintra App as a docker container](docs/1-skeleton.md)
- [Deploying our container to Google Cloud Run](docs/gcp-run.md)
- [Implementing CRUD actions with local MongoDB](docs/mongdo-crud.md)
- [Provisoning a production MongoDB Atlas](docs/mongdo-atlas.md)
- [Implementing MongoDB Altas Search](docs/mongdo-atlas-search.md)
- [Implementing MongoDB Change Streams](docs/mongdo-atlas-change-streams.md)
- [Implementing Authenication](docs/auth.md)

## Requirements and Technology Choices

- Gitpod Account (For our Cloud Developer Enviroment)
- GCP Account
- MongoDB Atlas Account
- Authenication? (TBD)
- Ruby and Sinatra