#!/bin/bash
FILE_PATH=input.txt

for i in `cat $FILE_PATH`
do
	IP=`echo $i | awk -F '|' '{print $1}'`
	USER=`echo $i | awk -F '|' '{print $2}'`
	PWD=`echo $i | awk -F '|' '{print $3}'`

	[ ! -f .ssh/id_rsa.pub ] && printf '\n%.0s' {1..3} | ssh-keygen -t rsa 

	sshpass -p "$PWD" ssh -tt  -o "StrictHostKeyChecking no" $User@$IP mkdir -p .ssh
	cat .ssh/id_rsa.pub | sshpass -p "$PWD"  ssh '$USER'@'$IP' 'cat >> .ssh/authorized_keys'
	sshpass -p "$PWD" ssh '$USER'@'$IP' "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"
done
