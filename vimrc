"""""""""""""""""""""""""""""""""""""""""""""""""
" 基本設定
"""""""""""""""""""""""""""""""""""""""""""""""""
"""
" 文字コード
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif
" vim のデフォルト設定にする
set nocompatible
"""

"""""""""""""""""""""""""""""""""""""""""""""""""
" viminfo
"""""""""""""""""""""""""""""""""""""""""""""""""
"""
set viminfo='20,\"50 " read/write a .viminfo file, don't store more
set history=50 " keep 50 lines of command line history
"""

"""""""""""""""""""""""""""""""""""""""""""""""""
" カラースキーマを設定
"""""""""""""""""""""""""""""""""""""""""""""""""
"""
""" 全角スペースの可視化
" 参考 : http://qiita.com/kojionilk/items/67379e68cf54d811081a
augroup highlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight link IdeographicSpace Todo
  autocmd VimEnter,WinEnter * call matchadd("IdeographicSpace", '　')
augroup END "

" シンタックスのカラー表示をON
syntax on

""" デフォルトで使用可能なカラースキーム
"colorscheme delek
"colorscheme koehler
"colorscheme peachpuff
"colorscheme torte
"colorscheme blue
colorscheme desert
"colorscheme morning
"colorscheme ron
"colorscheme zellner
"colorscheme darkblue
"colorscheme elflord
"colorscheme murphy
"colorscheme shine
"colorscheme default
"colorscheme evening
"colorscheme pablo
"colorscheme slate

""""""""""""""""""""""""""""""""""""""""""""""""
" vimdiff
""""""""""""""""""""""""""""""""""""""""""""""""
" vimdiffの色設定
" 参考 : http://qiita.com/takaakikasai/items/b46a0b8c94e476e57e31
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

"""""""""""""""""""""""""""""
" インデント設定
"""""""""""""""""""""""""""""
"""
" ＜TAB>入力時、空白を挿入にする
set expandtab
" タブ表示幅を設定
set tabstop=4
" <TAB>入力時、挿入する文字数を設定
set softtabstop=4
" 自動インデントを行った際、設定する空白数
set shiftwidth=4
" コンテキストに応じたタブの処理を行なう
set smarttab
" 改行時に前の行の行末を見て自動でインデント
"set smartindent
" インデント自動的
set autoindent
"""

"""""""""""""""""""""""""""""
" 画面表示
"""""""""""""""""""""""""""""
"""
" 行番号を表示
set number
" 相対行番号で表示
"set relativenumber
" 不可視文字を表示
set list
" 不可視文字の表示文字を設定
set listchars=tab:>-,trail:_
" ステータスラインの設定
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
" ステータスラインを常に表示
set laststatus=2
" 行を折り返す
set wrap
" 強調表示する列を設定する
"set colorcolumn=80
" 編集中のファイル名を表示しない
set notitle
" 括弧の対応をハイライト
set showmatch
" 現在のモードを表示
set showmode
" 入力中のコマンドを表示する(例えば yy を実行する際に yだけ入力すると「y」が右下に表示される。)
set showcmd
" カーソルラインを有効化
"set cursorline
" 列を強調表示
"set cursorcolumn
" カーソルラインを色なしに設定(行番号のみをハイライト)
"autocmd ColorScheme * highlight clear CursorLine
" ルーラー表示
"set ruler
"""

"""""""""""""""""""""""""""""
" 検索設定
"""""""""""""""""""""""""""""
"""
" 検索結果をハイライト表示する
set hlsearch
" インクリメンタルサーチを有効にする
set incsearch
" 検索時に最後まで移動したら最初に戻る
set wrapscan
"""

"""""""""""""""""""""""""""""
" 移動設定
"""""""""""""""""""""""""""""
"""
" 行頭・行末の左右移動で行を移動する
set whichwrap=b,s,h,l,<,>,[,]
" BSで削除できるものを指定する
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set bs=indent,eol,start
"""

"""""""""""""""""""""""""""""
" コマンドモード
"""""""""""""""""""""""""""""
"""
" コマンド補完を強化
set wildmenu
" リスト表示，最長マッチ
set wildmode=list:longest
"""

"""""""""""""""""""""""""""""
" その他
"""""""""""""""""""""""""""""
"""
" 8進数を無効にする。<C-a>,<C-x>に影響する
set nrformats-=octal
" 日本語の行の連結時には空白を入力しない
set formatoptions+=Mm
" 折り畳みを設定「{{{で囲う」
" za 部分開閉
" zr 全開き
" zm 全閉じ
"set foldmethod=marker
" 折り畳み階層指定
"#set foldlevel=1
"""

"""""""""""""""""""""""""""""""""""""""""""""""""
" キーマップを設定
"""""""""""""""""""""""""""""""""""""""""""""""""
"""
"nmap h <Insert>
"nmap i <Up>
"nmap j <Left>
"nmap k <Down>
"nmap l <Right>
nmap scb <C-w><Left>gg:set scrollbind<CR>:set nowrap<CR><C-w><Right>gg:set scrollbind<CR>:set nowrap<CR><C-w><Left>
"""

"""""""""""""""""""""""""""""""""""""""""""""""""
" タブラインを設定
" 参考: http://qiita.com/wadako111/items/755e753677dd72d8036d
"""""""""""""""""""""""""""""""""""""""""""""""""
"""
" Anywhere SID.
function! s:SID_PREFIX() "
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction "

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
" タブラインの表示設定
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
" 常にタブラインを表示
set showtabline=2
