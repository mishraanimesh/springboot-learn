#!/usr/bin/env bash
#
# Animesh <animesh.mishra@payu.in>
# Pass Variable a aws repor using URL
# $$$$$$$$.dkr.ecr.ap-south-1.amazonaws.com/$aws_repository
#

set -e
set -x


# Check that environment variables are set from Jenkins
if [ -z "$aws_repository" ]; then
    echo "*** No AWS ECR respository supplied in ENV aws_repository, exiting... ****"
    exit 1
fi

if [ -z "$aws_profile" ]; then
    echo "No AWS profile supplied using default"
    aws_profile=default
fi


if [ "$#" -eq 2 ]; then
    AWS_SHARED_CREDENTIALS_FILE=$2
    export AWS_SHARED_CREDENTIALS_FILE
fi

#  Set up paths
AWS="/usr/bin/aws --profile $aws_profile"

DOCKER_IMAGE=$1

# Step 1 Get login  snippet from AWS
DOCKER_LOGIN=$($AWS ecr get-login)
# Disable output as we have passwords here
set +x

# Step 2 Execute docker login against AWS.
eval $DOCKER_LOGIN

docker build -t $DOCKER_IMAGE:$JOB_NAME.$BUILD_NUMBER --build-arg project_jar=$DOCKER_IMAGE  version=$JOB_NAME.$BUILD_NUMBER .
# Step 3 Tag image with AWS Specifics
docker tag $DOCKER_IMAGE $aws_repository/$DOCKER_IMAGE:$JOB_NAME.$BUILD_NUMBER

# Tag with Maven build release so we can track it
docker tag $DOCKER_IMAGE $aws_repository/$DOCKER_IMAGE:$JOB_NAME.$BUILD_NUMBER

# Step 4 Push docker image to ECR
docker push  $aws_repository/$DOCKER_IMAGE:$JOB_NAME.$BUILD_NUMBER


