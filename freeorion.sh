#!/bin/bash
while IFS= read line
do
if [[ $line =~ ^#.*	]] ; then
	echo $line
elif [[ $line =~ ^[A-Z].* ]] ; then
	read twice
	if [[	$twice =~ ^\'\'\'.*.\'\'\' ]] ; then
		twice=`echo "$twice" | tr -d "'"`
		transted=`trans en:ja -b -e bing "$twice" `
		echo $line
		echo "'''"$transted"'''"
	elif [[	$twice =~ .*\'\'\'.* ]] ; then
		if [[	$twice =~ .*\[.* ]] ; then
			echo $line
			echo $twice
		else
			twice=`echo "$twice" | tr -d "'"`
			twice=`trans en:ja -b -e bing "$twice" `
			echo $line
			echo "'''"$twice
		fi
		while true
		do
		read third
		if [[ $third =~ .*\'\'\'.* ]] ; then
			if [[ $third =~ .*\[.* ]] ; then
				echo $third
				break
			else
				third=`echo "$third" | tr -d "'"`
				third=`trans en:ja -b -e bing "$third" `
				echo $third"'''"
				break
			fi
		fi
		if [[ $third =~ .*\[.* ]] ; then
			echo $third
		else
			third=`trans en:ja -b -e bing "$third" `
			echo $third
		fi
		done
	elif [[	$twice =~ .*\[.* ]] ; then
		echo ""
		echo ""
	elif [[	$twice =~ .*\{.* ]] ; then
		echo ""
	 	echo ""
	elif [[ $twice =~ ^[A-z].* ]] ; then
		transted=`trans en:ja -b -e bing "$twice" `
		read transted < <(echo $transted | tr -d '\n' )
		echo $line
		echo $transted
		sleep 1
	else 
		echo $line
		echo $twice
	fi
else
	echo $line
fi	
done <./no.txt