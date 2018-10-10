"{{{Vundle Config

syntax on
filetype plugin indent on

set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'

Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'

Plugin 'morhetz/gruvbox' " best theme

Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'dbeniamine/cheat.sh-vim'
Plugin 'ap/vim-css-color'

Plugin 'ledger/vim-ledger'
Plugin 'neovimhaskell/haskell-vim'

call vundle#end()            " required
"filetype plugin indent on    " required

"}}}

"{{{Auto Commands

" Automatically cd into the directory that the file is in
"autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
    au!
    autocmd BufReadPost *
                \ if expand("<afile>:p:h") !=? $TEMP |
                \   if line("'\"") > 1 && line("'\"") <= line("$") |
                \     let JumpCursorOnEdit_foo = line("'\"") |
                \     let b:doopenfold = 1 |
                \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
                \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
                \        let b:doopenfold = 2 |
                \     endif |
                \     exe JumpCursorOnEdit_foo |
                \   endif |
                \ endif
    " Need to postpone using "zv" until after reading the modelines.
    autocmd BufWinEnter *
                \ if exists("b:doopenfold") |
                \   exe "normal zv" |
                \   if(b:doopenfold > 1) |
                \       exe  "+".1 |
                \   endif |
                \   unlet b:doopenfold |
                \ endif
augroup END

"}}}

"{{{Misc Settings

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" necesary  for lots of cool vim things
set nocompatible

" See below
" https://stackoverflow.com/a/33380495
if !exists("g:syntax_on")
    syntax enable
endif
"syntax enable

set grepprg=grep\ -nH\ $* " DONT KNOW WHAT THIS DOES

" Tab stuff
set autoindent
set expandtab " Use appropriate number of spaces to insert a <Tab>
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=8

" Visual aid to deter from typing past column 110.
set colorcolumn=110
" Colors don't work atm so Red whatever is doesn't work
highlight ColorColumn ctermfg = Red

" Use english for spellchecking, but don't spellcheck by default
set spell spelllang=en_us
set nospell

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

set encoding=utf-8
set scrolloff=4 " Keep n lines above/below cursor
set mouse=c " enable mouse support in console
set backspace=2 " make backspace work like most other programs
set number " line numbers
set history=1000 " number of lines that are remembered
set showcmd " this shows what you are typing as a command.  I love this!
set foldmethod=marker " folding stuffs
set incsearch " search as you type (before <CR>)
set hlsearch " highlight things that we find with the search
set nohidden " when i close a tab, remove the buffer
set title " set terminal title
set showmatch " jump to the matching bracket briefly, REMOVE AFTER TESTING
set linebreak " wrap using 'breakat' character
set splitbelow " new split panes will split to below and right
set splitright

" lower case searches ignore case, upper case searches do not
set ignorecase
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" Set off the other paren
"highlight MatchParen ctermbg=4 " doesn't look like this is needed anymore?

" }}}

"{{{Look and Feel

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

" Favorite NEW Color Scheme
colorscheme gruvbox
set background=dark    " Setting dark mode

" }}}

"{{{ Functions

"{{{ Open URL in browser

function! Browser ()
    let line = getline (".")
    let line = matchstr (line, "http[^   ]*")
    exec "!firefox ".line
endfunction

"}}}

"{{{Theme Rotating
let themeindex=0
function! RotateColorTheme()
    let y = -1
    while y == -1
        let colorstring = "#gruvbox#artesanal#ron#elflord#evening#koehler#murphy#pablo#desert#torte#"
        let x = match( colorstring, "#", g:themeindex )
        let y = match( colorstring, "#", x + 1 )
        let g:themeindex = x + 1
        if y == -1
            let g:themeindex = 0
        else
            let themestring = strpart(colorstring, x + 1, y - x - 1)
            return ":colorscheme ".themestring
        endif
    endwhile
endfunction
" }}}

"}}}

"{{{ Mappings

" Open Url on this line with the browser \w
map <Leader>w :call Browser ()<CR>

" Open the TagBar Plugin <F3>
nnoremap <silent> <F3> :TagbarToggle<CR>

" Open NERDTree <F4>
nnoremap <silent> <F4> :NERDTreeToggle<CR>

" Next Tab
nnoremap <silent> <C-Right> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" Rotate Color Scheme <F8>
nnoremap <silent> <F8> :execute RotateColorTheme()<CR>

" FixIt from YCM
map <F9> :YcmCompleter FixIt<CR>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.config/nvim/init.vim<CR>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

"Insert timestamp
nnoremap <F5> "=strftime("%x %X")<CR>P
inoremap <F5> <C-R>=strftime("%x %X")<CR>

nnoremap <Leader>t "=strftime("%F %T")<CR>P

"}}}

"{{{Tagbar Configuration
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_sort = 0
let g:tagbar_width = 25
"}}}

"{{{ Airline Configuration
let g:airline_powerline_fonts = 1 " fira code

let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#ycm#enabled = 1

"let g:airline_skip_empty_sections = 1

"}}}

"{{{ NERDTree Configuration
let g:NERDTreeWinSize=25
"}}}

"{{{ Syntastic Configuration

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 4
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': []
\}

nnoremap <Leader>s :SyntasticCheck<CR>
nnoremap <Leader>r :SyntasticReset<CR>
nnoremap <Leader>i :SyntasticInfo<CR>
noremap <Leader>m :SyntasticToggleMode<CR>

let g:syntastic_perl_checkers = ['perl', 'podchecker']
let g:syntastic_enable_perl_checker = 1

"}}}

"{{{ Ledger/YouCompleteMe
if exists('g:ycm_filetype_blacklist')
    call extend(g:ycm_filetype_blacklist, { 'ledger': 1 })
endif
let g:ledger_extra_options = '--pedantic --explicit --check-payees'
au FileType ledger noremap { ?^\d<CR>
au FileType ledger noremap } /^\d<CR>
"}}}
