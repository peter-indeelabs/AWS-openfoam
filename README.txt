Step 1:
Create instance (EC2)

https://ec2instances.info/?region=us-west-2
use c5.24xlarge (96CPU, 192GB memory, 25G Network Performance)

Step 2:
create development environment to containizing CFD application
Definition: A development environment is a place in AWS Cloud9 where you store your project's files and where you run the tools to develop your applications.

please use this script
https://github.com/peter-indeelabs/AWS-openfoam/blob/master/aws-scripts.sh


Step 3:
Create FSX and Attach Lustre file system

Step 3a: https://docs.aws.amazon.com/fsx/latest/LustreGuide/install-lustre-client.html

Step 3b: 
Open a terminal

(You must have an Amazon EC2 key pair to connect to the nodes in your cluster over a
secure channel using the Secure Shell (SSH) protocol. If you already have a key pair
that you want to use, you can skip this step. If you don't have a key pair, follow these
steps to create a key pair https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair)


Create a new directory on your EC2 instance, for example /fsx
sudo mkdir /fsx
sudo mount -t lustre -o noatime,flock fs-03f7dae7c222360f2.fsx.us-west-2.amazonaws.com@tcp:/fsx /fsx




Step 5:
create virtual machine
(TBD)
