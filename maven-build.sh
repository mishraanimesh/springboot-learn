#!/bin/bash
#
# Animesh <animesh.mishra@payu.in>
# it will have version - 
#  major.minor.build-env for example  0.0.1-dev  for dev branch  |  0.0.1-staging |  0.0.1-prod
# 



set -x
set -e

mvn -B clean package -DskipTests

echo 'Install into the local Maven repository'
mvn jar:jar install:install

NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`

mv  target/${NAME}-${VERSION}.jar target/app.jar



