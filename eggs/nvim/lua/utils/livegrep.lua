local M = {}
M.multi = function(opts)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local make_entry = require("telescope.make_entry")
  local conf = require("telescope.config").values
  local sorters = require("telescope.sorters")
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  local serchTerm = ""
  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return
      end
      local pieces = vim.split(prompt, "  ")
      local args = { "rg" }
      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
        serchTerm = pieces[1]
      end
      if pieces[2] then
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end
      return vim.list_extend(
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" }
      )
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })
  pickers
    .new(opts, {
      prompt_title = "Live Grep",
      debounce = 100,
      finder = finder,
      previewer = conf.grep_previewer(opts),
      -- sorter = require("telescope.sorters").highlighter_only(),
      sorter = sorters.new({
        scoring_function = function()
          return 1
        end,
        highlighter = function(_, _, display)
          local fzy = require("telescope.algos.fzy")
          return fzy.positions(serchTerm, display)
        end,
      }),
    })
    :find()
end
return M
