# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/thepassenger/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export TERM=xterm

# Key bindings
# Print current key bindings: bindkey
# List available key bindings: bindkey -l
# Interactively show pressed key when pressing any keys
bindkey "^[[H" beginning-of-line # HOME
bindkey "^[[F" end-of-line # END
bindkey "^[[3~" delete-char # DEL
bindkey "^[[3;5~" delete-word # CTRL+DEL - delete a whole word after cursor
bindkey "^H" backward-delete-word # CTRL+BACKSPACE - delete a whole word before cursor
bindkey "^[[1;5C" forward-word # CTRL+ARROW_RIGHT - move cursor forward one word
bindkey "^[[1;5D" backward-word # CTRL+ARROW_LEFT - move cursor backward one word
bindkey "^Z" undo # CTRL+Z
bindkey "^Y" redo # CTRL+Y

# Aliases
alias md="mkdir -p"
alias rd="rmdir"
alias t="tere --filter-search"
alias hib="systemctl hibernate"
alias exaa="exa -F --icons -a --no-user --no-time --no-permissions --color-scale"
alias editz="nano .zshrc"
alias kittykeys="bat ~/.config/kitty/kittykeys"

# Env Exports
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#index-match_002dwords_002dby_002dstyle
# Define how to match "words"; default mode is "normal" (alphanumerical + WORDCHARS)
# Default WORDCHARS are *?_-.[]~=/&;!#$%^(){}<>
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

#export PATH="/home/thepassenger/.cargo/bin:$PATH"
#export PATH="/home/thepassenger/.local/bin:$PATH"

#eval "$(zoxide init zsh)"
# eval $(ssh-agent)

export env LS_COLORS="bd=35:cd=35"
export BAT_THEME="Coldark-Dark"
export PAGER=bat


# https://github.com/mgunyho/tere
tere() {
    local result=$(command tere "$@")
    [ -n "$result" ] && cd -- "$result"
}

#export KITTY_CLONE_SOURCE_CODE=exa
#clone-in-kitty --title "~"

# If the internal history needs to be trimmed to add the current command line, setting this
# option will cause the oldest history event that has a duplicate to be lost before losing a
# unique event from the list. You should be sure to set the value of HISTSIZE to a larger
# number than SAVEHIST in order to give you some room for the duplicated events, otherwise
# this option will behave just like HIST_IGNORE_ALL_DUPS once the history fills up with unique
# events.
setopt HIST_EXPIRE_DUPS_FIRST
# When searching for history entries in the line editor, do not display duplicates of a line
# previously found, even if the duplicates are not contiguous.
setopt HIST_FIND_NO_DUPS
# If a new command line being added to the history list duplicates an older one, the older
# command is removed from the list (even if it is not the previous event).
setopt HIST_IGNORE_ALL_DUPS
# Do not enter command lines into the history list if they are duplicates of the previous event.
setopt HIST_IGNORE_DUPS
# Remove command lines from the history list when the first character on the line is a space,
# or when one of the expanded aliases contains a leading space. Only normal aliases (not
# global or suffix aliases) have this behaviour. Note that the command lingers in the internal
# history until the next command is entered before it vanishes, allowing you to briefly reuse
# or edit the line. If you want to make it vanish right away without entering another command,
# type a space and press return.
setopt HIST_IGNORE_SPACE
# When writing out the history file, older commands that duplicate newer ones are omitted.
setopt HIST_SAVE_NO_DUPS
# This option works like APPEND_HISTORY except that new history lines are added to the $HISTFILE
# incrementally (as soon as they are entered), rather than waiting until the shell exits.
setopt INC_APPEND_HISTORY

# Git status in prompt with the $(gitprompt) expansion
source /usr/share/zsh/scripts/git-prompt.zsh
ZSH_THEME_GIT_PROMPT_PREFIX=" ("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_TAG="%{$fg_bold[white]%}"

# Customizing the prompt
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# Either show hostname in the prompt "[tom@v330:~]" or not [tom:~]:
PROMPT='%B%F{magenta}[%n:%f%F{blue}%(4~|../|)%3~%f%b$(gitprompt)%B%F{magenta}]%f%b ' # without hostname
# PROMPT='%B%F{magenta}[%n@%m:%f%F{blue}%(4~|../|)%3~%f%b$(gitprompt)%B%F{magenta}]%f%b ' # with hostname
RPROMPT='%B%F{red}%(0?||Exit code: %?)%f%b'

# CTRL+ARROW_RIGHT   - partially accept suggestion up to the point that the cursor moves to
# ARROW_RIGHT or END - accept suggestion and replace contents of the command line buffer with the suggestion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# CTRL+T - paste the selected files and directories onto the command-line
# CTRL+R - paste the selected command from history onto the command-line
# ALT+C  - cd into the selected directory
source /usr/share/fzf/key-bindings.zsh
# Type ** and hit tab (eg. with the cd command; works with directories, files, process IDs, hostnames, environment variables)
source /usr/share/fzf/completion.zsh

# Sift through history for previous commands matching everything up to current cursor position.
# Moves the cursor to the end of line after each match.
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # ARROW_UP
bindkey "^[[B" down-line-or-beginning-search # ARROW_DOWN
# -> This only works for prefixes. If you want to match any substring in the history
#    then https://github.com/zsh-users/zsh-history-substring-search might be interesting

# Catppuccin Macchiato Theme (for zsh-syntax-highlighting)
#
# Paste this files contents inside your ~/.zshrc before you activate zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES

# Main highlighter styling: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
#
## General
### Diffs
### Markup
## Classes
## Comments
ZSH_HIGHLIGHT_STYLES[comment]='fg=#5b6078'
## Constants
## Entitites
## Functions/methods
ZSH_HIGHLIGHT_STYLES[alias]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[function]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[command]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#a6da95,italic'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#f5a97f,italic'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#f5a97f'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#f5a97f'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#c6a0f6'
## Keywords
## Built ins
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#a6da95'
## Punctuation
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#ed8796'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#ed8796'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#ed8796'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#ed8796'
## Serializable / Configuration Languages
## Storage
## Strings
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#eed49f'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#eed49f'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#eed49f'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#ee99a0'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#eed49f'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#ee99a0'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#eed49f'
## Variables
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#ee99a0'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#cad3f5'
## No category relevant in spec
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ee99a0'
ZSH_HIGHLIGHT_STYLES[path]='fg=#cad3f5,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#ed8796,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#cad3f5,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#ed8796,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#c6a0f6'
#ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=?'
#ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=?'
#ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=?'
#ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=?'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#ee99a0'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[default]='fg=#cad3f5'
ZSH_HIGHLIGHT_STYLES[cursor]='fg=#cad3f5'

# Must go last (see https://github.com/zsh-users/zsh-syntax-highlighting#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
