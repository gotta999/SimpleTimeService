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
>> Now install docker enter below commands
>> sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
docker --version
sudo usermod -aG docker ubuntu
logout from ubuntu login back : ssh -i your-key.pem ubuntu@your-ec2-public-ip
>> Now enter git clone https://github.com/gotta999/SimpleTimeService.git
>> cd SimpleTimeService/app
>> As the code was already added we just need build docker file before that goto we used 8080 port got ec2 ->security edit inbound rules allow select custom tcp select 8080 port and add 0.0.0.0/0 on source
>> Enter below commands
docker build -t simpletimeservice .
docker run -d -p 8080:8080 simpletimeservice
69255d985f2f5b595e712bf15b4d8cbdaaccd47ad5e00e360368e1e5febb81aa
>> curl http://localhost:8080/
{"timestamp": "2025-03-30T05:45:01.829068", "ip": "172.17.0.1"}
>> our app succefully running now :)
>> goto chrome just enter http://ec2-ip-address:8080/
>> Will show below page
>> ![Uploading Screenshot 2025-03-30 112205.png…]()
>> Now you can push image to dockerhub
>> docker login
>> enter theis url on browser  give the code that was showing on CMD https://login.docker.com/activate
>> you will see this message :
>> Login Succeeded
>> now enter below comand to tage you docker image
>>  docker tag simpletimeservice your-dockerhub-username/simpletimeservice:latest
>> now enter this command to push your image to docker hub
>>  docker push your-dockerhub-username/simpletimeservice:latest
>> once its pushed it will be avaible on docker hub. use it for next time


