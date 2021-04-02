#!/bin/sh

handle_file() {
	if [ -d "$1" ]; then
		cd "$1"
	elif [ -f "$1" ]; then
		exec xdg-open "$(pwd)/$1" &
		exit 0
	else
		printf "%s is neither a file nor a directory\n" "$(pwd)/$1" >&2
	fi
}

needed=("xdg-open" "dmenu")

for n in "${needed[@]}"; do
	if ! which "$n" &> /dev/null; then
		printf "Please install %s in order to use this script!\n" "$n" >&2
		exit 1
	fi
done

while : ; do
	file="$(ls -1 --group-directories-first | dmenu -l 10 -p "Browse $(basename $(pwd)):")"

	if [ -e "$file" ]; then
		handle_file "$file"
	else
		break
	fi
done
