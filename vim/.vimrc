set nocompatible
syntax on
filetype off

" For plugins to load correctly
filetype plugin indent on

set pythonthreehome=~/AppData/Local/Programs/Python/Python38
set pythonthreedll=~/AppData/Local/Programs/Python/Python38/python38.dll

set completeopt=menu,longest

let g:clang_library_path='C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\Llvm\x64\bin'
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=1
let g:clang_snippets=1
let g:clang_snippets_engine='ultisnips'
let g:clang_trailing_placeholder=1
let g:clang_close_preview=1
let g:clang_complete_patterns=1
let g:clang_complete_macros=1
"let g:clang_library_path=/user/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/Llvm/x64/bin/libclang.dll
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'Clang_complete'
Plugin 'SirVer/ultisnips'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"

set swapfile
set dir=~/.vim/tmp

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

" TODO: Pick a leader key
 let mapleader = ","

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set nowrap
set textwidth=0
" set textwidth=79
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=2
set expandtab
set noshiftround
set smarttab

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Move between tabs
nnoremap <S-L> gt
nnoremap <S-H> gT

" quickfix next/previous
map <C-j> :cn<CR>
map <C-k> :cp<CR>

" clang_complete using control-space
inoremap <C-Space> <C-X><C-U>
nnoremap <leader>c :call g:ClangUpdateQuickFix()<CR>
nnoremap <leader>fs : call g:PrintAllStructMembers()<CR>


" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts
map <leader>ss :e ~/.vim/UltiSnips<CR>
map <leader>sr :call UltiSnips#RefreshSnippets()<CR>
map <leader>se :tabe ~/.vimrc<CR>
map <leader>sv :source ~/.vimrc<CR>

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:¿\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
colorscheme solarized

" https://vim.fandom.com/wiki/Regex-based_text_alignment
command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')
vnoremap <silent> <Leader>a :Align<CR>
function! AlignSection(regex) range
  let extra = 1
  let sep = empty(a:regex) ? '=' : a:regex
  let maxpos = 0
  let section = getline(a:firstline, a:lastline)
  for line in section
    let pos = match(line, ' *'.sep)
    if maxpos < pos
      let maxpos = pos
    endif
  endfor
  call map(section, 'AlignLine(v:val, sep, maxpos, extra)')
  call setline(a:firstline, section)
endfunction

function! AlignLine(line, sep, maxpos, extra)
  let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
  if empty(m)
    return a:line
  endif
  let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
  return m[1] . spaces . m[2]
endfunction

nmap <leader>=  :call Align()<CR>
