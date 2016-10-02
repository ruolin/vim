set backspace=2 " make backspace work like most other apps"
set exrc
set secure
set nocompatible              " required
set background=dark
filetype off                  " required
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
Bundle 'Valloric/YouCompleteMe'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-unimpaired'
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
nmap <Leader>tb :TagbarToggle<CR>		
"let g:tagbar_width=50							"window size 
map <F8> :Tagbar<CR>
autocmd BufEnter *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()

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
