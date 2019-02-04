FROM ubuntu:16.04

ARG REQUIREMENTS_ARG
ARG SETTINGS_ARG
ARG SECRET_KEY_ARG

ENV REQUIREMENTS $REQUIREMENTS_ARG
ENV SETTINGS $SETTINGS_ARG
ENV SECRET_KEY $SECRET_KEY_ARG

# Install python 3.7, pip3, and nginx
RUN apt-get update
RUN apt-get install -y python3.5
RUN apt-get install -y python3-pip
RUN apt-get install -y nginx

# Make project directory in the new unbuntu container and copy this project into it.
RUN mkdir project
WORKDIR /project
COPY wagtail_demo wagtail_demo

# PIP install requirements.
WORKDIR /project/wagtail_demo/wagtail_demo/requirements
RUN pip3 install -r ${REQUIREMENTS}.txt

# NGINX configuration
COPY wagtail_demo/wagtail_demo/configs/nginx/nginx.conf /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/django_nginx.conf

# Run docker-entrypoint
WORKDIR /project
COPY ./docker-entrypoint.sh ./docker-entrypoint.sh
RUN chmod +x ./docker-entrypoint.sh
ENTRYPOINT ./docker-entrypoint.sh

# Expose port 8000 to the outside world.
EXPOSE 8000