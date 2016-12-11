# includeファイルの行番号を返す}%
function get_include_position() {
  grep -n "%include_area" "$1" | cut -d ":" -f 1
  exit 0
}

# 全角/半角spaceをアンダーバーに置換
function space2underbar() {
  echo "$1" | tr ' ' '_' | tr ' ' '_'
}

# タイトルと最終更新時間を設定する
function get_file_last_updatetime() {
  file_path="$1"
  update_ts="$(ls -l --time-style=long-iso ${file_path} | awk '{print $6}')"
  update_ts="${update_ts} $(ls -l --time-style=long-iso ${file_path} | awk '{print $7}')"
  echo "${update_ts}"
  exit 0
}

function make_folder_path_atag() {
  path="$1"

  atag="<a href='""${MY_HP_URL}""'>/</a>"

  if [ "${path}" != "" ]; then
    atag="${atag}<a href='""${MY_HP_URL}$1""'>$path</a>"
  fi

  echo "$atag"
  exit 0
}
