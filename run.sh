#!/usr/bin/env sh

######################################################################
# @author      : jesper (jesper@jesper-HP-ENVY-Laptop-13-aq0xxx)
# @file        : run
# @created     : fredag okt 16, 2020 11:50:04 CEST
#
# @description : A temporary solution to deploy the application to 
#	       : production environment.
######################################################################

DOCKER_CONTAINER=1b18

RAILS_PROD_CMD='RAILS_ENV=production SECRET_KEY_BASE=production_key'

docker restart $DOCKER_CONTAINER
docker start $DOCKER_CONTAINER

git pull

docker exec -w /app -d $DOCKER_CONTAINER /bin/sh -c '
  export APP_DATABASE_PASSWORD=secret &&\n
  $RAILS_PROD_CMD rake db:migrate assets:precompile &&\n
  $RAILS_PROD_CMD rails s -b 0.0.0.0 -p 80
'



