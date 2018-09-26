#!/bin/bash
#
# Animesh <animesh.mishra@payu.in>
# it will have version - 
#  major.minor.build-env for example  0.0.1-dev  for dev branch  |  0.0.1-staging |  0.0.1-prod
# 



set -x
set -e



PROJECT_VERSION=${1:-0.0.0-default}
PROJECT_ENV=${2:-dev-default}
NOW= date "+%Y-%m-%d-%H:%M:%S"
BUILD_NUMBER=${3:-9999}

echo "Project Version is  " + ${PROJECT_VERSION}
echo "Project ENV is "  +  ${PROJECT_ENV}
echo "Build Number is " + ${BUILD_NUMBER}




mvn help:evaluate -Dexpression=${PROJECT_VERSION} | grep "^[^\[]"
mvn help:evaluate -Dexpression=${PROJECT_ENV} | grep "^[^\[]"

mvn  clean package -DskipTests -Dproject.version=${PROJECT_VERSION} -Dproject.env=${PROJECT_ENV} -Dbuild.number=${BUILD_NUMBER}

echo 'Install into the local Maven repository'
mvn jar:jar install:install






