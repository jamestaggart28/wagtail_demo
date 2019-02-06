# Wagtail Demo

Simple bootstrapped demo of wagtail cms.

## Local Setup

Mac installation for Docker

https://docs.docker.com/docker-for-mac/install/

Running NGINX and UWSGI
1. git clone https://github.com/jamestaggart28/wagtail_demo.git
2. docker-compose up
3. In your browser navigate to: 0.0.0.0:8000

Getting shell access
1. docker-compose exec app bash

## Amazon Elastic Container Service (Amazon ECS) Deployments

### Push to Amazon Elastic Container Registry (Amazon ECR)

1. Create repo.
2. Click the copy button next to the URI.
3. Create a file for your reference with the following information:
- REPO URI: Paste the URI you copied for the repo.
- ENVIRONMENT: The type of environment you are setting up. (dev, staging, or production).
- SETTINGS: The name of the settings file you want to run no extension.
- REQUIREMENTS: The name of the requirements file you want to run no extension.
- DJANGO SECRET KEY: The secret key you are going to use for this container.

Note: Ideally ENVIRONEMNT, REQUIREMENTS, and SETTINGS should all be the same value matching the type of environment you are trying to create. 

4. Run the following commands on mac and linux:
 - $(aws ecr get-login --no-include-email --region us-east-1)
 - docker build -t wagtail_demo --build-arg SETTINGS_ARG= <__SETTINGS__> --build-arg REQUIREMENTS_ARG=<__REQUIREMENTS__> .
 - docker tag wagtail_demo:latest <__REPO URI__>:<__ENVIRONMENT__>
 - docker push <__REPO URI__>:<__ENVIRONMENT__>

### ECS Steps:

1. Click the getting started button.
2. Choose the custom container definition with appropriate <__REPO URI__>:<__ENVIRONMENT__> tag.
3. Port Map 8000
4. Setup the following environment variables for the container:
- SETTINGS: The name of the settings file you want to run no extension.
- REQUIREMENTS: The name of the requirements file you want to run no extension.
- DJANGO SECRET KEY: The secret you are going to use for this container.
5. Follow the rest of the prompts and launch the cluster.
6. Click on your new cluster, go to the running task, and visit <__PUBLIC IP__>:8000 in your browser.
