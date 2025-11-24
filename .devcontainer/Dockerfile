FROM docker.io/miktex/miktex:latest

ARG USERNAME=vscode
# MikTeXイメージの既定ユーザーIDは1000です
ARG USER_UID=1000
ARG USER_GID=$USER_UID

USER root

# 1. GPGエラー回避とツールインストール
# MikTeXのリポジトリ鍵エラーが出ても無視して、Gitなどをインストールします
RUN apt-get update || true \
    && apt-get install -y --no-install-recommends \
       git \
       perl \
       sudo \
       make \
       ca-certificates \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# 2. 既存のユーザー(UID 1000)を vscode に変更し、sudo権限を付与
# (新しく作るのではなく、既にある miktex ユーザーを改造します)
RUN usermod -l $USERNAME -d /home/$USERNAME -m miktex \
    && groupmod -n $USERNAME miktex \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# 3. ユーザー切り替えと初期設定
USER $USERNAME

# Update MikTeX package database to ensure AutoInstall works.
RUN miktex packages update-package-database

# MikTeXのパッケージ自動インストール設定
RUN initexmf --set-config-value=[MPM]AutoInstall=1 \
    && initexmf --update-fndb