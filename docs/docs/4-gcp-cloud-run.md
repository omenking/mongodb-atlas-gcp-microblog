## Setup a new project and cloudshell

### Create a new project
In GCP we need to create a new project

```sh
gcloud projects create cruddur --name="Cruddur"
```

### Set to shell to the new project

```sh
gcloud config set project cruddur
```

### Set the compute region

```
gcloud config set compute/region us-east1
gcloud config get-value compute/region
```

### Configure some Env vars for convientnce

```sh
export PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')
export REGION=$(gcloud config get-value compute/region)
```

## Push containers to GCP Artifact Registry

We first need to push these images to the artifact registry.

We'll run these commands in GCP CloudShell

```sh
gcloud artifacts repositories create backend-sinatra \
--repository-format=docker \
--location=$REGION \
--description="Backend Sinatra for Cruddur Microblogger"
```

```sh
gcloud artifacts repositories create frontend-react \
--repository-format=docker \
--location=$REGION \
--description="Frontend React for Cruddur Microblogger"
```

## Configure Docker Authentication to Artifact Registry

```sh
gcloud auth configure-docker us-east1-docker.pkg.dev
```

### Tag Containers

```
docker images
```

```
docker tag mongodb-atlas-gcp-microblog-app us-east1-docker.pkg.dev/cruddur/backend-sinatra:latest
docker tag mongodb-atlas-gcp-microblog-frontend us-east1-docker.pkg.dev/cruddur/frontend-react:latest
```

## Push containers 

```
docker push us-east1-docker.pkg.dev/cruddur/backend-sinatra:latest
docker push us-east1-docker.pkg.dev/cruddur/frontend-react:latest
```