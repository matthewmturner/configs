set nocompatible
let mapleader = "\<Space>"
" =====================================
" # PLUGINS
" =====================================
" Load Manager
call plug#begin()

" Load Plugins

" GUI Enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
" Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-test/vim-test'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/tagbar'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hrsh7th/nvim-cmp'

" Fuzzy Finder Plug 
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf' , { 'dir': '~/.fzf','do': './install --all' }
Plug 'junegunn/fzf.vim'

" Editor enhancements
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" Syntactic language support Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
Plug 'simrat39/rust-tools.nvim'
Plug 'vim-python/python-syntax'
Plug 'elzr/vim-json'

" Formatters
Plug 'psf/black', { 'branch': 'stable' }

" Optional Deps for Rust-Tools
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Theme
" Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', {'as': 'dracula'}

call plug#end()

" RipGrep
if executable('rg')
	set grepprg=rg\ --nogroup
endif

" =====================================
" # Editor Settings
" =====================================
set encoding=utf-8
set mouse=a

set showmode showcmd
set number
set relativenumber
set autoindent

" Search
set incsearch
set smartcase
set ignorecase
set hlsearch

" Permanent undo
set undodir=~/.vimdid
set undofile

set showmatch
set noshowmode

" =====================================
" # Keyboard Shortcuts 
" =====================================
" No arrow keys
noremap <up> <nop>
noremap> <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Remap ESC to home row
inoremap kj <esc>
nnoremap kj <esc>
cnoremap kj <esc> 
vnoremap kj <esc>

" Jump to start and end of line using how row keys
map H ^
map L $

" Search
noremap <leader>s :Rg 

" Clear search
nnoremap <silent> <CR> :noh<CR><CR>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" <leader><leader> toggle sbetween buffers
nnoremap <leader><leader> <c-^>

" Open new file adjacent to current file
nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>

" Center screen after jumping to line
nnoremap j jzz
nnoremap k kzz

" CHADTree Shortcut
nnoremap <leader>v <cmd>CHADopen<cr>

" Testing
nnoremap <silent> t<C-n> :TestNearest<CR>
nnoremap <silent> t<C-f> :TestFile<CR>
nnoremap <silent> t<C-s> :TestSuite<CR>
nnoremap <silent> t<C-l> :TestLast<CR>
nnoremap <silent> t<C-g> :TestVisit<CR>

" Tagbar
nmap <leader>t :TagbarToggle<CR>

"JSON format current buffer
nmap <leader>fj :%!jq .<CR>

" =====================================
" # GUI
" =====================================
let g:lightline = { 'colorscheme': 'dracula' }
let g:coq_settings = { 'auto_start': 'shut-up' }
let g:tagbar_ctags_bin = '/opt/homebrew/Cellar/universal-ctags/HEAD-0673dac/bin/ctags'
let g:python_highlight_all = 1

if has('nvim') && !empty($CONDA_PREFIX)
  let g:python3_host_prog = $CONDA_PREFIX . '/bin/python'
endif

" LSP configuration
lua << EOF
local nvim_lsp = require('lspconfig')

local configs = require('lspconfig/configs')
local util = require('lspconfig/util')
local path = util.path

-- Still need to figure this out
-- local function get_python_path(workspace)
  -- Use activated conda env.
  -- if vim.env.CONDA_PREFIX then
    -- return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  -- end

  -- Fallback to system Python.
  -- return exepath('python3') or exepath('python') or 'python'
-- end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end
require('rust-tools').setup({server = { on_attach = on_attach }})
require('coq')
nvim_lsp.pyright.setup({
  on_attach = on_attach,
  before_init = function(_, config)
    config.settings.python.pythonPath = '/Users/matth/opt/miniconda3/envs/metaversd/bin/python'
    -- config.settings.python.pythonPath = get_python_path(config.root_dir)
  end
})

EOF

"Completion
set completeopt=menuone,noinsert,noselect
" Rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
set updatetime=300

if (has("termguicolors"))
  set termguicolors
endif
" Set file update time
set updatetime=100

" Splits
set splitright
set splitbelow

" When closing terminal enter blank command so editor doesnt show
set t_te=""

" =====================================
" # Autocommands 
" =====================================
filetype on
" Rust
au Filetype rust set colorcolumn=100

" Python
autocmd BufWritePre *.py execute ':Black'

" Type hints on showing file or buf - only on nightly
" autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}

set t_Co=256

" Scheme
syntax enable
colorscheme dracula
