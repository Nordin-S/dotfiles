return {
  "mfussenegger/nvim-dap",
  opts = function(_, _)
    local dap = require("dap")
    local js_debug_path = require("mason-registry").get_package("js-debug-adapter"):get_install_path()

    local function get_runtime_args()
      local cwd = vim.fn.getcwd()
      local tsconfig = cwd .. "/tsconfig.json"
      if vim.fn.filereadable(tsconfig) == 1 then
        return { "--project", tsconfig }
      else
        return {}
      end
    end

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          js_debug_path .. "/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }

    dap.configurations.typescript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch TS with ts-node (auto tsconfig)",
        program = "${file}",
        cwd = "${workspaceFolder}",
        runtimeExecutable = "ts-node",
        runtimeArgs = get_runtime_args(),
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**" },
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
      },
    }
  end,
}
