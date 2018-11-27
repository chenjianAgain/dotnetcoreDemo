#!/bin/bash
#CI
dotnet publish -o site 
echo "----Dotnet publish successfully..."
cd site 
zip ../site.zip * 
cd .. 
zip dotnet-core-tutorial.zip site.zip aws-windows-deployment-manifest.json
echo "----Zip successfully..."
aws s3 cp dotnet-core-tutorial.zip s3://dotnet-deploy/dotnet-core-tutorial.zip
echo "----Upload to s3 successfully..."
#CD
if [ -z "$1" ]
then 
    LABEL=`date "+%Y-%m-%d %H:%M:%S"`
    DESC="version is by default" 
else
    LABEL=$1
    DESC=$1
fi
aws elasticbeanstalk create-application-version --application-name DatingApp  --version-label "$LABEL"   --description "$DESC" --source-bundle S3Bucket="dotnet-deploy",S3Key="dotnet-core-tutorial.zip"     --auto-create-application
echo "----Create new version successfully..."
aws elasticbeanstalk update-environment --environment-name Datingapp-env --version-label "$LABEL"
echo "----Point to new version successfully..."
