"=================================================================================
"general
"=================================================================================

syntax on
set ma
set mouse=a
set cursorline
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoread
set nobackup
set nowritebackup
set noswapfile
set nu 
set foldlevelstart=99
set scrolloff=7
set ignorecase
set smartcase
"use y and p with the system clipboard
set clipboard=unnamedplus

"==================================================================================
"plugins
"==================================================================================

call plug#begin('~/.config/nvim/autoload/')

"Colour scheme
Plug 'phanviet/vim-monokai-pro'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'luochen1990/rainbow'

"VSCode like stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-test/vim-test'

"Nvim motions
Plug 'phaazon/hop.nvim'

"LSP autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

"File browsing
Plug 'nvim-telescope/telescope-file-browser.nvim'

"Treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'

"Native LSP
Plug 'neovim/nvim-lspconfig'

"Buffer navigation
Plug 'nvim-lualine/lualine.nvim'

"Grammar checking because I can't english
Plug 'rhysd/vim-grammarous'

"Telescope Requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

"git
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'

"magit
Plug 'TimUntersberger/neogit'

"todo comments
Plug 'folke/todo-comments.nvim'

"devicons
Plug 'kyazdani42/nvim-web-devicons'
"fullstack dev
Plug 'pangloss/vim-javascript' "JS support
Plug 'leafgarland/typescript-vim' "TS support
Plug 'maxmellon/vim-jsx-pretty' "JS and JSX syntax
Plug 'jparise/vim-graphql' "GraphQL syntax
Plug 'mattn/emmet-vim'
Plug 'hashivim/vim-terraform'

call plug#end()

"key combos =============================================================================="

set encoding=UTF-8
set termguicolors
colorscheme monokai_pro


let mapleader = ","

let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'neovim',
  \ 'suite':   'neovim',
\}
let g:test#neovim#start_normal = 1
let g:test#javascript#jest#executable = 'yarn jest --group=-interaction'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

let test#python#runner = 'pytest'
let test#python#pytest#executable = 'DJANGO_SETTTINGS_MODULE=learning.test_settings bin/pytest --lf --runintegration -Wignore'

"Navigate buffers
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bf :bfirst<CR>
nnoremap <leader>bl :blast<CR>

"Coc autocomplete
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

nnoremap ccd :CocDiagnostics<CR>
nmap <C-n> :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
"Other
nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>ne :Telescope file_browser<CR>
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <C-p> :Telescope git_files<CR>
nnoremap <C-f> :Telescope live_grep<CR>
nnoremap <leader>gb :Telescope git_branches<CR>

nmap cp :let @+ = expand("%")

"nnoremap <leader>f :call CocAction('format')<CR>
autocmd StdinReadPre * let s:std

"==============================================================================
" plugin configs
"==============================================================================
"- format on save
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
command! -nargs=0 Prettier :CocCommand prettier.formatFile
autocmd BufWritePre *.py call CocAction('format')

let g:NERDTreeWinSize=60

let gitBranch=system("git rev-parse --abbrev-ref HEAD")
    set laststatus=2
    set statusline=%F%m%r%h%w\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]
    execute "set statusline +=" . gitBranch

" coc config
let g:coc_global_extensions = [
\ 'coc-snippets',
\ 'coc-pairs',
\ 'coc-tsserver',
\ 'coc-jest',
\ 'coc-eslint', 
\ 'coc-prettier', 
\ 'coc-json', 
\ 'coc-pyright', 
\ 'coc-actions',
\ ]
" from readme
"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

map gc :call Toggle()<CR>

function! Comment()
	let ft = &filetype
	if ft == 'php' || ft == 'ruby' || ft == 'sh' || ft == 'make' || ft == 'python' || ft == 'perl'
		silent s/^/\#/
	elseif ft == 'typescriptreact' || ft == 'typescript' || ft == 'javascript' || ft == 'c' || ft == 'cpp' || ft == 'java' || ft == 'objc' || ft == 'scala' || ft == 'go'
		silent s:^:\/\/:g
	elseif ft == 'tex'
		silent s:^:%:g
	elseif ft == 'vim'
		silent s:^:\":g
	endif
endfunction

function! Uncomment()
	let ft = &filetype
	if ft == 'php' || ft == 'ruby' || ft == 'sh' || ft == 'make' || ft == 'python' || ft == 'perl'
		silent s/^\#//
	elseif ft == 'typescriptreact' || ft == 'typescript' || ft == 'javascript' || ft == 'c' || ft == 'cpp' || ft == 'java' || ft == 'objc' || ft == 'scala' || ft == 'go'
		silent s:^\/\/::g
	elseif ft == 'tex'
		silent s:^%::g
	elseif ft == 'vim'
		silent s:^\"::g
	endif
endfunction

function! Toggle()
	try
		call Uncomment()
	catch
		call Comment()
	endtry
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Testing
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

augroup ReactFiletypes
  autocmd!
  autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
  autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
augroup END

"fzf
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let g:glow_use_pager = v:false

" Focus and redistribute split windows
noremap ff :resize 100 <CR> <BAR> :vertical resize 220<CR>
noremap fm <C-w>=

" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Buffer navigation
" TODO
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

"****************************************************
"Markdown Preview Recommended Settings
"****************************************************
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1 

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 1 

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

"Telescope
" will find .lua file that exist at runtime
" should be unique
lua require("init") 

nnoremap <C-_> :Telescope current_buffer_fuzzy_find sorting_strategy=ascending prompt_position=top <cr> 
" nnoremap <leader>t lua require('telescope.builtin').current_buffer_fuzzy_find({sorting_strategy="ascending", prompt_position="top"})<cr>
