# bashrc

alias rm="rm -i"
alias pwd="pwd -P"
alias ll="ls -la"
alias vi="vim"

# 絶対パスのファイル一覧取得
function lsa() {
  for file in `ls`
  do
    echo "`pwd`/${file}"
  done
}
