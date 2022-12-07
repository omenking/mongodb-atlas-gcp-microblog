## Install GCloud in Gitpod

https://cloud.google.com/sdk/docs/install#deb

```sh
sudo apt-get install apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-cli
```

```
gcloud init
```

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

We first need to push these images to the GCP artifact registry.

### Create Repos

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

### Configure Docker Authentication to Artifact Registry

```sh
gcloud auth configure-docker us-east1-docker.pkg.dev
```

### Tag Containers

> Pushes should be of the form docker push HOST-NAME/PROJECT-ID/REPOSITORY/IMAGE

```
docker images
```

```

docker tag cruddur-app us-east1-docker.pkg.dev/cruddur/backend-sinatra/backend-sinatra:latest
docker tag cruddur-frontend us-east1-docker.pkg.dev/cruddur/frontend-react/frontend-react:latest
```

### Push containers 

```
docker push us-east1-docker.pkg.dev/cruddur/backend-sinatra/backend-sinatra:latest
docker push us-east1-docker.pkg.dev/cruddur/frontend-react/frontend-react:latest
```

## Run Containers onto GCP

Now that we have containers in a repo.
We need to push them to GCP Cloud Run