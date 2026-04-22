[ -n "$PS1" ] && source ~/.bashrc_ubuntu;
[ -n "$PS1" ] && source ~/.bash_profile;

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"
