# Step 1: Create High Performance Parallel File System FSx 

This option is better than NFS share for HPC workload application

Amazon FSx for Lustre is a highly parallel file system that supports sub-millisecond access to petabyte-scale file systems, designed to deliver 200 MB/s of aggregate throughput at 10,000 IOPS for every 1TiB of provisioned capacity.

Follow the below instruction for set-up

## Step 1a: Install and attach Lustre file system

https://docs.aws.amazon.com/fsx/latest/LustreGuide/install-lustre-client.html

## Step 1b: Open a terminal

(You must have an Amazon EC2 key pair to connect to the nodes in your cluster over a
secure channel using the Secure Shell (SSH) protocol. If you already have a key pair
that you want to use, you can skip this step. If you don't have a key pair, follow these
steps to create a key pair https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair)


Create a new directory on your EC2 instance, for example /fsx

-sudo mkdir /fsx

-sudo mount -t lustre -o noatime,flock fs-03f7dae7c222360f2.fsx.us-west-2.amazonaws.com@tcp:/fsx /fsx



# Step 2: Create OpenFOAM Docker Image

This step shows how to create development environment to containizing CFD application
(A development environment is a place in AWS Cloud9 where you store your project's files and where you run the tools to develop your applications.)

## Step 1a: Create AWS Cloud9 Environment

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
1) In the AWS Batch console, choose Job Definitions, Create.
2) For the Job Definition, enter a name, for example, nextflow.
3) For IAM Role, choose the following role
arn:aws:iam::933794880782:role/NF0-NextflowStack-5412Z8DX5J17-IAMNextflowJobRole-SS7WMCJ1E02Z.
4) For ECR Repository URI, enter the URI where the docker image was pushed
933794880782.dkr.ecr.us-west-2.amazonaws.com/nextflow:latest
5) Leave the Command field blank.
For vCPUs, enter 2. For Memory, enter 1024MB.

In the environment variables, please use the following keys and values
1) (KEY) NF_LOGSDIRs3 (VALUE) //indeenfsworkdir/logs
2) (KEY) NF_JOB_QUEUEarn (VALUE) aws:batch:us-west-2:933794880782:job-queue/default-13dd0220-f421-11e9-820f-065424fac776
3) (KEY) NF_WORKDIRs3 (VALUE) //indeenfsworkdir/runs

# Step 5: Create instance (EC2)

https://ec2instances.info/?region=us-west-2
use c5.24xlarge (96CPU, 192GB memory, 25G Network Performance)


# Step 6:
create virtual machine
(TBD)
