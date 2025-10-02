return {
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    -- event = "VeryLazy",
    keys = {
      {
        "<C-S-F>",
        function()
          require("conform").format()
        end,
        mode = { "n", "i", "v" },
        desc = "Format",
      },
    },
    config = function()
      local path = function(exe, configname)
        local re = vim.fn.exepath(exe)
        re = vim.fn.fnamemodify(re, ":h")
        return ("%s/%s"):format(re, configname)
      end
      require("conform").setup({
        log_level = vim.log.levels.DEBUG,
        default_format_opts = {
          async = false,
          -- quiet = false,
          lsp_format = "fallback",
          timeout_ms = 5000,
        },
        formatters = {
          stylua = {
            prepend_args = { "-f", path("stylua", "stylua.toml") },
          },
          biome = {
            append_args = { ("--config-path=%s"):format(path("biome", "biome.json")) },
          },
          taplo = {
            append_args = { "-c", path("taplo", "taplo.toml") },
          },
          yamlfmt = {
            prepend_args = { "-conf", path("yamlfmt", "yamlfmt.yaml") },
          },
        },
        formatters_by_ft = {
          javascript = { "biome" },
          typescript = { "biome" },
          typescriptreact = { "biome", "rustywind" },
          javascriptreact = { "biome", "rustywind" },
          json = { "biome" },
          jsonc = { "biome" },
          svg = { "xmllint" },
          xml = { "xmllint" },
          css = { "biome" },
          graphql = { "biome" },
          -- markdown = { "dprint" },
          yaml = { "yamlfmt" },
          toml = { "taplo" },
          lua = { "stylua" },
          sh = { "shfmt" },
        },
      })
    end,
  },
}
