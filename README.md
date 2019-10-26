# Step 1: Create high performance parallel file system FSx 

This option is better than NFS share for HPC workload application

Amazon FSx for Lustre is a highly parallel file system that supports sub-millisecond access to petabyte-scale file systems, designed to deliver 200 MB/s of aggregate throughput at 10,000 IOPS for every 1TiB of provisioned capacity.

Follow the below instruction to install and attach Lustre file system
Step 1a: https://docs.aws.amazon.com/fsx/latest/LustreGuide/install-lustre-client.html

Step 1b: 
Open a terminal

(You must have an Amazon EC2 key pair to connect to the nodes in your cluster over a
secure channel using the Secure Shell (SSH) protocol. If you already have a key pair
that you want to use, you can skip this step. If you don't have a key pair, follow these
steps to create a key pair https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair)


Create a new directory on your EC2 instance, for example /fsx
sudo mkdir /fsx
sudo mount -t lustre -o noatime,flock fs-03f7dae7c222360f2.fsx.us-west-2.amazonaws.com@tcp:/fsx /fsx



# Step 2: Create Docker
create development environment to containizing CFD application
Definition: A development environment is a place in AWS Cloud9 where you store your project's files and where you run the tools to develop your applications.

Docker is set of tools that make running, building and managing software containers much easier than it otherwise might be.

First user need to connect an AWS Cloud9 SSH development environment to a running Docker container inside of an Amazon Linux instance in Amazon EC2

Use this docker file for packing up openfoam installation
https://github.com/peter-indeelabs/AWS-openfoam/blob/master/Dockerfile

Here are the docker commands:
https://github.com/peter-indeelabs/AWS-openfoam/blob/master/docker%20commands

(Reference: https://github.com/peter-indeelabs/AWS-openfoam/blob/master/aws-scripts.sh)

# Step 3: Create AWS Batch

Create bucket 
To allow files to be uploaded to Amazon S3, it is required to create S3 bucket in West-2 region. Create the following buckets on S3
-indeesfxsync
-indeefdata
-indeednfsworkdir

# Step 4: Create instance (EC2)

https://ec2instances.info/?region=us-west-2
use c5.24xlarge (96CPU, 192GB memory, 25G Network Performance)


# Step 5:
create virtual machine
(TBD)
