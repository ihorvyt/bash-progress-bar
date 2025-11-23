#!/usr/bin/env bash


bar_char='|'

while getopts "c:" opt; do
	case "$opt" in
		c)
			bar_char="$OPTARG"
			;;
		*)
			echo "Usage: $0 [-c character]"
			exit 1
			;;
	esac
done

progress-bar() {
	local current=$1
	local len=$2
	local percent_done=$((current * 100 / len))

	local length=70
	local i=0
	local num_bars=$((percent_done * length / 100))

	local s='['
	for ((i = 0; i < num_bars; i++)); do
		s+="$bar_char"
	done

	for ((i = num_bars; i < length; i++)) do
		s+=' '
	done
	s+=']'

	echo -ne "$s\r"
}

shopt -s globstar nullglob

process-something() {
	sleep .01
}

len=500
i=0
for l in $(seq 1 $len); do
	progress-bar "$((i + 1))" "$len"
	process-something
	((i++))
done

echo
