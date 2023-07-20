return function()
  local wk = require("which-key")
  require("lspconfig.ui.windows").default_options.border = "rounded"

  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  -- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
  -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
  -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
  -- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

  local diagnostic = vim.diagnostic
  local keyoption = { silent = true, noremap = true }


  -- -- 跳转到声明
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>Lspsaga peek_definition<CR>", )
  -- -- 跳转到定义
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", )
  -- -- 显示注释文档
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>Lspsaga lsp_finder<CR>", )
  -- -- 跳转到实现
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>",
  --   )
  -- -- 跳转到引用位置
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Lspsaga rename<CR>", )
  -- -- 以浮窗形式显示错误
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "go", "<cmd>lua vim.diagnostic.open_float()<CR>",
  --   )
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>",
  --   )
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>",
  --   )
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>",
  --   )
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>",
  --   )
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", )
  -- vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", )
  wk.register({
    ['g'] = {
      name = "+lsp",
      d = { ":Lspsaga peek_definition<CR>", keyoption },
      h = { ":Lspsaga lsp_finder<CR>", keyoption }
      --      o = { ":lua vim.diagnostic.open_float()<CR>", "打开诊断", keyoption },
      --      n = { ":lua vim.diagnostic.goto_next()<CR>", "跳转下一个诊断", keyoption },
      --      p = { ":lua vim.diagnostic.goto_prev()<CR>", "跳转上一个诊断", keyoption },
      --      l = { ":lua vim.diagnostic.setloclist()<CR>", "setloclist", keyoption }
    }
  })

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      -- local opts = { buffer = ev.buf }
      -- vim.keymap.set("n", require("custom_keys").goto_declaration, vim.lsp.buf.declaration, opts)
      -- vim.keymap.set("n", require("custom_keys").goto_definition, vim.lsp.buf.definition, opts)
      -- vim.keymap.set("n", require("custom_keys").goto_references, vim.lsp.buf.references, opts)
      -- vim.keymap.set("n", require("custom_keys").goto_impl, vim.lsp.buf.implementation, opts)
      -- vim.keymap.set("n", require("custom_keys").lsp_rename, vim.lsp.buf.rename, opts)
      -- vim.keymap.set("n", require("custom_keys").format, function()
      --   vim.lsp.buf.format({ async = true })
      -- end, opts)

      -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
      -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
      -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
      -- vim.keymap.set("n", "<space>wl", function()
      --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      -- end, opts)
      -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
      -- vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    end,
  })
end
