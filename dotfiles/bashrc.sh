# bashrc

#################################################
# 定数定義
#################################################

# ssh-agentファイルパス
SSH_AGENT_FILE=$HOME/.ssh-agent

#################################################
# alias定義
#################################################

alias rm="rm -i"
alias pwd="pwd -P"
alias la="ls -a"
alias ll="ls -la"
alias vi="vim"

#################################################
# bash起動時の初期設定
#################################################

# ssh-agentの環境変数を読み込み
if pgrep "^ssh-agent$" >& /dev/null;then
    source ${SSH_AGENT_FILE} >& /dev/null
else
    ssh-agent > ${SSH_AGENT_FILE}
    source ${SSH_AGENT_FILE} >& /dev/null
    for ssh_key in ${HOME}/.ssh/id_rsa_*
    do
      ssh-add ${ssh_key}
    done
fi
