#!/bin/sh

id=$(xdo id -n scratchy);
if [ -z "$id" ]; then
  urxvtc -name scratchy -e zsh -c "tmux new-session -A -s dummy";
else
  action='hide';
  if [[ $(xprop -id $id | awk '/window state: / {print $3}') == 'Withdrawn' ]]; then
    action='show';
  fi
  xdo $action -n scratchy
fi