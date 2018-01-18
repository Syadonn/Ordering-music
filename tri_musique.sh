#!/bin/bash
#Order your musique :
#List of all tracks with number
#Folder with the album anme & date of release
#Folder with the artist name
chdone=4
while [[ $chdone -ne true ]]; do
	    read -p "Do you have the configuration file ?" yn
    case $yn in
        [Yy]* ) 

		chdone=true
		clear
		echo "Here we go !"

		artist=$(cat conf | head -n 1 | cut -c 14-)
		album=$(cat conf | head -n 2 | tail -n 1 | cut -c 13-)
		datex=$(cat conf | head -n 3 | tail -n 1 | cut -c 18-)
		formatx=$(cat conf | head -n 4 | tail -n 1 | cut -c 9-)

		echo "Here we go !"

		nb=$(find . -name "*.$format" | wc -l)
		nb=$(($nb+5))
		find . -name "*.$formatx" | cut -c 3- > temp
		mkdir "$album ($datex)"

		echo "Here we go !"

		while [[ $nb -ge 5 ]] 	#While we haven't scan every file/dir
		do
			namefile=$(cat temp | head -n $nb| tail -n 1) 	#We get the file's name
			newname=$(cat conf | head -n $nb| tail -n 1 | cut -c 11-)	#We get the new file's name
			number=$(cat conf | head -n $nb| tail -n 1 | cut -c 7-8)	#We get the file's number

			mv "$namefile" "$album ($datex)"/"$number - $newname.$formatx"
			nb=$(($nb-1))
		done

		mkdir $artist
		mv "$album ($datex)"/$artist

		break;;

        [Nn]* ) chdone=true && ./create_conf.sh;;
        * ) echo "Please answer yes or no.";;
    esac
done
