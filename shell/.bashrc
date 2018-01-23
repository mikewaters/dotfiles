## Terminal config
[[ -d ${HOME}/.bashrc.d ]] && for f in ${HOME}/.bashrc.d/*; do source $f; done

## Bashisms
[[ -f "${HOME}/.bash_aliases" ]] && source ${HOME}/.bash_aliases
[[ -d ${HOME}/.bash_completion.d ]] && for f in ${HOME}/.bash_completion.d/*; do source $f; done


