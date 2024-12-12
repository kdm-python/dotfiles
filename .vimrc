" Vim Configuration File

" Enable line numbers
set number

" Auto close parentheses
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

" Filetype-specific indentation
augroup FileTypeIndent
    autocmd!
    autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab
    autocmd FileType javascript,typescript,html,css setlocal shiftwidth=2 tabstop=2 expandtab
    autocmd FileType c setlocal shiftwidth=4 tabstop=4 expandtab
    autocmd FileType go setlocal shiftwidth=4 tabstop=4 noexpandtab
augroup END

" File browser configuration (using built-in netrw)
let g:netrw_banner = 0        " Hide banner
let g:netrw_liststyle = 3     " Tree view
let g:netrw_browse_split = 4  " Open in previous window
let g:netrw_altv = 1          " Open splits to the right
let g:netrw_winsize = 25      " Width of file browser

" Toggle file browser
function! ToggleNetrw()
    if exists("t:netrw_bufnr")
        silent exe "bdelete " . t:netrw_bufnr
        unlet t:netrw_bufnr
    else
        silent Lexplore
        let t:netrw_bufnr = bufnr("%")
    endif
endfunction

" Mapping to toggle file browser
map <leader>n :call ToggleNetrw()<CR>

" Commented out additional useful configurations:

" " Syntax highlighting
" syntax enable

" " Smart indentation
" set smartindent

" " Highlight search results
" set hlsearch

" " Incremental search
" set incsearch

" " Case-insensitive searching
" set ignorecase
" set smartcase

" " Show matching brackets
" set showmatch

" " Enable mouse support
" set mouse=a

" " Persistent undo
" set undofile
" set undodir=~/.vim/undodir

" " Status line
" set statusline=%f%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]
" set laststatus=2

" " Color scheme (uncomment and adjust as needed)
" " colorscheme desert

" " Auto-reload files changed outside of Vim
" set autoread

" " Spell checking (toggle with ,ss)
" map <leader>ss :setlocal spell!<cr>

" " Disable swap files
" set noswapfile
" set nobackup
" set nowb
