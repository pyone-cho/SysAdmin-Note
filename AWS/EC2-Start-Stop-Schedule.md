EC2-Start-Stop Policy

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:StartInstances",
                "ec2:StopInstances"
            ],
            "Resource": "arn:aws:ec2:us-east-2:044058276542:instance/i-0df21b259a7b694ae"
        }
    ]
}

Lambda function

EC2-stop function

import boto3
region = 'us-east-2'
instances = ['i-0df21b259a7b694ae']
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.stop_instances(InstanceIds=instances)
    print('stopped your instances: ' + str(instances))
    
EC2-start function

import boto3
region = 'us-east-2'
instances = ['i-0df21b259a7b694ae']
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.start_instances(InstanceIds=instances)
    print('stopped your instances: ' + str(instances))
