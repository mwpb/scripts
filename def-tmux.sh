#!/bin/sh 

tmux new-session -d 'python ~/scripts/ranger/ranger.py'
tmux split-window -h 'python ~/scripts/ranger/ranger.py'
tmux new-window 'calcurse'
tmux split-window -h 'mutt'

tmux -2 attach-session -d

mr status

killall tmux
