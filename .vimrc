syntax on
set t_Co=256
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
autocmd VimEnter * NERDTree
colorscheme jellybeans 
map <C-n> :tabnext<CR>
map <C-p> :tabprev<CR>
map <C-t> :NERDTreeToggle<CR>
nnoremap <C-r> :set nonumber!<CR>
autocmd VimEnter * wincmd p
autocmd BufEnter * lcd %:p:h
filetype on
filetype plugin on 

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Better modes.  Remeber where we are, support yankring
set viminfo=!,'100,\"100,:20,<50,s10,h,n~/.viminfo

" The PC is fast enough, do syntax highlight syncing from start
autocmd BufEnter * :syntax sync fromstart

" Move Backup Files to ~/.vim/sessions
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions

" Remember cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Enable hidden buffers
set hidden

" enable automatic title setting for terminals
set title
set titleold="Terminal"
set titlestring=%F

" Enable filetype plugins and indention
filetype on
filetype plugin on

" sets leader to ',' and localleader to "\"
let mapleader=","
let maplocalleader="\\"

" activate a permanent ruler and disable Toolbar, and add line
" highlightng as well as numbers.
" And disable the sucking pydoc preview window for the omni completion
" also highlight current line and disable the blinking cursor.
set ruler
set guioptions-=T
set completeopt-=preview
set gcr=a:blinkon0
if has("gui_running")
  set cursorline
endif
set ttyfast

" customize the wildmenu
set wildmenu
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*$py.class,*.class
set wildmode=list:full

" change working directory automatically
" disabled for mapleader that makes this explicit
"" set autochdir

" go with smartindent if there is no plugin indent file.
" but don't outdent hashes
set smartindent
inoremap # #

" quicker window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" arrow keys move visible lines
inoremap <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
inoremap <Up> <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk

" And be global by default
set gdefault

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" tab for brackets
nnoremap <tab> %
vnoremap <tab> %

" split edit vimrc
nnoremap <leader>ev <C-w><C-s><C-l>:e $MYVIMRC<CR>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Ack on <leader>a
nnoremap <leader>a :Ack

" <leader>v selects the just pasted text
nnoremap <leader>v V`]

" NERDtree on <leader>t
nnoremap <leader>t :NERDTree<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']

" Scratch
nmap <leader><tab> :Sscratch<CR><C-W>x<C-J>

" Quit window on <leader>q
nnoremap <leader>q :q<CR>

" Copy to Lodgeit on ^d
nnoremap <leader>p :Lodgeit<CR>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Easy switching
nnoremap <leader>Th :set ft=htmljinja<CR>
nnoremap <leader>Tp :set ft=python<CR>
nnoremap <leader>Tj :set ft=javascript<CR>
nnoremap <leader>Tr :set ft=rst<CR>

" Command-T support
nnoremap <leader>o :CommandT<CR>

" toggle between number and relative number on ,l
nnoremap <leader>l :call ToggleRelativeAbsoluteNumber()<CR>
function! ToggleRelativeAbsoluteNumber()
  if &number
    set relativenumber
  else
    set number
  endif
endfunction

" Make the command line two lines high and change the statusline display to
" something that looks useful.
set cmdheight=2
set laststatus=2
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}
set showcmd
set number

" Tab Settings
set smarttab
set tabstop=8

" GUI Tab settings
function! GuiTabLabel()
  let label = ''
  let buflist = tabpagebuflist(v:lnum)
  if exists('t:title')
    let label .= t:title . ' '
  endif
  let label .= '[' . bufname(buflist[tabpagewinnr(v:lnum) - 1]) . ']'
  for bufnr in buflist
    if getbufvar(bufnr, '&modified')
      let label .= '+'
      break
    endif
  endfor
  return label
endfunction
set guitablabel=%{GuiTabLabel()}

" utf-8 default encoding
set enc=utf-8

" prefer unix over windows over os9 formats
set fileformats=unix,dos,mac

" don't bell or blink
set noerrorbells
set vb t_vb=

" keep some more lines for scope
set scrolloff=5

" hide some files and remove stupid help
let g:netrw_list_hide='^\.,.\(pyc\|pyo\|o\)$'
map <leader>b :Explore!<CR>

" Split management
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>W <C-w>s
nnoremap <leader>s :new<CR>

" ; is an alias for :
nnoremap ; :

" Thank you vi
nnoremap Y y$

" When I'm working on a thinkpad
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" sudo write this
cmap W! w !sudo tee % >/dev/null

" Better Search
set hlsearch
set incsearch

" map :BufClose to :bq and configure it to open a file browser on close
let g:BufClose_AltBuffer = '.'
cnoreabbr <expr> bq 'BufClose' 

" Disable the colorcolumn when switching modes.  Make sure this is the
" first autocmd for the filetype here
autocmd FileType * setlocal colorcolumn=0

autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" ruby support
" ------------
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=79

" go support
" ----------
autocmd BufNewFile,BufRead *.go setlocal ft=go
autocmd FileType go setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" php support
" -----------
autocmd FileType php setlocal shiftwidth=4 tabstop=8 softtabstop=4 expandtab

" template language support (SGML / XML too)
" ------------------------------------------
" and disable taht stupid html rendering (like making stuff bold etc)

fun! s:SelectHTML()
let n = 1
while n < 50 && n < line("$")
  " check for jinja
  if getline(n) =~ '{%\s*\(extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
    set ft=htmljinja
    return
  endif
  " check for mako
    if getline(n) =~ '<%\(def\|inherit\)'
      set ft=mako
      return
    endif
    " check for genshi
    if getline(n) =~ 'xmlns:py\|py:\(match\|for\|if\|def\|strip\|xmlns\)'
      set ft=genshi
      return
    endif
    let n = n + 1
  endwhile
  " go with html
  set ft=html
endfun

autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd bufnewfile,bufread *.rhtml setlocal ft=eruby
autocmd BufNewFile,BufRead *.mako setlocal ft=mako
autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python
autocmd BufNewFile,BufRead *.html,*.htm  call s:SelectHTML()
let html_no_rendering=1

let g:closetag_default_xml=1
let g:sparkupNextMapping='<c-l>'
autocmd FileType html,htmldjango,htmljinja,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako source ~/.vim/scripts/closetag.vim

" GLSL
" ----
autocmd bufnewfile,bufread *.frag,*.fragment,*.vert,*.vertex,*.shader,*.glsl setlocal ft=glsl
autocmd FileType glsl setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" Verilog
" -------
autocmd FileType verilog setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" CSS
" ---
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" Java
" ----
autocmd FileType java setlocal shiftwidth=2 tabstop=8 softtabstop=2 expandtab

" rst
" ---
autocmd BufNewFile,BufRead *.txt setlocal ft=rst
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
\ formatoptions+=nqt textwidth=74

" C#
autocmd FileType cs setlocal tabstop=8 softtabstop=4 shiftwidth=4 expandtab

" C/Obj-C/C++
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab colorcolumn=79
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab colorcolumn=79
autocmd FileType objc setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab colorcolumn=79
let c_no_curly_error=1

" Octave/Matlab
autocmd FileType matlab setlocal tabstop=8 softtabstop=2 shiftwidth=2 expandtab colorcolumn=79

" vim
" ---
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" Javascript
" ----------
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=79
autocmd BufNewFile,BufRead *.json setlocal ft=javascript
let javascript_enable_domhtmlcss=1

" D
" -
autocmd FileType d setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" cmake support
" -------------
autocmd BufNewFile,BufRead CMakeLists.txt setlocal ft=cmake

