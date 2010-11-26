set nocompatible
set enc=utf-8
filetype off


" ----------------------------------------------------------------------------
" Easier leader, default is \
" ----------------------------------------------------------------------------
let mapleader=","


" ----------------------------------------------------------------------------
" Pathogen.vim
" ----------------------------------------------------------------------------
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()


" ----------------------------------------------------------------------------
" General
" ----------------------------------------------------------------------------
set ffs=unix,dos,mac
set nowrap
set complete+=k " ctrl+n ctrl+k dict shortcut in insert
set history=1000
set backspace=indent,eol,start


" ----------------------------------------------------------------------------
" Clear currently highlighted terms
" ----------------------------------------------------------------------------
nmap <silent> <leader>n :set invhls<CR>:set hls?<CR>


" ----------------------------------------------------------------------------
" Better movement with wrap enabled
" ----------------------------------------------------------------------------
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk


" ----------------------------------------------------------------------------
" Save me from emacs-pinky
" ----------------------------------------------------------------------------
nnoremap ; :


" ----------------------------------------------------------------------------
" Indenting
" ----------------------------------------------------------------------------
set autoindent
set smartindent


" ----------------------------------------------------------------------------
" Easier Escaping
" ----------------------------------------------------------------------------
imap jj <Esc>


" ----------------------------------------------------------------------------
" Searching
" ----------------------------------------------------------------------------
set hlsearch
set incsearch
set ignorecase
set smartcase


" ----------------------------------------------------------------------------
" Colors
" ----------------------------------------------------------------------------
syntax on
if has("gui_running")
    colorscheme railscasts
else
    colorscheme desert
endif


" ----------------------------------------------------------------------------
" Easily edit/reload your vimrc
" ----------------------------------------------------------------------------
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>


" ----------------------------------------------------------------------------
" Highlight Tabs and Whitespace
" ----------------------------------------------------------------------------
set list listchars=tab:>\ ,eol:¬
nmap <leader>l :set list!<CR>


" ----------------------------------------------------------------------------
" Backups, we don't want them
" ----------------------------------------------------------------------------
set nobackup
set nowritebackup
set noswapfile


" ----------------------------------------------------------------------------
" Allow hiding buffers with changes
" ----------------------------------------------------------------------------
set hidden


" ----------------------------------------------------------------------------
" UI
" ----------------------------------------------------------------------------
set ruler
set number
set wildmenu
set wildmode=list:longest,full
set wildignore=*.swp,*.bak,*.pyc
set nostartofline
set guioptions-=T
set splitright
set splitbelow
set cmdheight=2
set showmode
set showcmd
set fillchars=""
set scrolloff=8
set modifiable


" ----------------------------------------------------------------------------
" Font
" ----------------------------------------------------------------------------
if has('win32') || has('win64')
    set guifont=Consolas:h13:cANSI
elseif has('unix')
    set guifont=Liberation\ Mono\ 13
endif


" ----------------------------------------------------------------------------
" CD to the current files directory
" ----------------------------------------------------------------------------
nmap <silent> ,cd :lcd %:h<CR>
nmap <silent> ,md :!mkdir -p %:p:h<CR>


" ----------------------------------------------------------------------------
" Allow the cursor to go to invalid places
" ----------------------------------------------------------------------------
set virtualedit=all


" ----------------------------------------------------------------------------
" Timeout length in miliseconds while waiting for user input
" ----------------------------------------------------------------------------
set timeoutlen=1000


" ----------------------------------------------------------------------------
" Don't update display while executing macros
" ----------------------------------------------------------------------------
set lazyredraw


" ----------------------------------------------------------------------------
" Folding
" ----------------------------------------------------------------------------
"set foldmethod=indent
"set foldnestmax=3
"set nofoldenable


" ----------------------------------------------------------------------------
" Tabs and Spaces
" ----------------------------------------------------------------------------
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

if has("autocmd")
    filetype plugin indent on

    " autocmd bufwritepost .vimrc source $MYVIMRC

    " required
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType sass setlocal ts=2 sts=2 sw=2 expandtab
    " arbitrary
    autocmd FileType ruby setlocal foldmethod=syntax ts=2 sts=2 sw=2 expandtab
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType cf setlocal expandtab ft+=.html dictionary+=$VIM/CF.dict
endif


