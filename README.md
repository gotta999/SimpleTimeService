# SimpleTimeService
Creating Simple Time Service using Python on AWS Ec2 Instance 
>> Launch EC2 instance on AWS
>> I used Ubuntu Free Tier Service and create Key Pair (login pem file).
>> create security Group allowing 22 port (select SSH trafic) Launch Instance
>Now login to EC2 in Command Promt(I used Git Bash) give below command to login to EC2 in local
>> ssh -i your-key.pem ubuntu@your-ec2-public-ip
>> then below two commands to upgrade the packages of the machiene
>> sudo apt update && sudo apt upgrade -y
>> now install aws cli on ubuntu macheine
>Run below commands
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
>> check the version
>> aws --version
>Now give your credentials by entering below command and create access key on IAM dashboard add those values below
>> aws configure
AWS Access Key ID [None]: value
AWS Secret Access Key [None]: value
Default region name [None]: Region name
Default output format [None]: json
>> Now git clone 

