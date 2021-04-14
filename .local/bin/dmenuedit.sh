#!/usr/bin/env bash

: "${DMEDITOR:=st -e nvim}"

declare -A options
options[dunst]="$HOME/.config/dunst/dunstrc"
options[fontconfig]="$HOME/.config/fontconfig/fonts.conf"
options[mpv]="$HOME/.config/mpv/mpv.conf"
options[sxiv]="$HOME/.config/sxiv/exec/key-handler"
options[picom]="$HOME/.config/picom.conf"
options[nvim]="$HOME/.config/nvim/init.vim"
options[dmenu]="$HOME/suckless/dmenu/config.h"
options[dwm]="$HOME/suckless/dwm/config.h"
options[dwmMin]="$HOME/suckless/dwmMin/config.h"
options[dwm]="$HOME/suckless/st/config.h"
options[xinitrc]="$HOME/.xinitrc"
options[zsh]="$HOME/.zshrc"
declare -A options_clean
  
  for i in "${!options[@]}"; do
    [[ -f ${options["${i}"]} ]] && options_clean["${i}"]=${options["${i}"]}
  done

choice=$(printf '%s\n' "${!options_clean[@]}" | sort | dmenu -l 20 -p 'Edit config:' "$@")

if [ "$choice" ]; then
  cfg=$(printf '%s\n' "${options_clean["${choice}"]}")
  $DMEDITOR "$cfg"

else
    echo "Program terminated." && exit 0
fi
