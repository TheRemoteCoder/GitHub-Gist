#!/bin/bash

# - Apache
# - Composer
# - Docker
# - Git
# - PHP
# - Helpers
# - System


# ----------------------------------------------------------------------------------------------------------------------------------- Apache

# Control Apache server
# Requires 'sudo su - ...' if not allowed for user via 'sudo visudo'
alias apst="sudo apachectl start"
alias aprst="sudo apachectl restart"
alias apstp="sudo apachectl stop"


# --------------------------------------------------------------------------------------------------------------------------------- Composer

alias composer="php /usr/local/bin/composer.phar"


# ----------------------------------------------------------------------------------------------------------------------------------- Docker

# Check if Docker daemon is running before adding aliases - Suppress CLI notice:
# 'Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the Docker daemon running?'
if [[ -n `launchctl list | grep "docker.docker"` ]]
then
    # Start/Stop
    alias dcu="docker-compose up"
    alias dcdwn="docker-compose down"

    # Build
    alias dcb="docker-compose build"
    alias dcbnc="docker-compose build --no-cache"

    # Show containers
    alias dps="docker ps"
    alias dpsa="docker ps -a"

    # Show images
    alias dsi="docker images"
    alias dsai="docker images -a"

    # Monitor logs
    alias dlogs="docker logs $(docker ps -q)"

    # SSH login (in first running container)
    # alias dssh="docker exec -it $(docker ps -q) sh"

    # SSH login (container by name)
    alias dexecit="docker exec -it" # Add: (%container name%) bash

    # Stop all running containers
    alias dstp="docker stop $(docker ps -q)"

    # Delete containers: All
    # alias drmc="docker rm $(docker ps -a -q)"

    # Delete images: All unused / All
    # alias drmi="docker rmi $(docker images -q)"

else
    # Docker is not running - Don't add aliases
    echo ""
fi


# -------------------------------------------------------------------------------------------------------------------------------------- Git

# Misc
alias gb="git branch"
alias gs="git status"

# Cherry picking
alias gcherry="git cherry-pick"

# Clean up
# - Delete branch
# - Remove untracked/deleted files
# - Reset changed files
alias gbdelete="git branch -d"
alias gclean="git clean -d -f"
alias greset="git reset --hard"

# Commit
alias gcm="git commit -m"
alias gacm="git add .; git commit -m"
alias gacmp="git add .; git commit -m '.'; git push"

# Conflicts - Show unresolved
alias gcfl="git ls-files -u; git diff --name-status --diff-filter=U; git mergetool"

# Patches
# - Create for all staged files (of 'git add .')
alias gptch="git diff --cached > patch.patch"

# Create / Switch branch
alias gc="git checkout"
alias gcb="git checkout -b"
alias gcbm="git checkout master"

# Fetch / Pull
alias gf="git fetch"
alias gfo="git fetch origin"
alias gfu="git fetch upstream"
alias gp="git pull"
alias gpsh="git push"

# Garbage collection - Fix issues like these:
# - 'Unlink of file '...' failed. Should I try again? (y/n)'
alias ggc="git gc"

# View Git log
alias glogref="git log --reflog" # git reflog

# Merge
alias gm="git merge"
alias gmum="git merge upstream/master"
alias gms="git merge --squash"
alias gpo="git fetch origin; git pull origin"
alias gpu="git fetch upstream; git pull upstream"

# Push
alias gpsuo="git push --set-upstream origin"

# Remotes
alias gr="git remote"
alias grv="git remote -v"
alias grfull="git rev-parse --abbrev-ref --symbolic-full-name @{u}"

# Remotes - Prune
alias grp="git remote prune"
alias grpo="grp origin"

# Stash
alias gsa="git stash apply" # Add numeric index (0, ...)
alias gsl="git stash list"


# -------------------------------------------------------------------------------------------------------------------------------------- PHP

# Test if SOAP is running on PHP server
alias phpsoap="php -i | grep Soap"


# ---------------------------------------------------------------------------------------------------------------------------------- Helpers

# Reload Bash config
# Warning: Adds new commands to exisiting old ones!
alias rcfg="source ~/.bashrc"

# Clean unneeded OS-specific dot-files like '._*'.
# Especially useful in encrypted containers + Cloud storage synchronisation
# - https://coderwall.com/p/yf7yjq/clean-up-osx-dotfiles
alias sweephidden="find . -type f -name '._*' -delete"


# ----------------------------------------------------------------------------------------------------------------------------------- System

# Search functions (configurable)
alias gl="grep -lir"

# Go to previous folders
alias c1="cd .."
alias c2="c1; c1"
alias c3="c1; c2"

# Clear current view
alias cls="cls"
alias c="clear"

# View
alias ll="ls -al"
