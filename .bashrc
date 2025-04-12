# Minimal .bashrc configuration with username

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History settings
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# Check window size after each command
shopt -s checkwinsize

# Basic aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Enable spelling correction for cd
shopt -s cdspell

# Prompt with username and current directory
PS1='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Load bash completions if they exist
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Function to remove .tex file and its auxiliary files
rmtex() {
    if [[ "$1" == *.tex ]]; then
        base="${1%.tex}"
    else
        base="$1"
    fi
    
    # List of common LaTeX auxiliary extensions
    extensions=(".aux" ".log" ".pdf" ".out" ".toc" ".synctex.gz" ".fls" ".fdb_latexmk" ".bbl" ".blg")
    
    # Remove the base .tex file if it exists
    if [ -f "${base}.tex" ]; then
        rm "${base}.tex"
        echo "Removed: ${base}.tex"
    fi
    
    # Remove all auxiliary files
    for ext in "${extensions[@]}"; do
        if [ -f "${base}${ext}" ]; then
            rm "${base}${ext}"
            echo "Removed: ${base}${ext}"
        fi
    done
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/lemkei/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lemkei/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/lemkei/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/lemkei/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

