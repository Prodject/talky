#!/bin/bash

echo "Hello, Can we start talky-send? Y/N"

read WANNA_OPEN_CHAT

if [[ $WANNA_OPEN_CHAT != "Y" ]]; then
	printf "\e[31m See You Later ~_~ "
	printf "\033\e[0m"
	exit;
fi

echo "Please provide the token:"
read TOKEN

echo 'Please provide the commands: e.g: pwd;echo "hi"; echo "done";OK'
read COMMANDS

responseToGetToken=$(curl --silent -X POST "https://api.keyvalue.xyz/$TOKEN/chatKey/$COMMANDS")

echo "Commands have been sent for execution \n"
