" TODO: Migrate entire script into lua
"
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
"Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/nvim-compe'

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
colorscheme gruvbox
highlight Normal guibg=none


let mapleader=" "
let g:airline_powerline_fonts = 1


" Floating terminal settings
let g:floaterm_autoclose=2
let g:floaterm_title='Terminal'
nnoremap <silent> <leader>t :FloatermToggle<CR>
tnoremap <silent> <leader>t <C-\><C-n>:FloatermToggle<CR>


" Type :Rc to edit init.vim
command Rc :e $HOME/.config/nvim/init.vim

" Window resizing made easy
" nnoremap <silent> <leader>i :vertical resize +2<CR>
" nnoremap <silent> <leader>o :vertical resize -2<CR>
" nnoremap <silent> <leader>= :resize +2<CR>
" nnoremap <silent> <leader>- :resize -2<CR>

" Autocompletion settings
" Tab S-Tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Config
lua << EOF
require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = true;
    };
}
EOF

" Mappings
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })


" LSP Config
" pyright language server is good enough
" install it with `npm i -g pyright`
" gopls language server for go lang
" install it with `GO111MODULE=on go get golang.org/x/tools/gopls@latest`
" find where gopls installed and export it in path
lua << EOF
    require'lspconfig'.pyright.setup{}
    require'lspconfig'.gopls.setup{}
EOF

" LSP mappings
nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>k :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>wa :lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <leader>wr :lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <leader>wl :lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap K  :lua vim.lsp.buf.hover()<CR>
nnoremap rn :lua vim.lsp.buf.rename()<CR>
nnoremap [d :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]d :lua vim.lsp.diagnostic.goto_next()<CR>

" Completion documentation highlight
highlight link CompeDocumentation NormalFloat


"" Autocompletion settings
"" Use completion-nvim in every buffer even if LSP is not enabled
"" It's okay to setup completion without LSP. It will simply use
"" another completion source instead (Ex: Snippets)
"autocmd BufEnter * lua require'completion'.on_attach()
"
"" Use <Tab> and <S-Tab> to navigate through popup menu
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
"" Use <Tab> and <S-Tab> as trigger keys to enable or disable popup menu
"imap <tab> <Plug>(completion_smart_tab)
"imap <s-tab> <Plug>(completion_smart_s_tab)


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
