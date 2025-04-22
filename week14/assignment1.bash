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
while read -r line; do 
	seats=$(echo "$line" | cut -d ';' -f4)
		if [ "$seats" -gt 0 ]; then
			echo "$line"
		fi
	done < <(grep "$courseSub" "$courseFile" | sed 's/;/ | /g')
echo ""

}
# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas

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
