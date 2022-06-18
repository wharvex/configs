-- local cmp = require "cmp"
-- cmp.setup {
--   sources = {
--     { name = 'nvim_lsp' }
--   }
-- }
local handlers = require "user.lsp.handlers"
-- https://github.com/eruizc-dev/eruizc-dev/blob/master/dotfiles/xdg_config_home/nvim/lua/eruizc/lsp.lua
local existing_capabilities = vim.lsp.protocol.make_client_capabilities()
-- local lspconfig = require("lspconfig")
-- lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
--   capabilities = require('cmp_nvim_lsp').update_capabilities(existing_capabilities),
-- })
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    'java', -- or '/path/to/java11_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar', '/home/tim/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         -- Must point to the
         -- eclipse.jdt.ls installation


    '-configuration', '/home/tim/.local/share/nvim/lsp_servers/jdtls/config_linux',
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.


    -- See `data directory configuration` section in the README
    '-data', vim.fn.getcwd()
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require("jdtls.setup").find_root({'.git', 'mvnw', 'gradlew'}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      implementationsCodeLens = {
        enabled = true
      },
      completion = {
        importOrder = {}
      },
      sources = {
        organizeImports = {
           starThreshold = 2,
           staticStarThreshold = 2
        }
      }
    }
  },
  -- capabilities = lspconfig.util.default_config.capabilities,
  capabilities = require('cmp_nvim_lsp').update_capabilities(existing_capabilities),
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {vim.fn.glob("/home/tim/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")}
  },
}

config['on_attach'] = function(client, bufnr)
  handlers.km(bufnr)
  handlers.hd(client)
  -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
  -- you make during a debug session immediately.
  -- Remove the option if you do not want that.
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
-- cmp.complete()
