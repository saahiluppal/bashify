## ------- Greetings -------------

COLUMNS=$(tput cols) 

now=$(date +"%H")

if [ $now -ge 16 ]
then
    title="$(tput bold)$(tput setaf 3)GOOD EVENING$(tput sgr 0)"
elif [ $now -ge 12 ]
then 
    title="$(tput bold)$(tput setaf 3)GOOD AFTERNOON$(tput sgr 0)"
else
    title="$(tput bold)$(tput setaf 3)GOOD MORNING$(tput sgr 0)"
fi

## if you want greeting uncooment following 3 lines
#yes "$(tput setaf 6)=$(tput sgr 0)" | head -n$(($(tput cols))) | tr -d '\n'
#printf "%*s\n" $(((${#title}+$COLUMNS)/2+5)) "$title"
#yes "$(tput setaf 6)=$(tput sgr 0)" | head -n$(($(tput cols))) | tr -d '\n'

## -----------------------------

## Custom Aliases --------------

alias push='git push -u origin master'

## -----------------------------

## Custom Functions ------------

weather() {
    curl -s "wttr.in/$1?m1"
}

repo() {
    firefox repo.new &>/dev/null &
    disown
}

## -----------------------------
