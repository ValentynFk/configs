colorscheme dogrun
set t_ut=

"""" START Vundle Configuration 
filetype off " Disable file type for vundle
set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

Plugin 'benmills/vimux'
Plugin 'dylnmc/novum.vim'
Plugin 'zefei/simple-dark'
Plugin 'rust-lang/rust.vim'
Plugin 'pgavlin/pulumi.vim'
Plugin 'wadackel/vim-dogrun'
Plugin 'racer-rust/vim-racer'
Plugin 'arzg/vim-colors-xcode'
Plugin 'vim-scripts/Conque-GDB'
Plugin 'bluz71/vim-nightfly-guicolors'

" Utility
Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on
"""" END Vundle Configuration 

"""""""""""""""""""""""""""""""""""""
" Configuration Section
"""""""""""""""""""""""""""""""""""""
set nowrap
set number " show linenumbers
set cursorline " enable highlighting of the current line
set nocompatible " disable vi compatibility
set noerrorbells " disable line wrapping and error sounds
set textwidth=120 " wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
setlocal linebreak
setlocal nolist
setlocal display+=lastline

" set Proper Tabs
set tabstop=4 softtabstop=4     " tab width is 4 spaces
set shiftwidth=4                " indent also with 4 spaces
set expandtab                   " expand tabs to spaces
set backspace=indent,eol,start  " backspace through everything in insert mode

" searching stuff
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" display the status line
set laststatus=2

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" set folding settings
set foldlevel=20
set foldlevelstart=20
set foldmethod=syntax
set foldenable

" use indentation of previous line & intelligent indentation for C
set autoindent
set smartindent

" set line width limit hint
set colorcolumn=85
highlight ColorColumn ctermbg=234 guibg=#d7af5f

"set tags=./tags;

" devicons configuration 
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''

" GDB configuration
let g:ConqueGdb_Disable = 0
let g:ConqueGdb_GdbExe = 'gdb'
let g:ConqueTerm_Color = 2         " 1 - strip color after 200 lines, 2 - always with color
let g:ConqueGdb_Leader = "co"
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly

" Theme and Styling 
syntax on
set t_Co=256

highlight Search ctermfg=58 ctermbg=222
highlight IncSearch ctermfg=58 ctermbg=222
highlight Visual ctermbg=237

if (has("termguicolors"))
  set termguicolors
endif
let base16colorspace=256  " access colors present in 256 colorspace

let g:spacegray_underline_search = 1
let g:spacegray_italicize_comments = 1

" Vim-Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 
let g:airline_theme='hybrid'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 

"""""""""""""""""""""""""""""""""""""
" Mappings section
"""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>

" disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

" shortcuts
let mapleader = " "
nnoremap <Leader>w :w<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>f za

" moving lines up/down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi

noremap j gj
noremap k gk

function! AttachRustTags()
    if !system('test -f r-tags && echo 1')
        let dummy = system("ctags -R --languages=rust -f r-tags 2>/dev/null") | redraw!
    endif
    set tags+=r-tags
endfunction

function! AttachCscope()
    if !system("test -f cscope.out && echo 1")
        let dummy = system("cscope -Rbq 2>/dev/null") | redraw!
    endif
    cscope add cscope.out
endfunction

function! AttachCTags()
    if !system('test -f c-tags && echo 1')
        let dummy = system("ctags -R -f c-tags 2>/dev/null") | redraw!
    endif
    set tags+=c-tags
endfunction

function! AttachTags()
    let ext = expand('%:e')
    if ext == 'rs'
        call AttachRustTags()
        " ctags
        nnoremap <leader>g :tjump <C-r><C-w><Cr>
        nnoremap <leader>s :tselect <C-r><C-w><Cr>
        "nnoremap <leader>g :ptjump <C-r><C-w><Cr>
        "nnoremap <leader>s :ptselect <C-r><C-w><Cr>
    else
        call AttachCscope()
        call AttachCTags()
        " cscope
        nnoremap <leader>g :cscope find g <C-r><C-w><Cr>
        nnoremap <leader>c :cscope find c <C-r><C-w><Cr>
        nnoremap <leader>s :cscope find s <C-r><C-w><Cr>
        " ctags
        "nnoremap <leader>g :tjump <C-r><C-w><Cr>
        "nnoremap <leader>s :tselect <C-r><C-w><Cr>
        "nnoremap <leader><leader>g :ptjump <C-r><C-w><Cr>
        "nnoremap <leader><leader>s :ptselect <C-r><C-w><Cr>
    endif
    echo 'done!'
endfunction

nnoremap <leader>r :call AttachTags()<Cr> 
nnoremap <leader>m :call VimuxRunCommand("make")<CR>

set tw=0 wrap linebreak

