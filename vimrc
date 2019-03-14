"{{{

call plug#begin('~/.local/share/nvim/plugged')

"A code-completion engine for Vim
Plug 'Valloric/YouCompleteMe'
"syntax checking
Plug 'w0rp/ale'
"manages tag files
Plug 'ludovicchabant/vim-gutentags'
"language pack
"Plug 'sheerun/vim-polyglot'

"snippet solution
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"autopair plugin
Plug 'tmsvg/pear-tree'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

"tree explorer
Plug 'scrooloose/nerdtree'
"displays tags ordered by scope
Plug 'majutsushi/tagbar'
"status/tabline
Plug 'bling/vim-airline'

" color theme.
Plug 'morhetz/gruvbox'

"Personal wiki
Plug 'vimwiki/vimwiki'
"distraction-free writing
Plug 'junegunn/goyo.vim'
" latex
Plug 'lervag/vimtex'

"visual display of indent levels
Plug 'nathanaelkane/vim-indent-guides'
"text alignment
Plug 'godlygeek/tabular'
"access cheat.sh sheets
Plug 'dbeniamine/cheat.sh-vim'
"color code highlight
Plug 'chrisbra/Colorizer'
"comment helper
Plug 'scrooloose/nerdcommenter'
"folding ledger files
Plug 'ledger/vim-ledger'
"reporen files at your last edit position
Plug 'farmergreg/vim-lastplace'
"toggle, display and navigate marks
Plug 'kshenoy/vim-signature'
"git diff in the sign column
Plug 'airblade/vim-gitgutter'

Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-subversive'
Plug 'svermeulen/vim-yoink'

"enable repeating supported plugin maps with '.'
Plug 'tpope/vim-repeat'
"quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
"pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'
"git wrapper
Plug 'tpope/vim-fugitive'
"increment dates, times & more
Plug 'tpope/vim-speeddating'
"search, substitute and abbreviate
Plug 'tpope/vim-abolish'
"helpers for unix
Plug 'tpope/vim-eunuch'
"unicode character metadata
Plug 'tpope/vim-characterize'

"fancy start screen
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons' " asks to be placed last, sure

call plug#end()            " required

"}}}

"{{{Auto Commands

" Automatically cd into the directory that the file is in
autocmd BufEnter * silent! lcd %:p:h

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

set grepprg=grep\ -nH\ $* " DONT KNOW WHAT THIS DOES

" Tab stuff
set autoindent
set expandtab " Use appropriate number of spaces to insert a <Tab>
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=8

" Visual aid to deter from typing past column 110
"set colorcolumn=110

" Use english for spellchecking, but don't spellcheck by default
set spell spelllang=en_us
set nospell

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*.class

set encoding=utf-8
set scrolloff=4 " Keep n lines above/below cursor
set mouse=c
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

" persistent undo
set undodir=~/.vim/undodir
set undofile

" lower case searches ignore case, upper case searches do not
set ignorecase
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" https://stackoverflow.com/a/3445040/
" switch case labels
set cinoptions=l1

" }}}

"{{{Look and Feel

" Color Scheme
" gruvbox_color_column works as expected IF the order is:
" set termguicolors
" colorscheme gruvbox
" ...
" set background=dark
" Investigate later

"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

colorscheme gruvbox

let g:gruvbox_bold=1
let g:gruvbox_color_column='red'
let g:gruvbox_underline=1
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_contrast_light='hard'
let g:gruvbox_vert_split='aqua'

set background=dark    " Setting dark mode

"highlight ColorColumn guibg='DarkRed'
highlight NormalNC guibg='Black'
"highlight NormalNC guifg='Cyan'


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
"let themeindex=0
"function! RotateColorTheme()
    "let y = -1
    "while y == -1
        "let colorstring = "#gotham#"
        "let x = match( colorstring, "#", g:themeindex )
        "let y = match( colorstring, "#", x + 1 )
        "let g:themeindex = x + 1
        "if y == -1
            "let g:themeindex = 0
        "else
            "let themestring = strpart(colorstring, x + 1, y - x - 1)
            "return ":colorscheme ".themestring
        "endif
    "endwhile
"endfunction
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
"nnoremap <silent> <F8> :execute RotateColorTheme()<CR>

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

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

"Insert timestamp
nnoremap <F5> "=strftime("%F %T")<CR>P
inoremap <F5> <C-R>=strftime("%F %T")<CR>

nnoremap <Leader>t "=strftime("%F")<CR>P

"}}}

"{{{Tagbar

let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_sort = 0
let g:tagbar_width = 25

"}}}

"{{{ Airline

let g:airline_powerline_fonts = 1 " fira code

let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#ycm#enabled = 1

"}}}

"{{{ NERDTree

let g:NERDTreeWinSize=25

"}}}

"{{{ Ale

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚑'

"}}}

"{{{ YouCompleteMe

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '⚑'

map <leader>g :YcmCompleter GoToDefinition<CR>

let g:ycm_filetype_blacklist = {
      \ 'tagbar': 1,
      \ 'qf': 1,
      \ 'notes': 1,
      \ 'markdown': 1,
      \ 'unite': 1,
      \ 'text': 1,
      \ 'startify': 1,
      \ 'vimwiki': 1,
      \ 'pandoc': 1,
      \ 'infolog': 1,
      \ 'mail': 1
      \}

let g:ycm_filetype_specific_completion_to_disable = {
      \ 'gitcommit': 1,
      \ 'vim': 1
      \}

"}}}

"{{{ Ledger

let g:ledger_extra_options = '--pedantic --explicit --check-payees'
au FileType ledger noremap { ?^\d<CR>
au FileType ledger noremap } /^\d<CR>

"}}}

"{{{ UltiSnips/YouCompleteMe
set runtimepath+=~/.vim/my-snippets/
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir=$HOME.'/.vim/my-snippets/UltiSnips'

" these navigate ycm
let g:ycm_key_list_select_completion = ['<TAB>', '<C-j>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<C-k>']

" ctrl + l expands the snippet, c + j/k navigates placeholders
let g:UltiSnipsExpandTrigger = "<C-l>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsListSnippets = "<C-h>"
"}}}

"{{{ vim-startify

function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

let entry_format = "'   ['. index .']'. repeat(' ', (3 - strlen(index)))"

if exists('*WebDevIconsGetFileTypeSymbol')  " support for vim-devicons
    let entry_format .= ". WebDevIconsGetFileTypeSymbol(entry_path) .' '.  entry_path"
else
    let entry_format .= '. entry_path'
endif



let g:ascii = [
            \'             |                    ',
            \'\ \  \ / -_) |  _|  _ \  ` \   -_)',
            \' \_/\_/\___|_|\__|\___/_|_|_|\___|',
            \ '',
            \]

let g:startify_custom_header =
            \ 'map(g:ascii + startify#fortune#boxed(), "\"   \".v:val")'

"}}}

"{{{ vimwiki
let g:vimwiki_list = [{'path': '/home/yigit/Dropbox/personal_wiki',
            \ 'path_html': '~/Dropbox/personal_wiki_html',
            \ 'css_name': 'tufte.css',
            \ 'auto_export': 1}]
let g:vimwiki_global_ext = 0
map <Leader>b <Plug>VimwikiToggleListItem
"}}}

"{{{ yanks/registers and clips

set clipboard=unnamed,unnamedplus

" s for substitute
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)

let g:yoinkIncludeDeleteOperations = 1

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

nnoremap x d
xnoremap x d

nnoremap xx dd
nnoremap X D
"}}}

" {{{ vimtex
let g:vimtex_view_method = 'zathura'

" }}}
