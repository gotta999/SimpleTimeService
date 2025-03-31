# SimpleTimeService
Creating Simple Time Service using Python on AWS Ec2 Instance 
>> Launch EC2 instance on AWS
>> I used Ubuntu Free Tier Service and create Key Pair (login pem file).
>> create security Group allowing 22 port (select SSH trafic) Launch Instance
>Now login to EC2 in Command Promt(I used Git Bash) give below command to login to EC2 in local
>> ssh -i your-key.pem ubuntu@your-ec2-public-ip
>> then below two commands to upgrade the packages of the machiene
>> sudo apt update && sudo apt upgrade -y
#Install aws cli on ubuntu macheine
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install
>> check the if AWS installed or not
>> aws --version
>Now give your credentials by entering below command and create access key on IAM dashboard add those values below
>> aws configure
AWS Access Key ID [None]: value
AWS Secret Access Key [None]: value
Default region name [None]: Region name
Default output format [None]: json
#Install docker enter below commands
>> sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
docker --version
sudo usermod -aG docker ubuntu
logout from ubuntu login back : ssh -i your-key.pem ubuntu@your-ec2-public-ip
#install terraform by running below commands
wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
unzip terraform_1.6.6_linux_amd64.zip
sudo mv terraform /usr/local/bin/
>> Now enter git clone https://github.com/gotta999/SimpleTimeService.git
>>git switch -c new-branch-name
>> cd SimpleTimeService/app
>> As the code was already added we just need build docker file before that goto we used 8080 port got ec2 ->security edit inbound rules allow select custom tcp select 8080 port and add 0.0.0.0/0 on source
>> Enter below commands
terraform init
terraform plan
if there are no errors then proceed with below command
>> terraform apply
>> terraform output alb_dns_name
Copy the ALB URL and open it in your browser. You should see the JSON response from your SimpleTimeService.
terraform destroy -auto-approve
