# utils.sh
# bashユーティリティ

#################################################
# 関数定義
#################################################

# 絶対パスのファイル一覧取得
# TODO
function lsa() {
    for file in `ls`
    do
      echo "`pwd`/${file}"
    done
}

# TODO
function cat_filename() {
    local file_path=$1; shift;
    echo "#######################################" >&2
    echo "# ${file_path}" >&2
    echo "#######################################" >&2
    cat ${file_path}
    echo
}

# TODO
function log_info() {
    local message="$1"; shift;
    local tag_name="`basename $0`"
    local priority="info"
    #echo "[LOG][`date '+%Y-%m-%d +%H:%M:%S'`] ${message}" >&2

    if [ -n "${FUNCNAME[1]}" ];then
        tag_name="${tag_name}:${FUNCNAME[1]}"
    fi
    logger -t "${tag_name}" -p "${priority}" -s -- "${message}"
}
