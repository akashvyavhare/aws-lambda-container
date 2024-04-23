# aws-lambda-container

This repo contains code for aws lambda. 

This lambda function will execute excute a shell script 

It require dependency like aws cli, java 11, kafka 

we have put all require dependency manualy inside container .ie  i have install java , aws cli, kafka inside a specific folder

after installation i have added that folder to lambda  container and export that folder path while createing docker image

path export is usefull to access java or aws cli from any directory. other wise we have to always give path of java installation diarectory while running java or aws cli cmmonds
