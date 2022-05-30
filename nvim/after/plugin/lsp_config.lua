local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	local opts = {}

	if server.name == "sumneko_lua" then
		opts.settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
			},
		}
	end

	server:setup(opts)
end)

local function install_server(server)
	local lsp_installer_servers = require("nvim-lsp-installer.servers")
	local ok, server_analyzer = lsp_installer_servers.get_server(server)
	if ok then
		if not server_analyzer:is_installed() then
			lsp_installer.install(server)
		end
	end
end

local servers = {
	"bashls",
	"clangd",
	"csharp_ls",
	"cssls",
	"cssmodules_ls",
	"denols",
	"diagnosticls",
	"emmet_ls",
	"gopls",
	"html",
	"intelephense",
	"jdtls",
	"jsonls",
	"pyright",
	"sqlls",
	"sumneko_lua",
	"tsserver",
	"vimls",
	"vuels",
}

for _, server in ipairs(servers) do
	install_server(server)
end

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>1", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>2", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "<leader>I", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>3", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<leader>4", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "<leader>5", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<leader>6", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	buf_set_keymap("n", "<leader>7", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<leader>8", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<leader>9", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
end
