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

Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'voldikss/vim-floaterm'

call plug#end()


syntax enable
set termguicolors
colorscheme onedark
highlight Normal guibg=none


let mapleader=" "
let g:airline_powerline_fonts = 1


" Floating terminal settings
let g:floaterm_autoclose=2
let g:floaterm_title='Terminal'
nnoremap <silent> <leader>t :FloatermToggle<CR>
tnoremap <silent> <leader>t <C-\><C-n>:FloatermToggle<CR>


" LSP Config
" pyright language server is good enough
" install it with `npm i -g pyright`
" gopls language server for go lang
" install it with `GO111MODULE=on go get golang.org/x/tools/gopls@latest`
" find where gopls installed and export it in path
lua << EOF
    -- on_attach is for autocompletion
    require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}
    require'lspconfig'.gopls.setup{on_attach=require'completion'.on_attach}
EOF


" Autocompletion settings
" Use completion-nvim in every buffer even if LSP is not enabled
" It's okay to setup completion without LSP. It will simply use
" another completion source instead (Ex: Snippets)
autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> as trigger keys to enable or disable popup menu
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Tree sitter settings
" ALl modules are disabled by default and need to be
" activated explicitly
lua <<EOF
    require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = {
            enable = true,              
            disable = {}, 
        },
    }
EOF


" Telescope Settings
" find files telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


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

