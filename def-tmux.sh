#!/bin/sh 

tmux new-session -d 'python ~/scripts-borrowed/ranger/ranger.py'
tmux split-window -h 'python ~/scripts-borrowed/ranger/ranger.py'
tmux new-window 'vim -c Calendar'
tmux split-window -h 'mutt'

tmux -2 attach-session -d

mr status

killall tmux
# old
