#!/bin/bash



dir=$1
dir2=$2
dir0=$1_$action
action=$1$time


#create backup using cp command
mkdir $2

sudo cp -r $1 $dir0

sudo tar -czf $dir0

sudo mv dir0 $2/$action



#timestamp=$(date '+%Y_%m_%d_%H-%M-%S')
#source_directory=$1
#destination_directory=$2
#backup_directory=$destination_directory$timestamp.tar.gz 

echo $1 $2 $dir0



#source-2024_03_05_19
#echo $backup_directory

#sudo tar -czf $backup_directory  $source_directory

#echo $backup_directory

#echo $backup_directory

#mkdir $2
#sudo cp -r $source_directory $destination_directory
#sudo rename $destination_directory $new_destination_directory$timestamp

#echo $timestamp
