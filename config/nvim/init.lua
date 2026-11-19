vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = { image = { enabled = true } },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = false,
    opts = {
      indent = { char = "│", highlight = "IblIndent" },
      scope = { enabled = true, highlight = "IblScope", show_start = false, show_end = false },
      exclude = { filetypes = { "help", "lazy", "neo-tree", "TelescopePrompt", "aerial" } },
    },
  },
  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    keys = {
      { "<leader>b", "<cmd>AerialToggle right<cr>", desc = "Toggle code outline" },
    },
    opts = { layout = { default_direction = "right" } },
  },
  {
    "selimacerbas/mdkite.nvim",
    dependencies = { "selimacerbas/kitehost.nvim" },
    cmd = "MdKite",
    opts = {},
    keys = {
      { "<leader>mp", "<cmd>MdKite toggle<cr>", desc = "Toggle Markdown preview" },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      close_if_last_window = false,
      enable_git_status = true,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            ["/"] = "fuzzy_finder",
            ["<C-f>"] = "fuzzy_finder",
            ["f"] = "filter_on_submit",
            ["D"] = "fuzzy_finder_directory",
            ["<C-x>"] = "clear_filter",
          },
          fuzzy_finder_mappings = {
            ["<C-j>"] = "move_cursor_down",
            ["<C-k>"] = "move_cursor_up",
            ["<C-x>"] = "close_clear_filter",
            ["<Esc>"] = "close",
          },
        },
      },
      window = {
        position = "left",
        width = 32,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<Esc>"] = "close",
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
          hidden = true,
        },
      },
    },
  },
})

local function telescope_builtin(picker)
  return function()
    require("telescope.builtin")[picker]()
  end
end

local function open_terminal()
  vim.cmd("botright split | terminal")
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle left<cr>", { desc = "Toggle file browser" })
vim.keymap.set("n", "<leader>g", "<cmd>terminal lazygit<cr>", { desc = "Lazygit" })
vim.keymap.set("n", "<leader>t", open_terminal, { desc = "Open terminal" })
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>ff", telescope_builtin("find_files"), { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", telescope_builtin("live_grep"), { desc = "Grep project" })
vim.keymap.set("n", "<leader>fb", telescope_builtin("buffers"), { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fr", telescope_builtin("oldfiles"), { desc = "Recent files" })
vim.keymap.set("n", "<leader>fs", telescope_builtin("current_buffer_fuzzy_find"), { desc = "Search current file" })
vim.keymap.set("n", "<leader>fw", telescope_builtin("grep_string"), { desc = "Search word under cursor" })
vim.keymap.set("n", "<leader>fh", telescope_builtin("help_tags"), { desc = "Search help" })
vim.keymap.set("n", "<C-f>", telescope_builtin("current_buffer_fuzzy_find"), { desc = "Search current file" })
vim.keymap.set("i", "<C-f>", function()
  vim.cmd("stopinsert")
  require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "Search current file" })
vim.keymap.set("v", "<C-f>", function()
  vim.cmd("normal! \27")
  require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "Search current file" })
vim.keymap.set("n", "<leader>/", telescope_builtin("current_buffer_fuzzy_find"), { desc = "Search current file" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })
vim.keymap.set("n", "*", "*zzzv", { desc = "Search word under cursor" })
vim.keymap.set("n", "#", "#zzzv", { desc = "Search word under cursor backwards" })
vim.keymap.set("i", "jk", "<esc>", { desc = "Escape insert mode" })
vim.keymap.set("i", "jj", "<esc>", { desc = "Escape insert mode" })
vim.keymap.set("v", "jk", "<esc>", { desc = "Escape visual mode" })
vim.keymap.set("v", "jj", "<esc>", { desc = "Escape visual mode" })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Leave terminal mode" })
vim.keymap.set("t", "<c-space>", "<c-\\><c-n>", { desc = "Leave terminal mode" })

local treesitter_ok, treesitter = pcall(require, "nvim-treesitter")
if treesitter_ok then
  treesitter.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
  })

  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      pcall(vim.treesitter.start)
    end,
  })
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 or vim.fn.filereadable(vim.fn.argv(0)) == 1 then
      vim.cmd("Neotree show left")
      vim.cmd("wincmd p")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function(event)
    vim.keymap.set("n", "<C-f>", "/", {
      buffer = event.buf,
      desc = "Search file browser",
      remap = true,
    })
  end,
})

-- Let the terminal draw the background, including its configured opacity.
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    for _, group in ipairs({ "Normal", "NormalNC", "NormalFloat", "SignColumn", "EndOfBuffer" }) do
      local highlight = vim.api.nvim_get_hl(0, { name = group, link = false })
      highlight.bg = nil
      vim.api.nvim_set_hl(0, group, highlight)
    end
  end,
})

local theme_file = vim.fn.stdpath("state") .. "/macos-theme"
local saved_theme = vim.fn.filereadable(theme_file) == 1 and vim.fn.readfile(theme_file)[1] or "charcoal"
if saved_theme ~= "ivory" and saved_theme ~= "charcoal" then saved_theme = "charcoal" end
vim.cmd.colorscheme(saved_theme)

local function select_theme(name)
  vim.cmd.colorscheme(name)
  vim.fn.mkdir(vim.fn.stdpath("state"), "p")
  vim.fn.writefile({ name }, theme_file)
end
vim.api.nvim_create_user_command("Theme", function(opts)
  if opts.args == "" then
    vim.ui.select({ "ivory", "charcoal" }, { prompt = "Appearance" }, function(choice)
      if choice then select_theme(choice) end
    end)
  elseif opts.args == "ivory" or opts.args == "charcoal" then
    select_theme(opts.args)
  else
    vim.notify("Choose ivory or charcoal", vim.log.levels.WARN)
  end
end, { nargs = "?", complete = function() return { "ivory", "charcoal" } end })
vim.keymap.set("n", "<leader>ut", "<cmd>Theme<cr>", { desc = "Choose appearance" })
