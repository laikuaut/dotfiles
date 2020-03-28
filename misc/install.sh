#!/bin/bash -u
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

# TODO
# $1 source_path 元ファイルパス
# $2 target_path 出力先ファイルパス
#
function __install_dotfile() {

    local source_path=$1; shift;
    local target_path=$1; shift;

    log_info "${source_path} のインストールを開始します。"
    cat_filename ${target_path}
    read -p "== ${target_path} へインストールしますか？ (y/N): " yn
    case "$yn" in
        [yY]*)
            __replace_dotfile ${source_path} ${target_path}
            ;;
        *)
            log_info "cancel."
            ;;
    esac
    echo

    return 0
}

# TODO
function __replace_dotfile() {
    local source_path=$1; shift;
    local target_path=$1; shift;
    local source_file_name=$(basename ${source_path})
    local tmp_file=$(mktemp)

    cp ${target_path} ${tmp_file}
    egrep -v "source .+/${source_file_name}$" ${tmp_file} > ${target_path}
    echo "source ${source_path}" >> ${target_path}

    log_info "${tmp_file}"
    log_info "end."
}

# TODO
function __install_profiles() {
    local install_dir="/etc/profile.d"
    for profile in ${PROFILE_D_DIR}/*.sh
    do
        log_info "${profile} のインストールを開始します。"
        read -p "== ${install_dir}/`basename ${profile}` へインストールしますか？ (y/N): " yn
        case "$yn" in
            [yY]*)
                cp ${profile} ${install_dir}
                ;;
            *)
                log_info "cancel."
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