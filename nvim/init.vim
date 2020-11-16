"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|

let mapleader=","
let maplocalleader=" "
let g:VM_leader=","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
	" Daddy Tim Pope
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-fugitive'

	Plug 'danro/rename.vim'
	Plug 'triglav/vim-visual-increment'

	" Status bar
	Plug 'vim-airline/vim-airline'

	" multicoursor
	Plug 'mg979/vim-visual-multi'

	" Tags
	Plug 'craigemery/vim-autotag'
	Plug 'majutsushi/tagbar'

	" " FZF
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	" add indent object (mainly for python)
	Plug 'michaeljsmith/vim-indent-object'

	" latex
	Plug 'lervag/vimtex'

	" Snippets
	Plug 'SirVer/ultisnips'
	Plug 'AnHoang97/vim-snippets'

	" session
	Plug 'xolox/vim-session'
	Plug 'xolox/vim-misc'

	" linting
	Plug 'w0rp/ale'

	" autocomplete 
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "deoplete
	Plug 'deoplete-plugins/deoplete-jedi' "python plugin
	Plug 'tweekmonster/deoplete-clang2' "c plugin

	"auto close brackets
	Plug 'jiangmiao/auto-pairs'

	" peek into register
	Plug 'junegunn/vim-peekaboo'

	" undotree
	Plug 'mbbill/undotree'

	"chad tree > nerd tree
	Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
call plug#end()

augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave *.tex mkview
  autocmd BufWinEnter *.tex silent loadview
augroup END

" =====================================================================
" BASIC SETTINGS
" =====================================================================
	set mouse=a
	set hlsearch
	set clipboard+=unnamedplus
	set noswapfile
	set ic
	set smartcase

	" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax enable
	set encoding=utf-8
	set number relativenumber

	" Splits open at the bottom and right, which is non-retarded, unlike vim defaults
	set splitbelow splitright

	" make split line prettier
	hi VertSplit ctermfg=0 ctermbg=NONE cterm=NONE
	set fillchars+=vert:\ 

	" change match bracket color
	hi MatchParen cterm=none ctermbg=green ctermfg=black
	" enable indentation
	set breakindent
	autocmd FileType tex set linebreak
	autocmd FileType tex set spell
	autocmd FileType tex set spelllang=en_us,de_de
	autocmd FileType tex set spellsuggest=best


	"make regex magic
	nnoremap / /\v\c
	vnoremap / /\v\c
	cnoremap s/ s/\v

	" changes to buffers are always written
	set autowriteall
	set cursorline
	hi CursorLine cterm=NONE ctermbg=black 

	if has('persistent_undo')
	    let target_path = expand('~/.cache/vim-undodir/')
	    if !isdirectory(target_path)
		call system('mkdir -p ' . target_path)
	    endif
	    let &undodir = target_path
	    set undofile
	endif

	" set python host
	let g:python3_host_prog = '/Users/Shared/anaconda3/bin/python'

" =====================================================================
" Airline SETTINGS
" =====================================================================
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#show_buffers = 1
	let g:airline#extensions#tabline#switch_buffers_and_tabs = 0
	" power saving
	let g:ale_lint_on_text_changed = "normal"
	let g:ale_lint_delay = 1000
	let g:ale_completion_enabled = 1
	let g:airline#extensions#tagbar#enabled = 1

" =====================================================================
" Undotree SETTINGS
" =====================================================================
	nnoremap <leader>u :UndotreeToggle<cr>

" =====================================================================
" chad tree SETTINGS
" =====================================================================
	nnoremap <leader>c <cmd>CHADopen<cr>

" =====================================================================
" ALE SETTINGS
" =====================================================================
	let g:airline#extensions#ale#enabled = 1
	nmap <silent> <C-k> <Plug>(ale_previous_wrap)
	nmap <silent> <C-j> <Plug>(ale_next_wrap)

" =====================================================================
" FZF SETTINGS
" =====================================================================
	" fzf with preview
	command! -bang -nargs=? -complete=dir Files
		\ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
	nnoremap <c-f> :Files<CR>
	nnoremap <c-h> :Files<space>~<CR>
	nnoremap <c-b> :w<CR>:Buffers<CR>
	nnoremap <c-l> :Lines<CR>


" =====================================================================
" Latex SETTINGS
" =====================================================================
	let g:tex_flavor = 'latex'
	let g:vimtex_view_method = 'skim'
	let g:vimtex_fold_enabled = 2

	" latex macros
	autocmd bufenter *.tex let @u="%mr%ml`ri \\right`li \\left"
	autocmd bufenter *.tex let @d="ml%B6x`l5x"

	autocmd bufenter *.tex inoremap <c-space> <c-x><c-o>
	autocmd bufenter *.tex nnoremap gt yi}:b<space><c-r>0.tex<cr>
	autocmd bufenter *.tex nnoremap <c-t> :Tags<cr>
	autocmd bufenter *.tex nnoremap <c-rightmouse> <c-]>
	autocmd bufenter *.tex nnoremap <bs> :b main.tex<tab><cr>

" =====================================================================
" SNIPEPTS SETTINGS
" =====================================================================
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'


" =====================================================================
" VIM-SESSION SETTINGS
" =====================================================================
	let g:session_autosave = 'yes'
	let g:session_autoload = 'no'
	let g:session_directory = '~/.cache/nvim/session'

" =====================================================================
" MACROS
" =====================================================================
 	vnoremap <localleader>s y:%s/<C-r>0//g<left><left>

 	vnoremap <localleader>e :!translate --target_lang EN<cr>
 	vnoremap <localleader>d :!translate --target_lang DE --formality more<cr>
 	vmap <localleader>i <space>egv<space>d

 	nnoremap <localleader><localleader> za
	nnoremap <right> :cnext<cr>
	nnoremap <left> :cprevious<cr>
	autocmd bufenter *.c,*.h nnoremap <cr> :make<cr>


" =====================================================================
" Deoplete SETTINGS
" =====================================================================
	let g:deoplete#enable_at_startup = 1
	" This is new style
	autocmd bufenter *.tex call deoplete#custom#var('omni', 'input_patterns', {
	  	  \ 'tex': g:vimtex#re#deoplete
	  	  \})

