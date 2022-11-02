LinuxとOSXのCLI環境をリッチで便利なものにするための設定ファイル群

以下のツールの設定ファイルが管理されています
- neovim
    - VSCode-neovim向けのプラグイン管理を含む
- powerline-shell
    - 現在使用していません
- i3, polybar
    - Arch Linux前提、アプリ大量依存
    - 現在使用していません
- latexmk
- tmux
- zsh

カスタマイズされたzshとNeovim、C/C++開発環境(主に[CompPro-CLI](https://github.com/KowerKoint/CompPro-CLI)を動かすため)の標準イメージ(Debian)の[Dockerfile](./Dockerfile)が用意されています。
主にM1 MacでLinuxの機能(NativeのGCCやAddress Sanitizer)を備えた開発環境がほしいときに使います。
