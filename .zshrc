# Allow autocompletion
autoload -Uz compinit promptinit
compinit
promptinit

# Arrow-key driven autocompletion
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

# for colors :c
autoload -Uz colors
colors

# nix ui
. /home/geox/.nix-profile/etc/profile.d/nix.sh

# load vcc for git
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
# to use prompt
RPROMPT='%F{blue}[%F{red}${vcs_info_msg_0_}%F{blue}]%f '
setopt prompt_subst

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats  '%b%u%c'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

# Mode vim
bindkey -v

# :peeposhy:
prompt adam2

eval $(ssh-agent)

# ls colors
eval $(dircolors -p | sed -e 's/DIR 01;34/DIR 01;35/' | dircolors /dev/stdin)
alias ghc='ghc -dynamic'
alias dr='dune runtest'
alias dp='dune promote'
alias ls='ls --color=auto'
alias '..'='cd ..'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gl='git lg'
alias gd='git diff'
alias gp='git push'
alias gpt='git push --follow-tags'
alias gs='git status'
alias glh='git lg | head'
alias trish='python /tmp/pip-req-build-ymj_jvld/trish.py'
alias GCC='gcc -Wall -Wextra -Werror -std=c99 -pedantic'
alias mid='python3 /home/geox/ing1/acdc/camoulette-tests-suites/mouli.py midterm.2026'
alias fck='python3 /home/geox/ing1/acdc/camoulette-tests-suites/mouli.py tp.04'

DISABLE_LS_COLORS=false

# Output tags in a readable format
taga () {
    git show-ref -d --tags |
        cut -b 42- |
        sort |
        sed 's/\^{}//' |
        uniq -c |
        sed 's/2\ refs\/tags\// A: /' |
        sed 's/1\ refs\/tags\//LW: /'
}

branch_rename() {
    [ "$#" -ne 2 ] && echo "Usage: branch_rename old_name new_name" && exit 1;
    #_name=$(git rev-parse --abbrev-ref HEAD);
    _name = $1
    git branch -m "$_name" "$2";
    git push origin --delete "$_name";
    git branch --unset-upstream "$2";
    git push origin "$2";
    git push origin -u "$2"
}

# check if wdir is a git repository and has a clang-format configuration
# if it has one, runs clang-format on .c and .h files.
# otherwise try to cp one from $HOME

die() {
    printf "\033[0;31m${@}\033[0m\n"
    exit 1
}

clfe() {
    repo="$(git rev-parse --show-toplevel 2>/dev/null)"

    if test "$?" -ne 0; then
        die "You must run this script from the work tree of a git repository"
    fi

    clang_format_file="${repo}/.clang-format"

    if ! test -f "${clang_format_file}"; then
        echo "Failed to find clang-format configuration at ${clang_format_file}"
        echo "Trying to cp $HOME/.clang-format ..."

        if ! test -f "$HOME/.clang-format"; then
            die "Failed to find clang-format configuration in $HOME"
        fi

        cp "$HOME/.clang-format" "$repo" && echo "Successfully copied .clang-format"
    fi

    find "$repo" -type f -name '*.[ch]' -exec clang-format --style=file -i {} ';' &&
        echo "Finished executing clang-format configuration."
    }

# Set up serverx
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

FLAGS() {
    echo "-Wall -Wextra -Werror -std=c99 -pedantic"
}

# opam configuration
[[ ! -r /home/geox/.opam/opam-init/init.zsh ]] || source /home/geox/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

if [ -e /home/geox/.nix-profile/etc/profile.d/nix.sh ]; then . /home/geox/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# eval "$(starship init zsh)"
