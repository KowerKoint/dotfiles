# dotfiles
(WSL Ubuntu20.04)
`sudo apt update`
`sudo apt install zsh`
`chsh $(whoami)` -> `/usr/bin/zsh`
<Reboot>
`curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh`
`sudo apt install python3-pip`
`pip3 install powerline-shell`
`sudo apt install peco`
`cd ~/dotfiles/.bin`
`./install.sh`
<install lsd https://github.com/Peltoche/lsd/releases>
`agi silversearcher-ag`
`agi neovim`
`agi npm`
`sudo npm install -g npm`
`sudo npm install -g neovim`
`sudo pip3 neovim`
`sudo pip3 --upgrade pynvim`
`agi python3-pip`
`agi python2`
`mc tmp`
`curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"`
`python2 get-pip.py`
`pip install neovim`
`pip install pynvim`
`agi gem`
`agi ruby`
`agi ruby-dev`
`sudo gem install neovim`
`sudo pip3 install --upgrade msgpack`
`nvim` -> :wqa
`agi fcitx`
`agi clangd`
`sudo pip3 install python-language-server`
`sudo gem install solargraph`
`sudo npm install -g vscode-html-languageserver-bin`
`sudo npm install -g vscode-css-languageserver-bin`
`sudo npm install -g vscode-json-languageserver-bin`
`sudo npm install -g javascript-typescript-langserver`
<install texlab "https://github.com/latex-lsp/texlab/releases">
`sudo npm i -g bash-language-server`
`agi openjdk-11-jdk`
`mkdir ~/mylib/jdt-language-server`
`wget -O - "http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz" | tar zxvf - -C ~/mylib/jdt-language-server`
`ln -s $(find ~/mylib/jdt-language-server/plugins -name "org.eclipse.equinox.launcher_*") ~/mylib/org.eclipse.equinox.launcher.jar`
`curl https://sh.rustup.rs -sSf | sh`
`rustup component add rls`
`rustup component add rust-analysis`
`rustup component add rust-src`
`agi nkf`
