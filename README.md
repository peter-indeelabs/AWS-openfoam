# openfoam-docker-awsbatch

## Overview
running OpenFoam job on AWS Batch

## Description
by using these scripts and commands, you can run OpenFoam job on AWS Batch.
- building up base infrastructure and Docker build server for AWS Batch by CloudFormation
- after the base infrastructure become ready, build docker image and push it to AWS ECR.
- create job definition, compute environment and job queue for AWS Batch
- submit jobs to AWS Batch
- part of result data will be upload to S3 bucket which is created by CloudFormation

# Usage
1. login to aws console with admin
2. go to EC2
3. create a KeyPair
4. run CloudFormation for AWS Batch base infrastructure
5. login to ubuntu server
6. run ubuntu setup script
7. build Docker images with the Dockerfile
8. push the images to AWS ECR
9. edit json files based on created AWS resources
10. create job definition on AWS Batch
11. create computing environment on AWS Batch
12. create job queue on AWS Batch
13. submit jobs


# Step 1: Create Nextflow

Nextflow streamlines the use of AWS Batch by smoothly integrating it in its workflow processing model and enabling transparent interoperability with other systems.

Use CloudFormation to create the following:
1) The core set of resources (S3 Bucket, IAM Roles, AWS Batch) described in the Getting Started section.
2) A containerized nextflow executable that pulls configuration and workflow definitions from S3
3) The AWS CLI installed in job instances using conda
4) A Batch Job Definition that runs a Nextflow head node
5) An IAM Role for the Nextflow head node job that allows it access to AWS Batch
6) An S3 Bucket to store your Nextflow workflow definitions


# Step 2: Create OpenFOAM Docker Image

This step shows how to create development environment to containizing CFD application
(A development environment is a place in AWS Cloud9 where you store your project's files and where you run the tools to develop your applications.)

## Step 2a: Create AWS Cloud9 Environment

create new environment named "peter-dev-machine"

## Step 2b: Create Docker


Docker is set of tools that make running, building and managing software containers much easier than it otherwise might be.

First user need to connect an AWS Cloud9 SSH development environment to a running Docker container inside of an Amazon Linux instance in Amazon EC2

Use this docker file for packing up openfoam installation
https://github.com/peter-indeelabs/AWS-openfoam/blob/master/Dockerfile

Here are the docker commands:
https://github.com/peter-indeelabs/AWS-openfoam/blob/master/docker%20commands

(Reference: https://github.com/peter-indeelabs/AWS-openfoam/blob/master/aws-scripts.sh)

# Step 3: Creating an ECR repository
The next step is to create an ECR repository to store the Docker image created from previous step, so that it can be retrieved by AWS Batch when running jobs.

Create "nextflow" repository

Now that we have a Docker image and an ECR repository, it is time to push the image to the repository. Use the following AWS CLI commands with Indee account run in cloud9 terminal
1) $(aws ecr get-login --no-include-email --region us-west-2)
2) docker build -t nextflow .
3) docker tag nextflow:latest 933794880782.dkr.ecr.us-west-2.amazonaws.com/nextflow:latest
4) docker push 933794880782.dkr.ecr.us-west-2.amazonaws.com/nextflow:latest


# Step 4: Create AWS Batch

## Step 4a: Create bucket 
To allow files to be uploaded to Amazon S3, it is required to create S3 bucket in West-2 region. Create the following buckets on S3
-indeesfxsync
-indeefdata
-indeednfsworkdir


## Step 4b: Create/Build batch job

AWS Batch is a managed computing service that allows the execution of containerised workloads over the Amazon EC2 Container Service (ECS).

Batch is organised in Compute Environments, Job queues, Job definitions and Jobs.
The Compute Environment allows you to define the computing resources required for a specific workload (type). You can specify the minimum and maximum number of CPUs that can be allocated, the EC2 provisioning model (On-demand or Spot), the AMI to be used and the allowed instance types.
The Job queue definition allows you to bind a specific task to one or more Compute Environments.
Then, the Job definition is a template for one or more jobs in your workload. This is required to specify the Docker image to be used in running a particular task along with other requirements such as the container mount points, the number of CPUs, the amount of memory and the number of retries in case of job failure.
Finally the Job binds a Job definition to a specific Job queue and allows you to specify the actual task command to be executed in the container.
The job input and output data management is delegated to the user. This means that if you only use Batch API/tools you will need to take care to stage the input data from a S3 bucket (or a different source) and upload the results to a persistent storage location.

In the environment variables, please use the following keys and values
1) (KEY) NF_LOGSDIRs3 (VALUE) //indeenfsworkdir/logs
2) (KEY) NF_JOB_QUEUEarn (VALUE) aws:batch:us-west-2:933794880782:job-queue/default-13dd0220-f421-11e9-820f-065424fac776
3) (KEY) NF_WORKDIRs3 (VALUE) //indeenfsworkdir/runs

# Step 5: Create AWS System Session Manager

Session Manager is a fully managed AWS Systems Manager capability that lets you manage your Amazon EC2 instances through an interactive one-click browser-based shell or through the AWS CLI. 

Use this to tail log files from CFD output files.

The following commands are useful:

- Run a new container:
\ndocker run --name test -it ubuntu

- List containers :  
\ndocker ps -a

- Run docker exec on a running container
\ndocker exec -d ubuntu touch /bin/bash

# Step 6:
create virtual machine
(TBD)
