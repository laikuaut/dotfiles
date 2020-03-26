# dotfiles

## 使い方

### vimrc

```
$ cp vimrc ~/.vimrc
```

### bash

```
$ echo "source `pwd`/bashrc.sh" >> ~/.bashrc
$ echo "source `pwd`/bash_profile.sh" >> ~/.bash_profile
$ echo "source `pwd`/bash_logout.sh" >> ~/.bash_logout
$ sudo cp profile.d/*.sh /etc/profile.d/
```
