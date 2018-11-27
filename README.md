# dotnetcoreDemo

dotnet publish -o site
cd site
zip ../site.zip *
cd ..
zip dotnet-core-tutorial.zip site.zip aws-windows-deployment-manifest.json


aws elasticbeanstalk create-application-version --application-name DatingApp \
--version-label v5 \
--description "DatingApp deploy from cli" \
--source-bundle S3Bucket="dotnet-deploy",S3Key="dotnet-core-tutorial.zip" \
--auto-create-application

aws elasticbeanstalk update-environment --environment-name Datingapp-env --version-label v5
