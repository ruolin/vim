set exrc
set backspace=2 " make backspace work like most other apps"
set nu
set ruler
set nocompatible              " required
set background=dark
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" cursor more visible
" Enable CursorLine
"set cursorline
"set cursorcolumn

" tell it to use an undo file
set undofile
" set a directory to store the undo history
set undodir=/home/liur34/.vimundo/

" Default Colors for CursorLine
":hi CursorLine  ctermbg=darkred ctermfg=none
filetype off                  " required
syntax on
let python_highlight_all = 1  " Enhanced python syntax highlight
"set splitbelow
"set splitright
set incsearch				  " show matched word
set hlsearch				  " highlight search
" easy move between splits
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-J> <C-W><C-J>

" easy change window size
nnoremap <C-left> :vertical resize -5<cr>
nnoremap <C-down> :resize +5<cr>
nnoremap <C-up> :resize -5<cr>
nnoremap <C-right> :vertical resize +5<cr>

" min window size
" set winheight=30

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
" Bundle 'Valloric/YouCompleteMe'
Plugin 'hdima/python-syntax'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdtree'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'drmikehenry/vim-headerguard'
Bundle 'jiangmiao/auto-pairs.git'
" All of your Plugins must be added before the following line

" ---------------------------------
" Configure MiniBufExplorer 
"  --------------------------------
"let g:miniBufExplMapWindowNavVim = 1   
"let g:miniBufExplMapWindowNavArrows = 1   
"let g:miniBufExplMapCTabSwitchBufs = 1   
"let g:miniBufExplModSelTarget = 1  
"let g:miniBufExplMoreThanOne=0

" ---------------------------------
"  Configure Tagbar
" ---------------------------------
"let g:tagbar_width=50							"window size 
nmap <F8> :TagbarToggle<CR>
autocmd BufNewFile,BufRead *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()

" ---------------------------------
"  Configure NERDTree
" ---------------------------------
" let NERDTreeWinSize=50
map <F2> :NERDTreeToggle<CR>
" autocmd BufEnter *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx NERDTree
" Close Vim if the only window left open is NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ---------------------------------
"  Configure Vim-Headerguard
"  --------------------------------

call vundle#end()            " required
filetype plugin indent on    " required

"au FileType qf call AdjustWindowHeight(3, 10)
"   function! AdjustWindowHeight(minheight, maxheight)
"       let l = 1
"       let n_lines = 0
"       let w_width = winwidth(0)
"       while l <= line('$')
"           " number to float for division
"           let l_len = strlen(getline(l)) + 0.0
"           let line_width = l_len/w_width
"           let n_lines += float2nr(ceil(line_width))
"           let l += 1
"       endw
"       exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
"   endfunction
   " https://gist.github.com/juanpabloaj/5845848


" Easily swap windows
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

nmap <silent> <F9> :call MarkWindowSwap()<CR>
nmap <silent> <F10> :call DoWindowSwap()<CR>
set pastetoggle=<F4> "toggle paste mode"
" remember the last cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set fileformat=unix

"auto header
au BufNewFile *.py 0r /home/liur34/.vim/python.template
au BufNewFile *.sh 0r /home/liur34/.vim/bash.template

"cmake syntax
au BufNewFile,BufRead CMakeLists.txt set filetype=cmake
set secure

autocmd bufnewfile *.cpp,*.h,*.hpp so /home/liur34/.vim/cpp.template
autocmd bufnewfile *.cpp,*.h,*.hpp exe "1," . 7 . "g/File Name :.*/s//File Name : " .expand("%")
autocmd bufnewfile *.cpp,*.h,*.hpp exe "1," . 7 . "g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
autocmd Bufwritepre,filewritepre *.cpp,*.h,*.hpp execute "normal ma"
autocmd Bufwritepre,filewritepre *.cpp,*.h,*.hpp exe "1," . 7 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
autocmd bufwritepost,filewritepost *.cpp,*.h,*.hpp execute "normal `a"
