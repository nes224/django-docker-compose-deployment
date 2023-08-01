#!/bin/sh

set -e 

python manage.py wait_for_db
# What this will do is it will collect all of the static files that are added for each app in the django project.
# Convention is that you would create a folder called static in each of the apps. you want to collect all of the those static in the same place.
python manage.py collectstatic --noinput
python manage.py migrate

# We run the uwisky command which is the command for running whiskey. (uwsgi)
# -- socket run it on a socker on port 9000, and the socket is the type of connection that nginx can to uwhiskey so that can serve the application.
# --workers 4
# --master says run it as the master deamon so similar to daemon off in the nginx script, It make sure this command runs in the foreground.
# --enable-threads : multi-threading 
# --module app.wsgi, What this does is it says run the wishkey module.
uwsgi --socket :9000 --workers 4 --master --enable-threads --module app.wsgi