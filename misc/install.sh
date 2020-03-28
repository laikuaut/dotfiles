#!/bin/bash -u
#
# install.sh
# dotfilesインストール

#################################################
# 定数定義
#################################################

# スクリプト自身のパス
typeset -r SCRIPT_DIR=$(cd $(dirname $0); pwd)
# プロジェクトの絶対パス
typeset -r PROJECT_DIR=$(cd ${SCRIPT_DIR%/*}; pwd)

# dotfilesパス
typeset -r DOTFILES_DIR="${PROJECT_DIR}/dotfiles"
# profile.dパス
typeset -r PROFILE_D_DIR="${PROJECT_DIR}/profile.d"
# utilsパス
typeset -r UTILS_DIR="${PROJECT_DIR}/utils"

#################################################
# source読み込み
#################################################

# bashユーティリティ
source ${UTILS_DIR}/utils.sh

#################################################
# 関数定義
#################################################

# dotfileのインストール
#
# dotfileのインストールを行う。
#
# Args:
#   $1 source_path: 元ファイルパス
#   $2 target_path: 出力先ファイルパス
#
# Returns:
#   0: 正常終了
#   1: 異常終了
#
function __install_dotfile() {

    local source_path=$1; shift;
    local target_path=$1; shift;

    log_debug "インストールを開始します。(${source_path})"
    usleep 500000
    cat_filename ${target_path}
    read -p "== ${target_path} へインストールしますか？ (y/N): " yn
    case "$yn" in
        [yY]*)
            __replace_dotfile ${source_path} ${target_path}
            if [ $? -ne 0 ];then log_debug "fail."; return 1; fi
            ;;
        *)
            log_debug "cancel."
            ;;
    esac

    return 0
}

# dotfileの置き換え
#
# dotfile置き換え時は元ファイルに記載されているsource部分を
# 除去して新規パスに置き換える。
# その際、もとのファイルについてはmktempへ一時的にバックアップする。
# 標準エラー出力へバックアップしたファイルへのパスを出力する。
#
# Args:
#   $1 source_path: 元ファイルパス
#   $2 target_path: 出力先ファイルパス
#
# Returns:
#   0: 正常終了
#   1: 異常終了
#
function __replace_dotfile() {
    local source_path=$1; shift;
    local target_path=$1; shift;
    local source_file_name=$(basename ${source_path})
    local tmp_file=$(mktemp)

    # ファイルの置き換えを実行
    cp ${target_path} ${tmp_file} && \
    egrep -v "source .+/${source_file_name}$" ${tmp_file} > ${target_path} &&\
    echo "source ${source_path}" >> ${target_path}
    if [ $? -ne 0 ];then log_debug "fail."; return 1; fi

    log_debug "bashup tmpfile: ${tmp_file}"
    log_debug "success."

    return 0
}

# profile.dインストール
#
# /etc/profile.dへのファイルの配置を行う。
#
# Args:
#   なし
#
# Returns:
#   0: 正常終了
#   1: 異常終了
#
# Notes:
#   本処理の実行には、/etc/profile.dへのアクセス権が必要。
#
function __install_profiles() {
    local install_dir="/etc/profile.d"
    for profile in ${PROFILE_D_DIR}/*.sh
    do
        log_debug "インストールを開始します。(${profile})"
        usleep 500000
        read -p "== ${install_dir}/`basename ${profile}` へインストールしますか？ (y/N): " yn
        case "$yn" in
            [yY]*)
                cp ${profile} ${install_dir}
                if [ $? -ne 0 ];then log_debug "fail."; return 1; fi
                log_debug "success."
                ;;
            *)
                log_debug "cancel."
                ;;
        esac
        echo
    done
}

#################################################
# メイン処理
#################################################

# dotfileをインストール
__install_dotfile "${DOTFILES_DIR}/vimrc" "${HOME}/.vimrc"
__install_dotfile "${DOTFILES_DIR}/bashrc.sh" "${HOME}/.bashrc"
__install_dotfile "${UTILS_DIR}/utils.sh" "${HOME}/.bashrc"
__install_dotfile "${DOTFILES_DIR}/bash_profile.sh" "${HOME}/.bash_profile"
__install_dotfile "${DOTFILES_DIR}/bash_logout.sh" "${HOME}/.bash_logout"

# profile.dをインストール
__install_profiles