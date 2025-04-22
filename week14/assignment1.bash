#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

function displayCourseLoc(){

echo -n "Please input a course location (ex. JOYC, MIC, GBTC, FREE, CCM): "
read courseLoc

echo ""
echo "Courses in $courseLoc :"
cat "$courseFile" | grep "$courseLoc" | cut -d';' -f1,2,5,6,7 | sed 's/;/ | /g'
echo ""

}

function displayCourseAvail(){

echo -n "Please input course subject (ex. SEC, SYS, NET): "
read courseSub

echo ""
echo "Available courses in $courseSub :"
grep "^$courseSub" "$courseFile" | while IFS=";" read -r f1 f2 f3 f4 f5 f6 f7 f8 f9 f10; do
	if [ "$f4" -gt 0 ]; then
		echo "$f1 | $f2 | $f3 | $f4 | $f5 | $f6 | $f7 | $f8 | $f9 | $f10"
	fi
done
echo ""

}
while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses of a classroom"
	echo "[4] Display available courses of subject"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Seeya!"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		displayCourseLoc

	elif [[ "$userInput" == "4" ]]; then
		displayCourseAvail

	else
		echo "You have not entered a valid input. Please try again:"
	fi
done
