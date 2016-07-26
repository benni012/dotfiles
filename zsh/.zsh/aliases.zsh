alias ....="cd ../../.."
alias ...="cd ../.."
alias ..="cd .."
alias :q="exit"
alias ayy="fortune | cowsay -n | lolcat"
alias bc="bc -ql"
alias bs="base"
alias eject="eject -T"
alias fetch="neofetch"
alias gitr="find -maxdepth 1 -type d | xargs -I % mksh -c '{ if [ -d \"%/.git\" ]; then echo -n \"%: \"; cd \"%\"; git pull; echo; cd ->/dev/null; fi }'"
alias l="ls --color=auto --group-directories-first -1"
alias la="ls -lah --color=auto --group-directories-first"
alias ll="ls -lh --color=auto --group-directories-first"
alias ls="ls --color=auto --group-directories-first"
alias pacman="pacaur"
alias play_bd="mpv -vo vdpau -vd-lavc-threads 8 br:////mnt/cd"
alias plen="mpc playlist --format '%time%' | awk -F ':' '{ m+=\$1; s+=\$2; } END { res=(m*60+s); printf(\"%02d:%02d:%02d\", int(res/60/60), int(res/60)%60, res%60); }'"
alias qalc="qalc -e"
alias rm="rm -I"
alias rock="ncmpcpp"
alias sdown="youtube-dl -x --add-metadata --audio-format mp3 -o '%(title)s.%(ext)s'"
alias startx="startx ~/.xinitrc"
alias tree='tree -F --dirsfirst'
alias up="uguush -o mixtape -u "
alias update="pacaur -Syu"
alias v="vim"
alias vim="nvim"
alias vpn="cd ~/vpn && sudo openvpn"
alias wee="weechat"
alias ytdl="youtube-dl --add-metadata --recode-video mp4 -o '%(title)s.%(ext)s'"

function rf {
	find $@ -type f | shuf -n1
}

function pre {
	dir=$SERIES_DIR
	case $1 in
		ad) dir="$dir/American_Dad";;
		fg) dir="$dir/Family_Guy";;
		cb) dir="$dir/Cowboy_Bebop";;
		rm) dir="$dir/Rick_and_Morty";;
	esac

	mpv "$(rf $dir)"
}

function lsf {
	i=${2:-1}

	case $1 in
		scrot) dir="$SCROT_DIR";;
		rec) dir="$REC_DIR";;
	esac
	
	find "$dir" | tail -$i
}

function upl {
	lsc $@ | xargs -I % uguush -o mixtape -u %
}

function lsfilme {
	ls -1 /data/mov
}

function lfilme {
	find /data/mov -type f \( -iname "*.mkv" -o -iname "*.mp4" -o -iname "*.avi" \) -print0 \
	| xargs -0 -i% sh -c '{ echo $(basename "%" | cut -c -60;)" "$(vidlen "%"); }' \
	| sort \
	| column -t
}

function filme {
	lfilme | altcolor
}

function bdi {
	sudo mount /dev/sr0 /mnt/cd;
	play_bd "$@";
	sudo umount /mnt/cd;
}
