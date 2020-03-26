# bashrc

#################################################
# 定数定義
#################################################

#################################################
# alias定義
#################################################

alias rm="rm -i"
alias pwd="pwd -P"
alias la="ls -a"
alias ll="ls -la"
alias vi="vim"

#################################################
# 関数定義
#################################################

# 絶対パスのファイル一覧取得
function lsa() {
  for file in `ls`
  do
    echo "`pwd`/${file}"
  done
}

#################################################
# bash起動時の初期設定
#################################################

# SSH秘密鍵を保持
eval `ssh-agent`
for ssh_key in ~/.ssh/id_rsa_*
do
  ssh-add ${ssh_key}
done

