#!/bin/bash
## Author: Opstree  ##

export AWS_DEFAULT_REGION=us-east-1
chmod 400 *.pem
echo "Enter EC2 for Changing Instance Type
Enter @Reboot for Rebooting Instance
Enter RDS for RDS settings"
 
PositionalParamExists="$1"
PositionalParamExists1="$1"
PositionalParamExists2="$2"



function check () {
aws rds modify-db-instance --db-instance-identifier devdb --db-instance-class db.t2.large --apply-immediately --region eu-west-1 ;
until [[ $? -eq 0 ]]; do aws rds modify-db-instance --db-instance-identifier devdb --db-instance-class db.t2.large --apply-immediately --region eu-west-1; done
}

function inputparams () {

if [ -z "${PositionalParamExists1}" ] && [ -z "${PositionalParamExists2}" ]; then
  echo "Please pass 2 proper Arguments"
  echo " USAGE: script.sh ARG1 ARG2"

  exit;
fi
}

function inputparams2 () {


if [ -z "${PositionalParamExists}" ]; then
  echo "Please pass 1 proper Argument"
  echo " USAGE: script.sh ARG1"

  exit;
fi
}

if [ "$1" = "EC2" ]; then

echo "ARG1=INSTANCE-ID, ARG2=INSTANCE-TYPE"
inputparams

aws ec2 modify-instance-attribute --instance-id $2 --instance-type "{\"Value\": \"$3\"}"

elif [ "$1" = "@Reboot" ]; then

echo "ARG1=INSTANCE-ID"
inputparams2
aws ec2 reboot-instances --instance-ids $2

elif [ "$1" = "RDS" ]; then
echo "ARG1=DB-INSTANCE-IDENTIFIER ARG2=DB-INSTANCE-CLASS"
inputparams
aws rds modify-db-instance --db-instance-identifier $2 --db-instance-class $3 --apply-immediately --region eu-west-1
sleep 60
check
else 
:
fi
