FROM ubuntu

RUN apt-get update
RUN apt-get install -y python3.7
RUN apt-get install -y python3-pip

RUN mkdir project
WORKDIR /project

COPY wagtail_demo wagtail_demo

WORKDIR /project/wagtail_demo/wagtail_demo/requirements

RUN pip3 install -r local.txt

WORKDIR /project/wagtail_demo

RUN python3 manage.py makemigrations
RUN python3 manage.py migrate

EXPOSE 8000