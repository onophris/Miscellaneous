#A support function used to append export commands to .bashrc, .zshrc, etc.
#Author: Toberumono (https://github.com/Toberumono)

update_rc() {
	client="$1"
	shift
	file_path="$1"
	shift

	should_reopen=""
	added=false

	for p in "$@"; do
		add_path=$(grep -F -e 'export '$p "$file_path")
		if [ "$add_path" != "" ]; then
			echo 'export '$p" is already in $file_path."
			continue;
		fi
		if ( ! $added ); then
			echo "" >> "$file_path"
			echo "# This adds the necessary $client paths." >> "$file_path"
			[ "$should_reopen" == "" ] && should_reopen="$file_path" || should_reopen=$should_reopen" $file_path"
			added=true
		fi
		echo "Adding export $p to $file_path."; echo 'export '$p >> "$file_path"
	done
}