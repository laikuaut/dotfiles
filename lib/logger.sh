# logger.sh
# Bashロガー関数定義

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