" ----------------------------------------------------------------------------
" NerdTree
" ----------------------------------------------------------------------------
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>ff :NERDTreeFind<CR>
nmap <leader>fb :NERDTreeFromBookmark 
" let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeShowBookmarks=1


" ----------------------------------------------------------------------------
" Ease horizontal scrolling
" ----------------------------------------------------------------------------
nmap <silent> <C-o> 10zl
nmap <silent> <C-i> 10zh


" ----------------------------------------------------------------------------
" Quick VCS diffs and blames
" ----------------------------------------------------------------------------
nmap <silent> <Leader>sb :VCSBlame<CR>
nmap <silent> <Leader>sd :VCSDiff<CR>


" -----------------------------------------------------------------------------
" Surround Plugin
" -----------------------------------------------------------------------------
" let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1 %}\r{% endblock %}"
" let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1 %}\r{% endif %}"
" let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1 %}\r{% endwith %}"
" let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1 %}\r{% endcomment %}"
" let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1 %}\r{% endfor %}"
let g:surround_{char2nr("o")} = "<cfoutput>\1</cfoutput>"


" -----------------------------------------------------------------------------
" Makes moving between split windows easier
" -----------------------------------------------------------------------------
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <A-h> <C-w>h<C-w>_
map <A-j> <C-w>j<C-w>_
map <A-k> <C-w>k<C-w>_
map <A-l> <C-w>l<C-w>_
set wmh=0


" -----------------------------------------------------------------------------
" Strip Whitespace
" -----------------------------------------------------------------------------
nnoremap <silent> <F5> :call StripTrailingWhitespace()<CR>

command! Strip call StripTrailingWhitespace()
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    "" Do the business:
    %s/\s\+$//e
    "" Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction


" -----------------------------------------------------------------------------
" Set tab settings
" -----------------------------------------------------------------------------
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    end
  finally
    echohl None
  endtry
endfunction


" -----------------------------------------------------------------------------
" Allow you to save a write protected file
" -----------------------------------------------------------------------------
cmap w!! w !sudo tee % >/dev/null


" -----------------------------------------------------------------------------
" Easier tab navigation
" -----------------------------------------------------------------------------
map <C-S-]> gt
map <C-S-[> gT
map <C-1> 1gt
map <C-2> 2gt
map <C-3> 3gt
map <C-4> 4gt
map <C-5> 5gt
map <C-6> 6gt
map <C-7> 7gt
map <C-8> 8gt
map <C-9> 9gt
map <C-0> :tablast<CR>


" -----------------------------------------------------------------------------
" Keep out of Insert Mode!
" -----------------------------------------------------------------------------
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>


" -----------------------------------------------------------------------------
" Easier indentation in visual mode
" -----------------------------------------------------------------------------
vmap <S-TAB> <gv
vmap <TAB> >gv


" -----------------------------------------------------------------------------
" Open URL in browser
" -----------------------------------------------------------------------------
function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!firefox ".line
endfunction


" -----------------------------------------------------------------------------
" Bufexplorer
" -----------------------------------------------------------------------------
nnoremap <leader>b :BufExplorer<cr>


" -----------------------------------------------------------------------------
" CommandT TextMate style finder
" -----------------------------------------------------------------------------
nnoremap <leader>t :CommandT<CR>
let g:CommandTMatchWindowAtTop=0
let g:CommandTMaxHeight=5 " doesn't seem to work?


" -----------------------------------------------------------------------------
" easy paragraph formatting
" -----------------------------------------------------------------------------
vmap Q gq
nmap Q gqap


" -----------------------------------------------------------------------------
" Ack
" -----------------------------------------------------------------------------
noremap <leader>a :Ack<space>


" -----------------------------------------------------------------------------
" Easier reading
" -----------------------------------------------------------------------------
" set linespace=4


" -----------------------------------------------------------------------------
" Status Line
" -----------------------------------------------------------------------------
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]
set laststatus=2


" -----------------------------------------------------------------------------
" Org-mode style line movement
" -----------------------------------------------------------------------------
nmap <S-Up> [e
nmap <S-Down> ]e
vmap <S-Up> [egv
vmap <S-Down> ]egv
