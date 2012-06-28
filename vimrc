"=== vundle ===================================================================

set nocompatible                " drop vi compatibility
filetype off                    " required for vundle

set rtp+=~/.vim/bundle/vundle/  " add vundle search path
call vundle#rc()

"=== plugins ==================================================================

Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'wincent/Command-T'
Bundle 'kien/ctrlp.vim'
"let g:ctrlp_user_command = 'find %s -type f'
"let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']
"let g:ctrlp_user_command = ['.hg/', 'hg --cwd %s locate -I .']
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git/', 'cd %s && git ls-files'],
    \ 2: ['.hg/', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }
Bundle 'scrooloose/nerdcommenter'
Bundle 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"
Bundle 'Lokaltog/vim-powerline'
Bundle 'LaTeX-Box'

"=== general ==================================================================

syntax on                       " turn syntax highlighting on
filetype indent plugin on       " required for vundle
set modeline                    " file specific options
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
set mouse=a                     " mouse gestures
set encoding=utf-8              " set internal encoding
set scrolloff=4                 " scroll offset
set visualbell                  " use visual bell
set vb t_vb=                    " disable both audible and visible bell
set t_Co=256                    " force 256 colors
set backspace=indent,eol,start  " make backspace work like most apps

"=== appearance ===============================================================

syntax enable
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

set showmatch                   " jump to matching bracket and back when
                                " inserted
set matchtime=3                 " time for showmatch
set wildmenu                    " command line completion
set wildignore=*.bak,*.pyc,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.JPG,*.PNG,*.git
set wildmode=list:full
set ruler                       " show the ruler
set laststatus=2                " always show status line.
set showcmd                     " show command in last line
set cursorline                  " hilight the current line
set number                      " use absolute line numbers
set wrap                        " wrap long lines
set nofoldenable                " do not fold code

" close popup menu automatically
autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent!
    \ pclose|endif

"=== indentation ==============================================================

set autoindent                  " copy indentation from current line to new
                                " line
set smartindent                 " indent new line after e.g. {
set tabstop=4                   " number of spaces that a tab is replaced with
set shiftwidth=4                " number of spaces to use with autoindent
set softtabstop=4               " number of spaces that a <Tab> counts for
                                " while performing editing operations
set smarttab                    " replace tabs at start of line with spaces.
set expandtab                   " use spaces instead of hard '\t' tabs

"=== searching ================================================================

set incsearch                   " show search matches as you type
set hlsearch                    " highlight search terms
set ignorecase                  " case insensitive search
set smartcase                   " if search contains mixed case, do a case
                                " sensitive search

"=== mappings =================================================================

let mapleader = ","             " use <comma> as leader

"noremap           <leader>f <Esc>:CommandT<CR>
"noremap           <leader>F <Esc>:CommandTFlush<CR>
"noremap           <leader>m <Esc>:CommandTBuffer<CR>
noremap           <leader>f <Esc>:CtrlP<CR>
noremap           <leader>m <Esc>:CtrlPBuffer<CR>

map               <leader>t  :tabnew<CR>
map               <leader>n  :tabnext<CR>
map               <leader>b  :tabprevious<CR>
map               <leader>w  :tabclose<CR>

noremap           <leader>dd :call ToggleMouse()<CR>
noremap           <leader>dc :set paste<CR>

" w!! for sudo write
cmap w!! w !sudo tee % >/dev/null
" use <F5> to remove trailing whitespaces
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

function! ToggleMouse()
    if &mouse=='a'
        set mouse=
    else
        set mouse=a
    endif
endfunction

"=== filetypes ================================================================

autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
au BufNewFile,BufRead *.jinja2 set filetype=html

"=== extra ====================================================================

" Go back to the position the cursor was on the last time this file was edited
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")|execute("normal `\"")|endif

" Command-T
let g:CommandTMaxFiles=20000
let g:CommandTMaxCachedDirectories=100

" The PC is fast enough, do syntax highlight syncing from start
autocmd BufEnter * :syntax sync fromstart
