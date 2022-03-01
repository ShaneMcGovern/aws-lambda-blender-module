# AWS Lambda Blender Module

## Description
A Docker image that builds [Blender as a Python module](https://wiki.blender.org/wiki/Building_Blender/Other/BlenderAsPyModule) for use in [AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html).

## What I am doing here
This Git repository and its Dockerfile allow you to access Blender's feature set directly from the app.py application file used in AWS Lambda.

## Usage

### Requirements
To re-create this image, make sure you have the following pre-requisites set up:

* [git](https://git-scm.com/downloads)
* [docker](https://docs.docker.com/get-docker/)

### Building and testing the image

First, clone this repository:
```
git clone https://github.com/ShaneMcGovern/aws-lambda-blender-module.git
```

Build the image:
```
docker build -t aws-lambda-blender-module -f Dockerfile .
```
![Build the image](https://d3i68myn0yglbv.cloudfront.net/aws-lambda-blender-module_1.png)

Run the container image:
```
docker run -d -p 9090:8080 aws-lambda-blender-module
```
![Run the container image](https://d3i68myn0yglbv.cloudfront.net/aws-lambda-blender-module_2.png)

Invoke the Lambda function:
```
Invoke-WebRequest -Method POST -Uri "http://localhost:9090/2015-03-31/functions/function/invocations" -Body '{}'
```
![Invoke the Lambda function](https://d3i68myn0yglbv.cloudfront.net/aws-lambda-blender-module_3.png)

Additional guidance can be found here, [Testing Lambda container images locally](https://docs.aws.amazon.com/lambda/latest/dg/images-test.html).

## Acknowledgements
- JR Beaudoin's bog post [Rendering Blender scenes in the cloud with AWS Lambda](https://blog.theodo.com/2021/08/blender-serverless-lambda/).

## Contact
Created by [@shanemcgovern](https://shanemcgovern.github.io/)

## Licence
This project is licensed under the Apache-2.0 License.
