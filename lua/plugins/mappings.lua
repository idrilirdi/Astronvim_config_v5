local astrocore_mappings = {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<Leader>bD"] = {
      function()
        require("astroui.status").heirline.buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with just a `desc` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<Leader>b"] = { desc = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
if vim.g.neovide then
  local copy_paste_mappings = {
    v = {
      ["<sc-c>"] = { '"+y', desc = "Select line(s) in visual mode and copy" },
      ["<sc-v>"] = { '"+P', desc = "Paste in visual mode" },
    },
    n = {
      ["<sc-v>"] = { '"+p', desc = "Paste in normal mode" },
    },
    c = {

      ["<sc-v>"] = { '<C-o>l<C-o>"+<C-o>P<C-o>l', desc = "Paste in command_line mode" },
    },
    i = {
      ["<sc-v>"] = { '<ESC>"+p', desc = "Paste in insert mode" },
    },
    t = {
      ["<sc-v>"] = { '<C-\\><C-n>"+Pi', desc = "Paste in terminal mode" },
    },
  }
  for mode, mappings in pairs(copy_paste_mappings) do
    astrocore_mappings[mode] = vim.tbl_deep_extend("force", astrocore_mappings[mode] or {}, mappings)
  end
end

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = astrocore_mappings,
    },
  },
}
