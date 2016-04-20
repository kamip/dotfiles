"
set tabstop=2
set autoindent
set expandtab
set shiftwidth=2
set number
set nocompatible               " be iMproved
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  "call neobundle#rc(expand('~/.vim/bundle/'))
  call neobundle#begin(expand('~/.vim/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  call neobundle#end()
endif

nnoremap <silent> :E :e#<CR>

NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'ywjno/vim-tomorrow-theme'
"=======================================================
" colorscheme
" ------------------------------------------------------
syntax on
filetype indent on
" tmux 使用時に t_Co=256 がないと色が反映されない
set t_Co=256
colorscheme tomorrow-night-bright
"if ($ft=='ruby')
"  colorscheme hybrid"Tomorrow-Night-Eighties
"else
"  colorscheme hybrid
"endif
set cursorline

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
  \ }
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'

"
" snippet
"
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
" 自分用 snippet ファイルの場所
let s:my_snippet = '~/snippet/'
let g:neosnippet#snippets_directory = s:my_snippet
" Plugin key-mappings.  " <C-k>でsnippetの展開
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
"let g:neocomplcache_enable_at_startup = 1
"let g:neocomplcache_enable_smart_case = 1

NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'

" Railsディレクトリツリー表示
NeoBundle 'scrooloose/nerdtree' 
nmap :tree :NERDTree

" web屋必須プラグイン
NeoBundle 'open-browser.vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'tell-k/vim-browsereload-mac'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'taichouchou2/html5.vim'
" jquery syntax追加
NeoBundle 'taichouchou2/vim-javascript' 
NeoBundle 'kchmck/vim-coffee-script'
" endwise.vimでrubyのendキーワードを自動挿入
NeoBundle 'tpope/vim-endwise.git' 
NeoBundle 'ruby-matchit'
NeoBundle 'vim-scripts/dbext.vim'

" コード補完
" NeoBundle 'taichouchou2/vim-rsense'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'marcus/rsense'
NeoBundle 'supermomonga/neocomplete-rsense.vim'

" コメント
NeoBundle 'tomtom/tcomment_vim'
" railsサポート
NeoBundle 'taichouchou2/vim-rails'
NeoBundle 'romanvbabenko/rails.vim'
NeoBundle 'ujihisa/unite-rake'
NeoBundle 'basyura/unite-rails'
" reference環境
NeoBundle 'thinca/vim-ref'
NeoBundle 'taichouchou2/vim-ref-ri'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://qiita.com/take/items/7bb67276c785e223069a "
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'thoughtbot/vim-rspec'

" leader のマッピングをスペースに変更
let mapleader=" "
let g:rspec_command = "Dispatch rspec {spec}"
" command=[Space -> c]
" nmap に続く <silent> は、マッピングが実行中のコマンドをエコー出力しないようにするためのオプション
" - http://www.ibm.com/developerworks/jp/linux/library/l-vim-script-1/
nmap <silent><leader>c :call RunCurrentSpecFile()<CR>
nmap <silent><leader>n :call RunNearestSpec()<CR>
nmap <silent><leader>l :call RunLastSpec()<CR>
nmap <silent><leader>a :call RunAllSpecs()<CR>
nmap <silent><leader>s :syntax on<CR>
nmap <silent><leader>h :syntax off<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite の設定
"http://www.karakaram.com/unite

"unite prefix key.
nnoremap [unite] <Nop>
" <Space> -> f を [unite] に紐付け
nmap <Space>f [unite]

"unite general settings
"インサートモードで開始
let g:unite_enable_start_insert = 1
"最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 50

"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ command=>[Space -> f -> f]
nnoremap <silent> :e :<C-u>UniteWithCurrentDir -buffer-name=files file<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> :b :<C-u>Unite buffer<CR>
"レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  "ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "ctrl+jで縦に分割して開く
  nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  "ctrl+lで横に分割して開く
  nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  "ctrl+oでその場所に開く
  nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
  inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
endfunction"}}}


" statusline をかっこよくしてくれるらしいです
NeoBundle 'bling/vim-airline'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" インデントに色を付けて見やすくする
" http://qiita.com/jnchito/items/5141b3b01bced9f7f48f
" NeoBundle 'nathanaelkane/vim-indent-guides'
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
" let g:indent_guides_enable_on_vim_startup = 1
" http://qiita.com/0829/items/261225a51439776b36bf
" indent-guidesからindentLineに乗り換え
NeoBundle 'Yggdroot/indentLine'
"let g:indentLine_faster = 1
"nmap <silent><Leader>i :<C-u>IndentLinesToggle<CR>
"let g:indentLine_color_term = 111
"let g:indentLine_color_gui = '#708090'
let g:indentLine_char = '|'
"set list lcs=tab:\|\ 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

NeoBundle 'tpope/vim-fugitive'

NeoBundle 'rking/ag.vim'

"
" grep 関連
" 
" grep検索 (,g を入力)
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" カーソル位置の単語をgrep検索 (,cg を入力)
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" grep検索結果の再呼出 (,r を入力)
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlp.vim (ファイル検索）
" http://kien.github.io/ctrlp.vim/
" http://mattn.kaoriya.net/software/vim/20111228013428.htm
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_user_command = ['.git', 'cd %s && find . -type f | grep -v .git']
" ag入ってたらagで検索させる
" ついでにキャッシュファイルからの検索もさせない
" http://celt.hatenablog.jp/entry/2014/07/11/205308
"if executable('ag')
"  let g:ctrlp_use_caching = 0
"  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup -g ""'
"endif

"NeoBundle 'L9'
"NeoBundle 'FuzzyFinder'



" http://qiita.com/kentaro/items/833075356d41e9d9bc75
" NeoBundle 'vim-scripts/vim-auto-save'
" デフォルトで有効にする
" let g:auto_save = 1



" 
" Rubyプログラミングが快適になるVim環境を0から構築する
" http://qiita.com/mogulla3/items/42a7f6c73fa4a90b1df3
"
" -------------------------------
" Rsense
" -------------------------------
let g:rsenseHome = "/usr/local/Cellar/rsense/0.3/libexec/"
let g:rsenseUseOmniFunc = 1

" --------------------------------
" neocomplete.vim
" --------------------------------
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
