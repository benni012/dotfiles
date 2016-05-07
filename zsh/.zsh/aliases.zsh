alias :q="exit"
alias alsi="alsi -l"
alias ayy="fortune | cowsay -n | lolcat"
alias bc="bc -ql"
alias bs="base"
alias dvtm="dvtm -m ^a"
alias eject="eject -T"
alias f="toilet -f "
alias fetch="neofetch"
alias gitr="find -maxdepth 1 -type d | xargs -I % mksh -c '{ if [ -d \"%/.git\" ]; then echo -n \"%: \"; cd \"%\"; git pull; echo; cd ->/dev/null; fi }'"
alias l="ls --color=auto --group-directories-first -1"
alias la="ls -lah --color=auto --group-directories-first"
alias ll="ls -lh --color=auto --group-directories-first"
alias lrn='learn'
alias ls="ls --color=auto --group-directories-first"
alias matrix="cmatrix -b"
alias mixer="alsamixer"
alias pacman="sudo pacman"
alias play_bd="mpv -vo vdpau -vd-lavc-threads 8 br:////mnt/cd"
alias rm="rm -I"
alias rnb="toilet --gay -f"
alias rock="ncmpcpp"
alias sau="pacaur -Sayu"
alias startx="startx ~/.xinitrc"
alias syu="pacaur -Sryu"
alias syyu="pacaur -Sryyu"
alias tree='tree -CAFa -I "CVS|*.*.package|.svn|.git|.hg|node_modules|bower_components" --dirsfirst'
alias up="uguush -o mixtape -u "
alias update="pacaur -Syu"
alias v="vim"
alias vim="nvim"
alias wee="weechat"

function rf {
	find $@ -type f | shuf -n1
}

function pre {
	dir=$SERIES_DIR
	case $1 in
		ad) dir="$dir/American_Dad";;
		fg) dir="$dir/Family_Guy";;
		cb) dir="$dir/Cowboy_Bebop";;
	esac

	mpv "$(rf $dir)"
}

function lsc {
	i=${1:-1}
	find $SCROT_DIR | tail -$i
}

function upl {
	lsc $@ | xargs -I % uguush -o mixtape -u %
}

function learn {
	mpv /data/vid/Statistics/$1.* &>/dev/null &!
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
	filme | altcolor
}

function bdi {
	sudo mount /dev/sr0 /mnt/cd;
	play_bd "$@";
	sudo umount /mnt/cd;
}

function d {
	dtach -A /tmp/dtach_${1:-0} ${2:-$SHELL}
}
