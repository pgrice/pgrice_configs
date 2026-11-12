export SVN_EDITOR=/usr/bin/vim.gtk
set -o vi

# Linting helper functions
function cf {
    clang-format-3.9 -style=file "$1" > /tmp/clang-format-"$1"
    vimdiff "$1" /tmp/clang-format-"$1"
    rm /tmp/clang-format-"$1"
    }

function cf80 {
    clang-format-3.9 -style='{Language: Cpp, BasedOnStyle: Google, ColumnLimit: 80}' "$1" > /tmp/clang-format-"$1"
    vimdiff "$1" /tmp/clang-format-"$1"
    rm /tmp/clang-format-"$1"
    }

function cf120 {
    clang-format-3.9 -style='{Language: Cpp, BasedOnStyle: Google, ColumnLimit: 120}' "$1" > /tmp/clang-format-"$1"
    vimdiff "$1" /tmp/clang-format-"$1"
    rm /tmp/clang-format-"$1"
    }

# General Aliases
alias v='vim'
alias l='ls'
alias ls='ls -FGk --color=always'
alias la='ls -lAsh'
alias rm='rm -r'
alias mv='mv -i'
alias cp='cp -ir'
alias p='cd ../'
alias pp='cd ../../'
alias ppp='cd ../../../'
alias du='echo "du -hc --max-depth=1" && du -hc --max-depth=1' # A sensible disk-usage for current directory
alias rmpyc='rm -vf *.pyc; rm -vf `find . -name *.pyc`'  # remove the pesky .pycs
alias rmsvn='sudo find . -name ".svn" -exec rm -rf {} \;'
alias open='gnome-open'

# Bash prompt (PS1) configuration
GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_THEME_FILE=~/git/pgrice_configs/bash/git-prompt-colors.sh
GIT_PROMPT_THEME=Custom
source ~/git/bash-git-prompt/gitprompt.sh

# Git Aliases
#source ~/git/git-completion.bash
alias g='git'
alias gch='echo "git checkout:" && git checkout'
alias gco='echo "git commit:" && git commit'
alias gf='echo "git fetch" && git fetch'
alias gm='echo "git merge" && git merge'
alias gl='echo "git log" && git log'
alias grb='echo "git rebase -i --autosquash" && git rebase -i --autosquash'
alias merge-main='git fetch origin main:main && git merge main'
function gpr {
    ID=$1
    echo "git fetch origin pull/$ID/head:PR-$ID && git checkout PR-$ID"
    git fetch origin pull/$ID/head:PR-$ID && git checkout PR-$ID
}
function fetch {
    BRANCH=$1
    echo "git fetch origin $BRANCH:$BRANCH"
    git fetch origin $BRANCH:$BRANCH
}

function worktree {
    # If no branch name is provided, make a worktree from the current branch
    if [ -z "$1" ]; then
        BRANCH=$(git branch --show-current)
	if [ "$BRANCH" = 'main' ]; then
            echo "Cannot create worktree from 'main'"
	    return 1;
	fi;
	echo "Checking out main on current instance"
	git checkout main
    # If a branch name is given, create it and make a worktree
    else
        BRANCH=$1
	echo "Creating branch $BRANCH"
	git branch $BRANCH
    fi
    WT_PATH=~/jupiter/trees/$BRANCH
    git worktree add $WT_PATH $BRANCH
    cd $WT_PATH
}

## BRT Aliases
function bundle {
  REPO_ROOT=$(git rev-parse --show-toplevel)
  pushd "$REPO_ROOT"
   ./autonomy/jupiter/robotics/halo/bundle/build.sh
  popd
}

alias awsup="aws sso login --profile jpe && aws configure export-credentials --profile jpe --format env > ~/.cache/aws_credentials.env"

function build_capture_ui {
  REPO_ROOT=$(git rev-parse --show-toplevel)
  pushd "$REPO_ROOT"
  rm -f bazel-bin/autonomy/jupiter/tools/stamps.env
  bazel build //autonomy/jupiter/robotics/halo/capture_ui:capture_ui_deb
  popd  
}

function c {
  ssh -o StrictHostKeyChecking=no "clay$1"
}

alias jrobo="ssh -A phillip.grice@llmd-lab-robo001.users.stc02.bluerivertech.info"
alias abuild="ssh -A phillip.grice@lpgt-athac001.users.stc02.bluerivertech.info"

# Ros Aliases
#source /opt/ros/$ROS_DISTRO/share/rosbash/rosbash
#alias rt='echo "rostopic: " && rostopic'
#alias rtl='echo "rostopic list:" && rostopic list'
#alias rtll='echo "rostopic list|less:" && rostopic list | less'
#alias rtlg='echo "rostopic list | grep" && rostopic list | grep'
#alias rte='echo "rostopic echo: " && rostopic echo'
#alias rte1='echo "rostopic echo -n 1: " && rostopic echo -n 1'
#alias rti='echo "rostopic info: " && rostopic info'
#alias rn='echo "rosnode: " && rosnode'
#alias rnl='echo "rosnode list: " && rosnode list'
#alias rnlg='echo "rosnode list | grep: " && rosnode list | grep'
#alias rni='echo "rosnode info: " && rosnode info'
#alias rms='echo "rosmsg show: " && rosmsg show'
#alias rviz='echo "rosrun rviz rviz " && rosrun rviz rviz'

#complete -F "_roscomplete_rostopic" "rt"
#complete -F "_roscomplete_rosnode" "rn"
#
#function imv () { echo "rosrun image_view image_view image:=$1" && rosrun image_view image_view image:=$1; }
#function imvt () { echo "rosrun image_view image_view image:=$1 _image_transport:=theora" && rosrun image_view image_view image:=$1 _image_transport:=theora; }

