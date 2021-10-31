# Allow autocompletion
autoload -Uz compinit promptinit
compinit
promptinit

# Arrow-key driven autocompletion
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

# Macro next / previous word
#key[Control-Left]="${terminfo[kLFT5]}"
#key[Control-Right]="${terminfo[kRIT5]}"

#[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
#[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

# Delete keyt set up
#key[Delete]=${terminfo[kdch1]}
#[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char


# Mode vim
bindkey -v

# This will set the default prompt to the walters theme
prompt adam2

# ls colors
#export CLICOLOR=1
#export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
#alias ll="ls -alG"
eval $(dircolors -p | sed -e 's/DIR 01;34/DIR 01;35/' | dircolors /dev/stdin)
alias ls='ls --color=auto'

DISABLE_LS_COLORS=false

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
