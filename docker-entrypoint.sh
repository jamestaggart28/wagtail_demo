#!/bin/bash
cd ./wagtail_demo
python3 manage.py migrate
python3 manage.py collectstatic --no-input
/etc/init.d/nginx start
uwsgi --socket /project/wagtail_demo/wagtail_demo/configs/wagtail_demo.sock --module wagtail_demo.wsgi --chmod-socket=666