function gameid() {
  grep -i -n "$@" ~/.local/share/Steam/steamapps/*.acf | head -1 | sed -e 's/^.*_//;s/\.acf:.:/ /;s/name//;s/"//g;s/\t//g;s/ /-/' | awk -F"-" '{printf "%s\n",$1}' | grep -o '[0-9]*' | nvim -c %y -c q! ;
 grep -i -n "$@" ~/.local/share/Steam/steamapps/*.acf | head -1 | sed -e 's/^.*_//;s/\.acf:.:/ /;s/name//;s/"//g;s/\t//g;s/ /-/' | awk -F"-" '{printf "\n%-40s %s\n", $2, $1}' | sort ;
}

function pt () {
  grep -i -n "$@" ~/.local/share/Steam/steamapps/*.acf | head -1 | sed -e 's/^.*_//;s/\.acf:.:/ /;s/name//;s/"//g;s/\t//g;s/ /-/' | awk -F"-" '{printf "\n%-40s %s\n", $2, $1}' | sort ;
  cd ~/.local/share/Steam/steamapps/compatdata
  cd `grep -i -n "$@" ~/.local/share/Steam/steamapps/*.acf | head -1 | sed -e 's/^.*_//;s/\.acf:.:/ /;s/name//;s/"//g;s/\t//g;s/ /-/' | awk -F"-" '{printf "%s\n",$1}' | grep -o '[0-9]*'`;
  cd pfx/;
  WINEPREFIX=$PWD winetricks;
}

function goto-pfx () {
  grep -i -n "$@" ~/.local/share/Steam/steamapps/*.acf | head -1 | sed -e 's/^.*_//;s/\.acf:.:/ /;s/name//;s/"//g;s/\t//g;s/ /-/' | awk -F"-" '{printf "\n%-40s %s\n", $2, $1}' | sort ;
  cd ~/.local/share/Steam/steamapps/compatdata
  cd `grep -i -n "$@" ~/.local/share/Steam/steamapps/*.acf | head -1 | sed -e 's/^.*_//;s/\.acf:.:/ /;s/name//;s/"//g;s/\t//g;s/ /-/' | awk -F"-" '{printf "%s\n",$1}' | grep -o '[0-9]*'`;
  cd pfx/;
}

goto-pfx "Trackmania"
