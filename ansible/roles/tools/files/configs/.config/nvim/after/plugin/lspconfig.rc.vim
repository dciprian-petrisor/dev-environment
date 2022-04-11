if !exists('g:lspconfig')
		finish
endif


lua << EOF

	local nvim_lsp = require('lspconfig')
	local protocol = require'vim.lsp.protocol'
	local runtime_path = vim.split(package.path, ';')
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")	

	nvim_lsp.intelephense.setup{
		settings = {

			},
		init_options = {
				licenceKey = ""
			}
	}
	nvim_lsp.vimls.setup{}
	nvim_lsp.sumneko_lua.setup {
		 settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  }
}
EOF