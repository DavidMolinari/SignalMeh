#!/bin/bash
list=("meh", "no comprendo", "meh meh meh meh", "lost meh") 
limit=$(( ( RANDOM % 30 )  + 1 )) 
echo $limit
for i in $(seq 1 $limit); do
	touch temp$i.txt
	git add -A
	a="Mon May "
	b=$i
	c=" 5:00 2018 +0530"
	export GIT_AUTHOR_DATE=$a$b$c
	export GIT_COMMITTER_DATE=$a$b$c
	git commit -am "`echo ${list[$RANDOM % ${#list[@]} ]}`"
	rm temp$i.txt
	export GIT_AUTHOR_DATE=$a$b$c
	export GIT_COMMITTER_DATE=$a$b$c
	export GIT_AUTHOR_NAME="David MOLINARI"
	export GIT_AUTHOR_EMAIL="contact@davidmolinari.fr"
	export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
	export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
	git commit -m "Addes some patches"
	git commit -am "`echo ${list[$RANDOM % ${#list[@]} ]}`"
done