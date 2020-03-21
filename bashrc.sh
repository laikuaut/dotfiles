# bashrc

alias rm="rm -i"
alias pwd="pwd -P"
alias ll="ls -la"
alias vi="vim"

function lsa() {
  for file in `ls`
  do
    echo "`pwd`/${file}"
  done
}
