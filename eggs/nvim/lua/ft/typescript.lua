local M = {}

M.lsp = {
  settings = {
    -- typescript language server
    -- typescript = {
    --   -- Inlay Hints preferences
    --   inlayHints = {
    --     includeInlayParameterNameHints = "all",
    --     includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    --     includeInlayFunctionParameterTypeHints = true,
    --     includeInlayVariableTypeHints = true,
    --     includeInlayVariableTypeHintsWhenTypeMatchesName = true,
    --     includeInlayPropertyDeclarationTypeHints = true,
    --     includeInlayFunctionLikeReturnTypeHints = true,
    --     includeInlayEnumMemberValueHints = true,
    --   },
    -- Code Lens preferences
    -- implementationsCodeLens = { enabled = true },
    -- referencesCodeLens = { enabled = true, showOnAllFunctions = true },
    -- },

    --vtsls
    vtsls = { autoUseWorkspaceTsdk = true },
    typescript = {
      referencesCodeLens = { enabled = false, showOnAllFunctions = true },
      implementationsCodeLens = { enabled = false, showOnInterfaceMethods = true },
      -- suggest = { enabled = true, completeFunctionCalls = true },
      inlayHints = {
        parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}

return M
