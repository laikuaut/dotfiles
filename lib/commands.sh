# commands.sh
# 便利Bashコマンド関数定義

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
