#!/bin/bash
yum update -y
yum install python36 -y
yum install git -y

[ ! -d /home/ec2-user/venv ] && mkdir /home/ec2-user/venv

/usr/bin/virtualenv -p python3 /home/ec2-user/venv/ec2-user
chown -R ec2-user:ec2-user /home/ec2-user/venv/
source /home/ec2-user/venv/ec2-user/bin/activate

mkdir /home/ec2-user/luigi
cd /home/ec2-user/luigi:
git init
git pull https://github.com/spotify/luigi.git
chown -R ec2-user:ec2-user /home/ec2-user/luigi/

/home/ec2-user/venv/ec2-user/bin/pip install pip --upgrade
/home/ec2-user/venv/ec2-user/bin/pip install luigi

su ec2-user -c "/home/ec2-user/venv/ec2-user/bin/luigid &"
cd /home/ec2-user/luigi/examples
# Set PYTHONPATH and invoke luigi from venv to aggregate Artists
PYTHONPATH='.' /home/ec2-user/venv/ec2-user/bin/luigi --module top_artists AggregateArtists --date-interval 2012-06
PYTHONPATH='.' luigi --module top_artists Top10Artists --date-interval 2012-07
