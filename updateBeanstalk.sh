#! /bin/bash

if [ "$BRANCH" = "amazon-eb-cli-beta" ]; then

  # update the Elastic Beanstalk Dockerrun.aws.json deployment spec and copy files to S3
  cat Dockerrun.aws.json | sed "s/<IMAGE_NAME>/$REGISTRY_ACCOUNT\/$AWS_EB_APPLICATION\/$AWS_EB_ENVIRONMENT/" | sed "s/<TAG>/$BRANCH.$BUILD_NUMBER/" | sed "s/<DOCKER_CONFIG>/$AWS_EB_APPLICATION\/$AWS_EB_ENVIRONMENT\/$AWS_DOCKER_CONFIG.$BRANCH.$BUILD_NUMBER/" > $AWS_DEPLOY_JSON.$BRANCH.$BUILD_NUMBER

  aws s3 cp $AWS_DEPLOY_JSON.$BRANCH.$BUILD_NUMBER s3://$AWS_S3_BUCKET/$AWS_S3_FOLDER/$AWS_DEPLOY_JSON.$BRANCH.$BUILD_NUMBER --region=$AWS_REGION

  aws s3 cp /root/.docker/config.json s3://$AWS_S3_BUCKET/$AWS_S3_FOLDER/$AWS_DOCKER_CONFIG.$BRANCH.$BUILD_NUMBER --region=$AWS_REGION

  # create new Elastic Beanstalk application version
  aws elasticbeanstalk create-application-version --application-name $AWS_EB_APPLICATION --version-label $ACCOUNT_IDENTIFIER.$AWS_EB_ENVIRONMENT.$BRANCH.$BUILD_NUMBER --source-bundle S3Bucket=$AWS_S3_BUCKET,S3Key=$AWS_S3_FOLDER/$AWS_DEPLOY_JSON.$BRANCH.$BUILD_NUMBER --region=$AWS_REGION

  sleep 20s #This sleep is to make sure the image is available in the registry

  # deploy new application version to Elastic Beanstalk
  aws elasticbeanstalk update-environment --environment-name $AWS_EB_ENVIRONMENT --version-label $ACCOUNT_IDENTIFIER.$AWS_EB_ENVIRONMENT.$BRANCH.$BUILD_NUMBER --region=$AWS_REGION
else
  echo "Not on amazon-eb-cli-beta branch - will not update Elastic Beanstalk environment"
fi
