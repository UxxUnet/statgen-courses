#!/bin/bash
# This script can be executed as is under `root`, to setup a new Debian 10 VM purchased
# from a cloud server provider. This script is all you need to setup computing environment
# to run course tutorials. If you are using it in a different context (i.e., on a machine
# not a brand new VM with Debian 10 OS) please read comments for each command and decide what to do.
set -e
# setup web server (assuming Debian OS)
## Note: you can skip this step if 1) you already have some webserver running, or 2) you don't need to run the tutorial via Jupyter Hub
apt-get update && apt-get install -y nginx
# install setfacl command (assuming Debian OS)
apt-get install acl
## Note: you can skip this step if 1) you already have setfacl command tool installed or 2) you don't need to run the tutorial via Jupyter Hub
# setup docker
## Note: you can skip this step if you've already got docker installed
curl -fsSL get.docker.com -o /tmp/get-docker.sh && sh /tmp/get-docker.sh
# setup SoS to run utility scripts
## Note: this step will install miniconda3. You can skip this step if you have got miniconda3 installed and `conda` command available
curl -fsSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh && bash /tmp/miniconda.sh -bfp /usr/local
## Note: this step installs sos package for running script statgen-setup
conda install -y -c conda-forge sos
# utility script for running tutorials
curl -fsSL https://raw.githubusercontent.com/statgenetics/statgen-courses/master/src/statgen-setup -o statgen-setup && chmod +x statgen-setup && mv statgen-setup /usr/local/bin/
# add users
## Note: this command will create users from student_1 to student_12, and print out the password to the screen
## You can skip it if you already have created user accounts
## But you need to make sure users can run `statgen-setup` script from their terminal
statgen-setup useradd --my-name student --num-users 12 2> useradd.log
# pull latest verson of docker images
statgen-setup update --tutorial vat pseq igv popgen regression annovar mlink slink gemini
# setup gemini data
## This will download large data-set; please comment it out if you do not need it for the tutorial
## By default we don't need this step for our current version of gemini tutorial.
## statgen-setup annotation_db --gemini-data-dir /root/annotation_db && chown root.users -R /root/annotation_db