"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|

let mapleader=","
let maplocalleader=" "

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

	" Status bar
	Plug 'vim-airline/vim-airline'

	" multicoursor
	Plug 'mg979/vim-visual-multi'

	" " FZF
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	" add indent object (mainly for python)
	Plug 'michaeljsmith/vim-indent-object'

	" linting
	Plug 'w0rp/ale'

	" autocomplete
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "deoplete

	"auto close brackets
	Plug 'jiangmiao/auto-pairs'

	" peek into register
	Plug 'junegunn/vim-peekaboo'

	" undotree
	Plug 'mbbill/undotree'
call plug#end()

augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave *.tex mkview
  autocmd BufWinEnter *.tex silent loadview
augroup END

" =====================================================================
" BASIC SETTINGS
" =====================================================================
"
	" set colorscheme to nord
	set mouse=a
	set hlsearch
	set clipboard+=unnamedplus
	set noswapfile
	set ic
	set smartcase

	" Some basics:
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

" =====================================================================
" ALE SETTINGS
" =====================================================================
	nmap <silent> <C-k> <Plug>(ale_previous_wrap)
	nmap <silent> <C-j> <Plug>(ale_next_wrap)
	" power saving
	let g:ale_lint_on_text_changed = "normal"
	let g:ale_lint_delay = 1000
	let g:ale_completion_enabled = 1

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
" VIM-SESSION SETTINGS
" =====================================================================
	let g:session_autosave = 'yes'
	let g:session_autoload = 'no'
	let g:session_directory = '~/.cache/nvim/session'

" =====================================================================
" Deoplete SETTINGS
" =====================================================================
	let g:deoplete#enable_at_startup = 1
