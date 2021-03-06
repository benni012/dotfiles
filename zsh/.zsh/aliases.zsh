alias ....="cd ../../.."
alias swipl="swipl -q"
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
alias play_bd="mpv -vo vdpau -vd-lavc-threads 8 br:////mnt/cd"
alias qalc="qalc -e"
alias pacman="sudo pacman"
alias rm="rm -I"
alias rock="ncmpcpp"
alias sdown="youtube-dl -x --add-metadata --audio-format mp3 -o '%(title)s.%(ext)s'"
alias startx="startx ~/.xinitrc"
alias tree='tree -F --dirsfirst'
alias up="uguush -o mixtape -u "
alias update="pacman -Syu"
alias v="vim"
alias vim="nvim"
alias vpn="wg-quick"
alias wee="weechat"
alias ytdl="youtube-dl --add-metadata --recode-video mp4 -o '%(title)s.%(ext)s'"
alias sum_time="awk -F ':' '{ m+=\$1; s+=\$2; } END { res=(m*60+s); printf(\"%02d:%02d:%02d\", int(res/60/60), int(res/60)%60, res%60); }'"
alias gdb="gdb -q"
alias clisp="clisp -q"
alias hs="history 0 | grep -i"

#alias plen="mpc playlist --format '%time%' | awk -F ':' '{ m+=\$1; s+=\$2; } END { res=(m*60+s); printf(\"%02d:%02d:%02d\", int(res/60/60), int(res/60)%60, res%60); }'"

function rf {
	find $@ -type f | shuf -n1
}

function fach {
	cd ~/doc/studium/uebungen_etc/?."$1"
	l
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

function lst {
	i=${2:-1}

	case $1 in
		scrot) dir="$SCROT_DIR";;
		rec) dir="$REC_DIR";;
	esac
	
	file=$(ls -tr $dir | tail -$i)
	echo -n "$SCROT_DIR/$file"
}

function upl {
	lst ${1:-scrot} | xargs -I % uguush -o mixtape -u %
}

function lsfilme {
	ls -1 "$MOV_DIR"
}

function lfilme {
	find "$MOV_DIR" -type f \( -iname "*.mkv" -o -iname "*.mp4" -o -iname "*.avi" \) -print0 \
	| xargs -0 -i% sh -c '{ echo $(basename "%" | cut -c -60;)" "$(vidlen "%"); }' \
	| sort \
	| column -t
}

function uloc {
	sort -u $@ | wc -l
}

function ulocstat {
	sort $@ | sed 's/^[ \t]*//;s/[ \t]*$//' | sort | uniq -c | sort -k 1,1 -g
}

function filme {
	lfilme | altcolor
}

function bdi {
	sudo mount /dev/sr0 /mnt/cd;
	play_bd "$@";
	sudo umount /mnt/cd;
}

function rlen {
	plen $(mpc status | sed -n 2p | awk '{ print $2; }' | awk -F / '{ print $1; }' | cut -c 2-)
}

function plen {
	n=${1:-1}
	mpc playlist --format '%time%' | tail -n +$n | sum_time
}

function sum_time {
	awk -F ':' '{ m+=$1; s+=$2; } END { res=(m*60+s); printf("%02d:%02d:%02d", int(res/60/60), int(res/60)%60, res%60); }'
}

# function man {
#     LESS_TERMCAP_mb=$'\e[1;31m' \
#     LESS_TERMCAP_md=$'\e[1;31m' \
#     LESS_TERMCAP_me=$'\e[0m' \
#     LESS_TERMCAP_se=$'\e[0m' \
#     LESS_TERMCAP_so=$'\e[1;44;33m' \
#     LESS_TERMCAP_ue=$'\e[0m' \
#     LESS_TERMCAP_us=$'\e[1;32m' \
#     command man "$@"
# }

# function man {
# 	printf ":Man $1 $2\n:bdel 1\n" | vim
# }
