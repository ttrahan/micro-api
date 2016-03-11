#! /bin/bash

if [ "$BRANCH" = "master" ]; then

  # create new Elastic Beanstalk application version
  aws elasticbeanstalk create-application-version --application-name $AWS_EB_APPLICATION --version-label $ACCOUNT_IDENTIFIER.$AWS_EB_ENVIRONMENT.$BRANCH.$BUILD_NUMBER --source-bundle S3Bucket=$AWS_S3_BUCKET,S3Key=$AWS_S3_FOLDER/$AWS_DEPLOY_JSON.$BRANCH.$BUILD_NUMBER --region=$AWS_REGION

  sleep 20s #This sleep is to make sure the image is available in the registry

  # deploy new application version to Elastic Beanstalk
  aws elasticbeanstalk update-environment --environment-name $AWS_EB_ENVIRONMENT --version-label $ACCOUNT_IDENTIFIER.$AWS_EB_ENVIRONMENT.$BRANCH.$BUILD_NUMBER --region=$AWS_REGION
else
  echo "Not on master branch - will not update Elastic Beanstalk environment"
fi
