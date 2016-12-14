#!/bin/bash

# 関数群を読込み
. ~/document-src/template/build/module/functions.sh

# 定義ファイル読込み
. ~/document-src/template/build/env

echo "start website building ..."
echo "website url : ${MY_HP_URL}"

# documentフォルダがなければ
# documentリポジトリをcloneする
if [ ! -d ${DIST_DIR} ]; then
  echo "Not Clone dist_dir : ${DIST_DIR}"
  exit 1
  # git clone "https://github.com/masa1724/document.git" ${DIST_DIR}
else
  # .gitディレクトリ以外を削除
  ls -1d ${DIST_DIR}* | grep -v "\.git" | xargs rm -rf
fi

# ディレクトリ一覧を辞書順に取得する
# liタグ挿入順の都合上、逆順でソートする
g_src_dir_list=$(ls -1d ${SRC_DIR}*/ | grep -v "template" | sort -fr)

############ 最上位のindex.html作成 ############################
# 最上位のindex.html
root_index_html="${DIST_DIR}index.html"

# templateファイルをコピー
cp -p ${TEMPLATE_HTML} ${root_index_html}
# js, cssをフォルダごとコピー
cp -pr ${TEMPLATE_DIR}public_js "${DIST_DIR}"
cp -pr ${TEMPLATE_DIR}public_css "${DIST_DIR}"


for src_dir_path in ${g_src_dir_list[@]};
do
  dir_name="$(basename ${src_dir_path})"

  html_src="<li><a href='${MY_HP_URL}${dir_name}' \
                   title='${dir_name}'> \
                 ${dir_name}</a></li>"

  # インクルードする行の番号取得
  inum=$(get_include_position ${root_index_html})

  # ファイル内容を置換
  sed -i -e "${inum}i ${html_src}" ${root_index_html}
  sed -i -e "s/%title/"${re_file_name}"/g" "${root_index_html}"
  sed -i -e "s/%last_update_time/""${BUILD_WEB_SITE_TIME}""/g" "${root_index_html}"
  sed -i -e "s|%current-path|""$(make_folder_path_atag '')""|g" "${root_index_html}"
done
##############################################################

################ 各コンテンツ毎の index.html作成 ################
for src_dir_path in ${g_src_dir_list[@]};
do
  src_dir_path="${src_dir_path}/"

  dir_name="$(basename ${src_dir_path})"
  dist_dir_path="${DIST_DIR}${dir_name}/"

  # 出力用ディレクトリ作成
  mkdir ${dist_dir_path}

  # 各ページ用のindex.html
  category_root_index_html="${dist_dir_path}index.html"

  # templateをコピー
  cp -p ${TEMPLATE_HTML} ${category_root_index_html}

  # フォルダ内のファイル一覧取得
  # ファイル名の先頭がアンダーバーのファイルも除外する
  file_list=$(ls -1F ${src_dir_path} | grep -v "/" | grep -v "^__*")

  # ファイル名に空白を含む場合があるので、IFSを改行コードに設定
  # ディレクトリはさすがにないだろ。。。
  SAVE_IFS=$IFS
  IFS=$'\n'

  for src_file_name in ${file_list[@]};
  do
    ########## 各ファイルの変換 ##############################################
    # ファイル名にスペースが含まれていた場合、 _ へ置換する
    re_file_name=$(space2underbar "${src_file_name}")
    h_file_name="${re_file_name%.*}.html"

    # 拡張子を取得し、小文字変換
    ext="$(echo ${re_file_name##*.} | tr A-Z a-z)"

    # ファイルによって変換処理を分ける
    case "${ext}" in
    "adoc")
       # asciidoctorでHTMLへ変換
       asciidoctor "${src_dir_path}${src_file_name}" -D "${dist_dir_path}"

       # 変換したHTMLのファイル名をリネーム
       mv "${dist_dir_path}${src_file_name%.*}.html" "${dist_dir_path}${h_file_name}"

       # 戻るボタンを追加
       sed -i "s|</body>|""${BACK_BTN_JS_INCLUDE}""</body>|g" "${dist_dir_path}${h_file_name}" ;;
    "md")
       # pandocでHTMLへ変換
       # 変換したHTMLのファイル名をりネーム
       pandoc -f markdown -t html "${src_dir_path}${src_file_name}" -o "${dist_dir_path}${h_file_name}" ;;
    "jpg" | "jpeg" | "png" | "bmp" | "gif" | "tif" | "pdf")
       h_file_name=${re_file_name}
       #画像ファイル系は全てそのままコピーする
       cp -p "${src_dir_path}${src_file_name}" "${dist_dir_path}${re_file_name}" ;;
    *)
      # adoc以外は全て拡張子をhtmlにし、コピーする
      # テンプレートのコピー
      cp -p ${TEMPLATE_HTML2} "${dist_dir_path}${h_file_name}"

      ### HTMLファイルへの変換 ###
      # インクルードする行番号取得
      inum=$(get_include_position ${TEMPLATE_HTML2})

      # ファイル内容を置換
      sed -i -e "${inum}r ${src_dir_path}${src_file_name}" "${dist_dir_path}${h_file_name}"
      sed -i -e "s/%title/""${re_file_name}""/g" "${dist_dir_path}${h_file_name}"
      update_ts="$(get_file_last_updatetime ${src_dir_path}${src_file_name})"
      sed -i -e "s/%last_update_time/""${update_ts}""/g" "${dist_dir_path}${h_file_name}"
    esac
    #######################################################################

    # コンテンツのリンクを追加
    c_html_src="<li><a href='${MY_HP_URL}${dir_name}/${h_file_name}' \
                       title='${dir_name}/${re_file_name}'> \
                    ${re_file_name}</a></li>"

    # インクルードする行の番号
    c_inum=$(get_include_position ${category_root_index_html})

    # ファイル内容を置換
    sed -i -e "${c_inum}i ${c_html_src}" ${category_root_index_html}
  done

  sed -i -e "s/%title/"${dir_name}"/g" "${category_root_index_html}"
  sed -i -e "s/%last_update_time/""${BUILD_WEB_SITE_TIME}""/g" "${category_root_index_html}"
  sed -i -e "s|%current-path|""$(make_folder_path_atag ${dir_name})""|g" "${category_root_index_html}"

  IFS=$SAVE_IFS
done
########################################################################

#exit 0

# HOMEページをgitへコミットする
cd ${DIST_DIR}
git add .
git commit -m 'aa'
git push

echo "complete website building!!"
exit 0
