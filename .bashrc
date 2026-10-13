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
# Report cwd to wezterm via OSC 7 so tab titles show project folder
PROMPT_COMMAND='printf "\e]7;file://%s%s\e\\" "${HOSTNAME}" "${PWD}"'
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


export PATH="$HOME/neovim/build/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

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


# Create a bash function for your .bashrc that checks differences
function sync-config() {
  echo "Checking for differences between configurations..."
  
  # Print differences between home and repo
  diff -r ~/.config/nvim ~/wsl2_setup/.config/nvim || true
  diff ~/.bashrc ~/wsl2_setup/.bashrc || true
  
  # Ask to sync if needed
  read -p "Copy home files to repo? (y/n) " choice
  if [[ $choice == "y" ]]; then
    cp ~/.config/nvim/init.lua ~/wsl2_setup/.config/nvim/
    cp -r ~/.config/nvim/ftplugin/ ~/wsl2_setup/.config/nvim/
    cp -r ~/.config/nvim/templates/ ~/wsl2_setup/.config/nvim/
    cp ~/.bashrc ~/wsl2_setup/
    echo "Files copied to repo"
  fi
}


# Papis + BibTeX workflow
alias pa='papis add --from doi'
alias pl='papis list'  
alias pb='papis export --all --format bibtex > ~/references.bib && echo "✓ Updated references.bib"'

# LaTeX compile with bib
compile-latex() {
    pdflatex "$1"
    biber "${1%.tex}"
    pdflatex "$1"
    pdflatex "$1"
}

export EDITOR=nvim

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=64000
[ -f "$HOME/.secrets.sh" ] && . "$HOME/.secrets.sh"  # tokens, never synced

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/lemkei/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/lemkei/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
. "$HOME/.cargo/env"
export PATH="$HOME/bin:$PATH"

# Claude accounts: `claude work` = CERGE account, plain `claude` = personal
claude() {
  if [ "$1" = "work" ]; then
    shift
    CLAUDE_CONFIG_DIR="$HOME/.claude-work" command claude "$@"
  else
    command claude "$@"
  fi
}
