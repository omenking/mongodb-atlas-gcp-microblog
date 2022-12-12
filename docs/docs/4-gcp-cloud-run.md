## Install GCloud in Gitpod

https://cloud.google.com/blog/topics/developers-practitioners/serverless-load-balancing-terraform-hard-way
https://cloud.google.com/blog/topics/developers-practitioners/new-terraform-module-serverless-load-balancing
https://cloud.google.com/sdk/docs/install#deb
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_network_endpoint_group

```sh
sudo apt-get install apt-transport-https ca-certificates gnupg -y
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-cli -y
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
gcloud artifacts repositories create backend-flask \
--repository-format=docker \
--location=$REGION \
--description="Backend flask for Cruddur Microblogger"
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

## Update containers to listen on env var port

GCP Cloud Run expects the app to listen on port 8080.
You aren't suppose to hardcode the value but use an env var called PORT insteado

Update our dockerfile for `app/Dockerfile` to use env var PORT:

```dockerfile
FROM ruby:3.1.0

# sets the default port (it can still be overriden)
ENV PORT=4567

ADD . /app
WORKDIR /app
RUN bundle install
EXPOSE ${PORT}
CMD [ "sh", "-c", "bundle exec rackup --host 0.0.0.0 -p $PORT"]
```

https://stackoverflow.com/questions/40873165/use-docker-run-command-to-pass-arguments-to-cmd-in-dockerfile

You should probably test that its working correctly:
```
docker build -t cruddur-flask-backend ./app
docker run -e PORT=8080 -p:4567:8080 -it cruddur-flask-backend
```

### Tag Containers

> Pushes should be of the form docker push HOST-NAME/PROJECT-ID/REPOSITORY/IMAGE

```
docker images
```

```
docker compose -p cruddur build
```

```
docker tag cruddur-app us-east1-docker.pkg.dev/cruddur/backend-flask/backend-flask:latest
docker tag cruddur-frontend us-east1-docker.pkg.dev/cruddur/frontend-react/frontend-react:latest
```

### Push containers 

```
docker push us-east1-docker.pkg.dev/cruddur/backend-flask/backend-flask:latest
docker push us-east1-docker.pkg.dev/cruddur/frontend-react/frontend-react:latest
```

## Run Containers onto GCP

Now that we have containers in a repo.
We need to push them to GCP Cloud Run


### Install Terraform

```sh
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
```

### Create Terraform File

Well create a new folder called `iac-terraform` and new file in it called `main.tf`

```
mkdir iac-terraform
touch iac-terraform/main.tf
```

Inside our `main.tf`

```tf
provider "google" {
  project     = "cruddur"
  region      = "us-east1"
}

resource "google_cloud_run_service" "my_service" {
  provider = google

  name     = "backend"
  location = "us-east1"

  template {
    spec {
      containers {
        image = "us-east1-docker.pkg.dev/cruddur/backend-flask/backend-flask:latest"
      }
    }
  }
}
```

### Provision GCP Cloud Run

https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference

We are going to use GCloud to authenicate


Confirm who we are:
```
gcloud auth list 
gcloud config list account
```

We do need to auth again:

```
gcloud auth application-default login
```


```sh
cd iac-terraform
terraform init
```

Update .gitignore to include the following:

```
# Local .terraform directories
**/.terraform/*

# .tfstate files
*.tfstate
*.tfstate.*

# Crash log files
crash.log
crash.*.log

# Exclude all .tfvars files, which are likely to contain sensitive data, such as
# password, private keys, and other secrets. These should not be part of version 
# control as they are data points which are potentially sensitive and subject 
# to change depending on the environment.
*.tfvars
*.tfvars.json

# Ignore override files as they are usually used to override resources locally and so
# are not checked in
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Include override files you do wish to add to version control using negated pattern
# !example_override.tf

# Include tfplan files to ignore the plan output of command: terraform plan -out=tfplan
# example: *tfplan*

# Ignore CLI configuration files
.terraformrc
terraform.rc
```

## Enable gcloud services

```
gcloud services enable run.googleapis.com
```

## Run Terraform Plan

See if it catches anywheres

```
terraform plan
```

## Run Terraform Apply

```
terraform apply
```



