# peco - https://github.com/peco/peco

###
# 'peco-select-history' and 'peco-cdr'
# These are from http://shibayu36.hatenablog.com/entry/2014/06/27/223538
###
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(builtin history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-cdr () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-cdr
bindkey '^@' peco-cdr

###
# `peco-search-document`
# This is from http://d.hatena.ne.jp/kbkbkbkb1/20120429/1335835500
###
function peco-search-document () {
  DOCUMENT_DIR="\
$HOME/Documents"
  SELECTED_FILE=$(echo $DOCUMENT_DIR | xargs find | \
    grep -E "\.(txt|md|pdf|key|numbers|pages|doc|docx|xls|xlsx|ppt|pptx)$" | peco)
  if [ $? -eq 0 ]; then
    CMD=$([ -n "$LBUFFER" ] && echo "$LBUFFER" || echo "open")
    BUFFER="$CMD $SELECTED_FILE"
  fi
}
zle -N peco-search-document
bindkey '^s' peco-search-document

###
# `peco-snippets`
# This is from http://kohkimakimoto.hatenablog.com/entry/2014/06/28/163412
###
function peco-snippets() {

    local line
    local snippet

    if [ ! -e ~/.snippets ]; then
        echo "~/.snippets is not found." >&2
        return 1
    fi

    line=$(grep -v "^#" ~/.snippets | peco --query "$LBUFFER")
    if [ -z "$line" ]; then
        return 1
    fi
    
    snippet=$(echo "$line" | sed "s/^\[[^]]*\] *//g")
    if [ -z "$snippet" ]; then
        return 1
    fi

    BUFFER=$snippet
    zle clear-screen
}

zle -N peco-snippets
bindkey '^x^f' peco-snippets

###
# `peco-search-clipboard`
# This if from http://mba-hack.blogspot.jp/2013/07/zsh.html#more
###
function peco-search-clipboard() {
    clipMenuPath='$HOME/Library/Application Support/ClipMenu'
plutil -convert xml1 $HOME/Library/Application\ Support/ClipMenu/clips.data -o - |\
        awk '/<string>/,/<\/string>/' |\
 
        # 15行目から最終行まで抜き出す
        sed -n '15, $p' |\
 
        sed -e 's/<string>//g' -e 's/<\/string>//g' -e 's/&lt;/</g' -e 's/&gt;/>/g' |\
        # head -5020 |tail -5000 |\
        sed '/^$/d'|cat -n |sort -k 2|uniq -f1 |sort -k 1 |\
        sed -e 's/^ *[0-9]*//g' |\
        awk '{for(i=1;i<NF;i++){printf("%s%s",$i,OFS=" ")}print $NF}' |\
 
        # ナンバリングの追加
        nl -b t -n ln |peco |sed -e "s/\ /\\\ /g" |\
 
            # ナンバリングの削除
        sed -e 's/\\ / /g' |cut -c 8- |ruby -pe 'chomp' |pbcopy
    zle reset-prompt
};
zle -N peco-search-clipboard 
 
# C-x, C-xでクリップボード履歴の検索
bindkey '^x^x' peco-search-clipboard

###
# `peco-kill
# This if from http://qiita.com/annyamonnya/items/33350b30f1d47003f759
###
function peco-kill(){
    proc=$(ps aux | peco)
    pid=$(echo "$proc" | awk '{print $2}')
    BUFFER="kill $pid"
}
zle -N peco-kill
bindkey '^xk' peco-kill

###
# `peco-ghq`
###
peco-ghq () {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-ghq

###
# `peco-open-file`
###
function peco-open-file() {
    local openFile=$(find . -type d \( -name '.svn' -o -name '.git' \) -prune -o -type f | peco --query "$LBUFFER")
    if [ "X${openFile}" != "X" -a -f ${openFile} ]; then
        BUFFER="open ${openFile}"
    fi
}
zle -N peco-open-file
bindkey '^xo' peco-open-file
