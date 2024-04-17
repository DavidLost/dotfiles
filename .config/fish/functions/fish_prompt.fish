function fish_prompt
	set_color white -o
	printf "["
	set_color green
	printf "$USER"
	set_color cyan
	printf "@"
	set_color blue
	printf "$hostname"
	set_color magenta
	printf ": "
	set_color red
	printf (string replace "/home/$USER" "~" $PWD)
	set_color white -o
	printf "] "
	set_color normal
end
