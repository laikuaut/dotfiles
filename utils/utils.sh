# utils.sh
# bashユーティリティ

# TODO: モジュール単位にファイルを分ける。
#       インストールしないと使えないコマンドのチェックなどはファイル読み込みの最初に行う。

#################################################
# 関数定義
#################################################

# 絶対パスのファイル一覧取得
#
# Args:
#   なし
#
# Returns:
#   0: 正常終了
#   1: 異常終了
#
function lsa() {
    for file in `ls`
    do
      echo "`pwd`/${file}"
    done

    return 0
}

# ファイル名＋ファイル内容出力
#
# Args:
#   なし
#
# Returns:
#   0: 正常終了
#   1: 異常終了
#
function cat_filename() {
    local file_path=$1; shift;
    echo "#######################################" >&2
    echo "# ${file_path}" >&2
    echo "#######################################" >&2
    cat ${file_path}
    if [ $? -ne 0 ];then log_debug "fail."; return 1; fi
    echo >&2
}

# DEBUGログ出力
#
# Args:
#   $1 message: ログメッセージ文字列
#
# Returns:
#   0: 正常終了
#   1: 異常終了
#
# Notes:
#   loggerコマンドを利用して出力を行う。
#     - tag名:  実行シェル名($0)[:呼び出し元関数名]
#     - 優先度: debug
#     - 出力先: 標準エラー出力
#
function log_debug() {
    local message="$1"; shift;
    local tag_name="`basename $0`"
    local priority="debug"

    if [ -n "${FUNCNAME[1]}" ];then
        tag_name="${tag_name}:${FUNCNAME[1]}"
    fi
    logger -t "${tag_name}" -p "${priority}" -s -- "${message}"
}

# Dockerクリーン
#
# Args:
#   $1 message: ログメッセージ文字列
#
# Returns:
#   0: 正常終了
#   1: 異常終了
#
# Notes:
#   - Dockerコンテナ全削除
#     $ docker ps -qa | xargs docker rm
#
#   - Dockerイメージ全削除
#     $ docker images -q | xargs docker rmi
#
#   - Dockerボリューム全削除
#     $ docker volume ls
#     $ docker volume prune
#
function docker-clean() {

    # dokcerコマンドが存在するか確認
    if ! type docker >& /dev/null;then
        log_debug "fail. (dockerコマンドがありません。)"
        return 1;
    fi

    # dockerコンテナ削除
    docker ps -a
    read -p "== 全てのdockerコンテナを削除しますか？ (y/N): " yn
    case "$yn" in
        [yY]*)
            docker ps -qa | xargs docker rm
            ;;
        *)
            log_debug "cancel."
            ;;
    esac

    # dockerイメージ削除
    docker images
    read -p "== 全てのdockerイメージを削除しますか？ (y/N): " yn
    case "$yn" in
        [yY]*)
            docker images -q | xargs docker rmi
            ;;
        *)
            log_debug "cancel."
            ;;
    esac

    # dockerボリューム削除
    docker volume ls
    docker volume prune
}
