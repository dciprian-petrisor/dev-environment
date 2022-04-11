if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

if has("nvim")
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'williamboman/nvim-lsp-installer'
	Plug 'ojroques/vim-oscyank', {'branch': 'main'}
	Plug 'projekt0n/github-nvim-theme'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'onsails/lspkind-nvim'
	Plug 'tami5/lspsaga.nvim', { 'branch': 'nvim6.0' }
	Plug 'beanworks/vim-phpfmt'
	Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'kristijanhusak/defx-git'
	Plug 'kristijanhusak/defx-icons'

endif

call plug#end()
