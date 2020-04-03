# gitbash.sh
# Git用便利コマンド関数定義

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
