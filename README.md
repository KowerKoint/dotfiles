```
sudo apt update
sudo apt upgrade -y
sudo apt install zsh python3-pip silversearcher-ag neovim npm python2 gem ruby ruby-dev clangd openjdk-11-jdk nkf peco -y
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
sudo pip3 install --upgrade powerline-shell neovim pynvim msgpack python-language-server
curl "https://bootstrap.pypa.io/get-pip.py" | python2
sudo npm install -g npm
sudo npm install -g neovim vscode-html-languageserver-bin vscode-css-languageserver-bin vscode-json-languageserver-bin javascript-typescript-langserver bash-language-server
wget "https://github.com/Peltoche/lsd/releases/download/0.19.0/lsd_0.19.0_amd64.deb"
sudo dpkg -i lsd_0.19.0_amd64.deb
rm -rf lsd_0.19.0_amd64.deb
git clone https://github.com/KowerKoint/dotfiles
~/dotfiles/.bin/install.sh
wget https://github.com/latex-lsp/texlab/releases/download/v2.2.0/texlab-x86_64-linux.tar.gz
tar -xvf texlab-x86_64-linux.tar.gz -o -C ~/mylib
rm -rf texlab-x86_64-linux.tar.gz
mkdir ~/mylib/jdt-language-server
wget -O - "http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz" | tar zxvf - -C ~/mylib/jdt-language-server
ln -s $(find ~/mylib/jdt-language-server/plugins -name "org.eclipse.equinox.launcher_*") ~/mylib/org.eclipse.equinox.launcher.jar
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
rustup component add rls rust-analysis rust-src
chsh $(whoami)
```

```
yay -Syyu
yay -S zsh python-pip python2-pip the_silver_searcher neovim npm ruby clang jdk-openjdk nkf lsd wget xclip peco
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
sudo pip3 install --upgrade powerline-shell neovim pynvim msgpack python-language-server
sudo npm install -g npm
sudo npm install -g neovim vscode-html-languageserver-bin vscode-css-languageserver-bin vscode-json-languageserver-bin javascript-typescript-langserver bash-language-server
~/dotfiles/.bin/install.sh
wget https://github.com/latex-lsp/texlab/releases/download/v2.2.0/texlab-x86_64-linux.tar.gz
tar -xvf texlab-x86_64-linux.tar.gz -o -C ~/mylib
rm -rf texlab-x86_64-linux.tar.gz
mkdir ~/mylib/jdt-language-server
wget -O - "http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz" | tar zxvf - -C ~/mylib/jdt-language-server
ln -s $(find ~/mylib/jdt-language-server/plugins -name "org.eclipse.equinox.launcher_*") ~/mylib/org.eclipse.equinox.launcher.jar
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
rustup component add rls rust-analysis rust-src
chsh $(whoami)
