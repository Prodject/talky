#!/bin/bash

echo "Hello, Can we start talky-receive? Y/N"

read WANNA_OPEN_CHAT

if [[ $WANNA_OPEN_CHAT != "Y" ]]; then
	printf "\e[31m See You Later ~_~ "
	printf "\033\e[0m"
	exit;
fi


printf "\e[32m Hold a moment, we're getting you a sharable token, so you can share it with him/her \n"
printf "\033\e[0m"


#Generate token
responseToGetToken=$(curl --silent -X POST https://api.keyvalue.xyz/new/chatKey)

URL_TO_POLL_BY=$responseToGetToken

#replace forward slashes by one space
URL_TO_POLL_BY_AS_SPACED_STRING=${URL_TO_POLL_BY//\//' '}

responseArr=($(echo "$URL_TO_POLL_BY_AS_SPACED_STRING" | tr '' '\n'))

#extract the token
TOKEN_TO_BE_SHARED=${responseArr[2]}

#check if the token is empty or not
if [ -z "${TOKEN_TO_BE_SHARED}" ]; then
    printf "\e[31m Something wrong happened, we can't get you a token ~_~ , run the script again"
	printf "\033\e[0m"
	exit;
fi

printf "\e[32m Please share this token '$TOKEN_TO_BE_SHARED' with your colleague \n"
printf "\033\e[0m"


#URL_TO_POLL_BY, TOKEN_TO_BE_SHARED
while true
do
	responseToGetByToken=$(curl --silent -X GET "https://api.keyvalue.xyz/$TOKEN_TO_BE_SHARED/chatKey")

	if [[ $responseToGetByToken = *"OK"* ]]; then

 		IFS=';' commandArr=(${responseToGetByToken});

		for ((i=0; i<${#commandArr[*]}; i++));
			do
		
				if [[ ${commandArr[i]} == "OK" ]]; then
					continue
				fi
				
				#todo: check the commands which is in the black list

    			eval ${commandArr[i]}
		done	
		
		printf "\e[32m =============================== \n"
		printf "\e[32m All Commands have been executed \n"
		printf "\e[32m =============================== \n"
		printf "\033\e[0m"

		exit;
	else
		printf "\e[31m the other side did not finish his commands with OK, so please allow him/her sometime \n"
		printf "\033\e[0m"
	fi

	sleep 2
done



