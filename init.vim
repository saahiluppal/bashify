set exrc

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set relativenumber
set number

set nohlsearch
set incsearch
set hidden

" Better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing extra message when using completion
set shortmess+=c

set nowrap
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile

set ignorecase
set smartcase
set updatetime=250
set scrolloff=8

call plug#begin('~/.config/nvim/plugged')

" Themes
Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'joshdick/onedark.vim'
Plug 'tomasiser/vim-code-dark'

" LSP and autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Bottomline
Plug 'itchyny/lightline.vim'

" Terminal
Plug 'voldikss/vim-floaterm'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

syntax enable
set termguicolors
colorscheme gruvbox
highlight Normal guibg=none

let mapleader=" "

let g:floaterm_autoclose=2
let g:floaterm_title='Terminal'
nnoremap <silent> <leader>t :FloatermToggle<CR>
tnoremap <silent> <leader>t <C-\><C-n>:FloatermToggle<CR>

" find files telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


lua << EOF
require'lspconfig'.gopls.setup{}
require'lspconfig'.pyright.setup{}
EOF

" Autocompletion settings
lua require'lspconfig'.gopls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}

" Use <TAB> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" manually trigger completion
" imap <silent> <c-p> <Plug>(completion_trigger)
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)



" Window splitting and movement
" https://breuer.dev/blog/top-neovim-plugins.html
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>
