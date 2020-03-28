# utils.sh
# bashユーティリティ

#################################################
# 関数定義
#################################################

# TODO
function cat_filename() {
    local file_path=$1; shift;
    log_info "${file_path}"
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
