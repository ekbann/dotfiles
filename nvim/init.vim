" Neovim configuration file optimized for text TTY terminal console (non-GUI)
"
" Not to be confused with xterm (GUI): a terminal emulator connected to a virtual
" terminal, identified by a tty file, inside which runs a shell.
"
" This config file should be saved in ~/.config/nvim/init.vim

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting

" Plugins:
"
" run PlugInstall in command mode to install the above plugins.
" run PlugUpdate when you want to update the plugins.
"

call plug#begin("~/.vim/plugged")
" Plugin Section
" Dracula — a really good theme for neovim - causes FONT/COLOR problems
"Plug 'dracula/vim'
" ultisnips — snippets engine
"   Plug 'SirVer/ultisnips'
" vim-snippets — a collection of snippets
"   Plug 'honza/vim-snippets'
" nerdtree — a file explorer for neovim(netrw comes as default for neovim)
Plug 'preservim/nerdtree'
" nerdcommenter — an easy way for commenting out lines
Plug 'preservim/nerdcommenter'
" vim-startify — a really handy start page with lots of customizations
"   Plug 'mhinz/vim-startify'
" coc — a fast code completion engine (Intellisense engine)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" itchyny/lightline - a minimalistic status line
Plug 'itchyny/lightline.vim'
" sheerun/vim-polyglot - better syntax-highlighting for filetypes in vim
Plug 'sheerun/vim-polyglot'
" tpope/vim-fugitive - Git integration
Plug 'tpope/vim-fugitive'
" jiangmiao/auto-pairs - auto-close braces and scopes
Plug 'jiangmiao/auto-pairs'
" kien/ctrlp.vim - a fuzzy file finder
Plug 'kien/ctrlp.vim'
" tmhedberg/matchit - switch to the begining and the end of a block by pressing %
Plug 'tmhedberg/matchit'
" lambdalisue/battery.vim - a statusline or tabline component for Neovim/Vim
Plug 'lambdalisue/battery.vim'
call plug#end()

set noshowmode		    " remove (--INSERT--) edit mode because already included with lightline
let g:lightline = {'colorscheme': '16color'}
set background=dark

" Open NerdTree when starting Neovim without arguments
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:NERDTreeMinimalUI = 1	" Disable the help message reminder
let g:NERDTreeDirArrows = 0	" Use normal text font arrows (right/down)
let g:NERDTreeQuitOnOpen = 1	" Automatically close NerdTree when you open a file
" Automatically delete the buffer of the file you just deleted with NerdTree
let g:NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden=1 " Show hidden files in NerdTree buffer.

" NerdTree trigger and showing hidden files.
map <C-n> :NERDTreeToggle<CR>
"
"
" alternatives:
"nnoremap <Leader>f :NERDTreeToggle<Enter>
" open NerdTree on file we're editing to perform operations on it with NERDTreeFind
"nnoremap <silent> <Leader>v :NERDTreeFind<CR>

let g:battery#update_tabline = 1    " For tabline.
"let g:battery#update_statusline = 1 " For statusline.

"Reduces the space occupied by section z
"let g:airline_section_z = "%3p%% L:%l/%L C:%c"
"let g:airline_section_z = "%p%% : \ue0a1:%l/%L: Col:%c"

"colorscheme dracula

" open new split panes to right and below
set splitright
set splitbelow

" inoremap: maps the key in insert mode
" nnoremap: maps the key in normal mode
" vnoremap: maps the key in visual mode
" <C> : represents Control key
" <A> : Alt key

" move line or visually selected block - alt+j/k
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" move split panes to left/bottom/top/right
 nnoremap <A-h> <C-W>H
 nnoremap <A-j> <C-W>J
 nnoremap <A-k> <C-W>K
 nnoremap <A-l> <C-W>L

" move between panes to left/bottom/top/right
 nnoremap <C-h> <C-w>h
 nnoremap <C-j> <C-w>j
 nnoremap <C-k> <C-w>k
 nnoremap <C-l> <C-w>l

" Press i to enter insert mode, and ii to exit insert mode.
:inoremap ii <Esc>
:inoremap jk <Esc>
:inoremap kj <Esc>
:vnoremap jk <Esc>
:vnoremap kj <Esc>

" open file in a text by placing text and gf
nnoremap gf :vert winc f<cr>
" copies filepath to clipboard by pressing yf
:nnoremap <silent> yf :let @+=expand('%:p')<CR>
" copies pwd to clipboard: command yd
:nnoremap <silent> yd :let @+=expand('%:p:h')<CR>
" Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

" use the CocInstall <package-name> command
" Here is a list of all plugins I use:
"
" coc-spell-checker: The general spell checker for neovim
" coc-prettier: A very popular code formatter
" coc-git: A git plugin to show which line is added/deleted and not committed
" coc-pyright: The main Python plugin I use
" coc-json: JSON file formatting plugin
" coc-docker: Dockerfile and docker-compose formatters
" coc-yaml: Yaml plugin for Kubernetes and terraform files
"
" do a CocUpdate once in a while to keep your plugins up-to-date.
"
" Then I set the following the shortcuts for the Coc for more ease of use:

" Code action on <leader>a
vmap <leader>a <Plug>(coc-codeaction-selected)<CR>
nmap <leader>a <Plug>(coc-codeaction-selected)<CR>

" Format action on <leader>f
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Goto definition
nmap <silent> gd <Plug>(coc-definition)
" Open definition in a split window
nmap <silent> gv :vsp<CR><Plug>(coc-definition)<C-W>L
