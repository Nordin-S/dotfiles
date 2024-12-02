local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      local dap_virtual_text_status = require("nvim-dap-virtual-text")

      local dapui = require("dapui")

      dap_virtual_text_status.setup({
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = true, -- prefix virtual text with comment string
        only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)
        filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
        -- experimental features:
        virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      })

      local icons = require("config.icons")
      vim.api.nvim_set_hl(0, "DapStoppedLinehl", { bg = "#555530" })
      vim.fn.sign_define(
        "DapBreakpoint",
        { text = icons.ui.TinyCircle, texthl = "DapBreakpoint", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = icons.ui.CircleWithGap, texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
      )
      vim.fn.sign_define("DapLogPoint", { text = icons.ui.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapStopped",
        { text = icons.ui.ChevronRight, texthl = "Error", linehl = "DapStoppedLinehl", numhl = "" }
      )
      vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = icons.diagnostics.Error, texthl = "Error", linehl = "", numhl = "" }
      )

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      dap.defaults.fallback.terminal_win_cmd = "10split new"

      local utilsFile = require("utils.file")
      local codelldb = require("utils.codelldb")
      -- cpp daps
      dap.configurations.cpp = {
        {
          name = "C++ Debug And Run",
          type = "codelldb",
          request = "launch",
          program = function()
            -- First, check if exists CMakeLists.txt
            local cwd = vim.fn.getcwd()
            if utilsFile.exists(cwd, "CMakeLists.txt") then
              -- If a CMakeLists.txt exists, ask user to provide the executable path
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            else
              local fileName = vim.fn.expand("%:t:r")
              -- Ensure the 'bin' directory exists
              local binDir = "bin"
              if not utilsFile.exists(cwd, binDir) then
                os.execute("mkdir -p " .. binDir)
              end

              -- Compile the file using g++
              local compileCmd = "g++ -g " .. vim.fn.expand("%") .. " -o " .. binDir .. "/" .. fileName
              local handle = io.popen(compileCmd)
              local result = handle:read("*a")
              handle:close()

              -- Check if there were compilation errors
              if result:find("error") then
                vim.notify("C++ compilation failed: " .. result, vim.log.levels.ERROR)
                return nil -- Prevent debugger from launching if compilation fails
              end

              -- Return the path to the compiled executable
              return "${workspaceFolder}/bin/" .. fileName
            end
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          runInTerminal = true,
          console = "integratedTerminal",
        },
      }

      -- c daps
      dap.configurations.c = {
        {
          name = "C Debug And Run",
          type = "codelldb",
          request = "launch",
          program = function()
            local cwd = vim.fn.getcwd()
            local fileName = vim.fn.expand("%:t:r")
            local outputPath = cwd .. "/bin/" .. fileName

            -- Check if CMakeLists.txt exists
            if utilsFile.exists(cwd, "CMakeLists.txt") then
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            else
              -- Ensure the 'bin' directory exists
              if not utilsFile.exists(cwd, "bin") then
                os.execute("mkdir -p " .. cwd .. "/bin")
              end

              -- Compile the file
              local cmd = "gcc -g " .. vim.fn.expand("%") .. " -o " .. outputPath
              local handle = io.popen(cmd)
              local result = handle:read("*a")
              handle:close()

              -- Check for compilation errors
              if result:find("error") then
                vim.notify("C compilation failed. Check the output.", vim.log.levels.ERROR)
                return nil
              end

              -- Return the path to the compiled executable
              return outputPath
            end
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          -- CHANGE THIS to your path!
          command = codelldb.codelldb_path,
          args = { "--port", "${port}" },

          -- On windows you may have to uncomment this:
          -- detached = false,
        },
      }

      -- js daps
      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          -- Debug single nodejs files
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",

            program = function()
              local result = vim.fn.system("npx tsc")
              if result:find("error") then
                vim.notify("TypeScript compilation failed. Check the output for errors.", vim.log.levels.ERROR)
                return nil
              end
              return "${file}"
            end,

            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            preLaunchTask = { "tsc: build - tsconfig.json" },
            outFiles = { "${workspaceFolder}/**/*.js", "!**/node_modules/**" },
            runtimeExecutable = "node",
            runtimeArgs = {
              "-r",
              vim.fn.system("npm root -g"):gsub("%s+$", "") .. "/ts-node/register",
              "--inspect-brk",
              "${file}",
            },
          },
          -- Debug nodejs processes (make sure to add --inspect when you run the process)
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },
          -- Debug web applications (client side)
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch & Debug Chrome",
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({
                  prompt = "Enter URL: ",
                  default = "http://localhost:3000",
                }, function(url)
                  if url == nil or url == "" then
                    return
                  else
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            webRoot = vim.fn.getcwd(),
            protocol = "inspector",
            sourceMaps = true,
            userDataDir = false,
          },
          -- Divider for the launch.json derived configs
          {
            name = "----- ↓ launch.json configs ↓ -----",
            type = "",
            request = "launch",
          },
        }
      end
    end,
    -- keys = {
    --   {
    --     "<leader>dO",
    --     function()
    --       require("dap").step_out()
    --     end,
    --     desc = "Step Out",
    --   },
    --   {
    --     "<leader>do",
    --     function()
    --       require("dap").step_over()
    --     end,
    --     desc = "Step Over",
    --   },
    --   {
    --     "<leader>da",
    --     function()
    --       if vim.fn.filereadable(".vscode/launch.json") then
    --         local dap_vscode = require("dap.ext.vscode")
    --         dap_vscode.load_launchjs(nil, {
    --           ["pwa-node"] = js_based_languages,
    --           ["chrome"] = js_based_languages,
    --           ["pwa-chrome"] = js_based_languages,
    --         })
    --       end
    --       require("dap").continue()
    --     end,
    --     desc = "Run with Args",
    --   },
    -- },
    dependencies = {
      { "nvim-neotest/nvim-nio" },
      { "theHamsta/nvim-dap-virtual-text" },
      { "rcarriga/nvim-dap-ui" },
      -- Install the vscode-js-debug adapter
      {
        "microsoft/vscode-js-debug",
        -- After install, build it and rename the dist directory to out
        build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
        version = "1.*",
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("dap-vscode-js").setup({
            -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            -- node_path = "node",

            -- Path to vscode-js-debug installation.
            debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

            -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
            -- debugger_cmd = { "js-debug-adapter" },

            -- which adapters to register in nvim-dap
            adapters = {
              "chrome",
              "pwa-node",
              "pwa-chrome",
              "pwa-msedge",
              "pwa-extensionHost",
              "node-terminal",
            },

            -- Path for file logging
            -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

            -- Logging level for output to file. Set to false to disable logging.
            -- log_file_level = false,

            -- Logging level for output to console. Set to false to disable console output.
            -- log_console_level = vim.log.levels.ERROR,
          })
        end,
      },
      -- {
      --   "Joakker/lua-json5",
      --   build = "./install.sh",
      -- },
    },
  },
}
