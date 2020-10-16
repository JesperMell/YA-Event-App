#!/usr/bin/env sh

######################################################################
# @author      : jesper (jesper@jesper-HP-ENVY-Laptop-13-aq0xxx)
# @file        : run
# @created     : fredag okt 16, 2020 11:50:04 CEST
#
# @description : A temporary solution to deploy the application to 
#              : production environment.
######################################################################

DOCKER_CONTAINER=1b18

docker restart $DOCKER_CONTAINER &&
        docker start $DOCKER_CONTAINER &&
	git pull &&
        docker exec -d -w /app $DOCKER_CONTAINER /bin/sh -c 'yarn install --check-files && export APP_DATABASE_PASSWORD=secret &&\n
  RAILS_ENV=production SECRET_KEY_BASE=production_key rake db:migrate assets:precompile &&\n
  RAILS_ENV=production SECRET_KEY_BASE=production_key rails s -b 0.0.0.0 -p 80'

