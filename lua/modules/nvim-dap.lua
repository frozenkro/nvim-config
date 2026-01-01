local dap = require('dap')

dap.adapters.delve = {
  type = "server",
  host = "127.0.0.1",
  port = 45345,
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages 
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  } 
}

dap.adapters.gdb = {
  type = 'executable',
  command = 'arm-none-eabi-gdb',
  args = { '-i', 'dap' }
}

dap.configurations.c = {
  {
    name = 'Launch dirtie main (openocd)',
    type = 'gdb',
    request = 'launch',
    program = '${workspaceFolder}/build/dirtie_node.elf',
    cwd = '${workspaceFolder}',
    stopAtBeginningOfMainSubprogram = false,
    setupCommands = {
      {
        text = 'file ${workspaceFolder}/build/dirtie_node.elf',
        description = 'Load symbols',
        ignoreFailures = false,
      },
      {
        text = 'target extended-remote localhost:3333',
        description = 'Connect to OpenOCD',
        ignoreFailures = false,
      },
      {
        text = 'monitor reset init',
        description = 'Reset target',
        ignoreFailures = false,
      },
      {
        text = 'load',
        description = 'Load program',
        ignoreFailures = false,
      },
    },
  },
  {
    name = 'Launch dirtie tests (openocd)',
    type = 'gdb',
    request = 'launch',
    program = '${workspaceFolder}/build/test_dirtie_node.elf',
    cwd = '${workspaceFolder}',
    stopAtBeginningOfMainSubprogram = false,
    setupCommands = {
      {
        text = 'file ${workspaceFolder}/build/test_dirtie_node.elf',
        description = 'Load symbols',
        ignoreFailures = false,
      },
      {
        text = 'target extended-remote localhost:3333',
        description = 'Connect to OpenOCD',
        ignoreFailures = false,
      },
      {
        text = 'monitor reset init',
        description = 'Reset target',
        ignoreFailures = false,
      },
      {
        text = 'load',
        description = 'Load program',
        ignoreFailures = false,
      },
    },
  },
  {
    name = 'Launch Pi Pico (Select ELF)',
    type = 'gdb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to ELF: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtBeginningOfMainSubprogram = false,
    setupCommands = function(config)
      return {
        {
          text = 'file ' .. config.program,
          description = 'Load symbols',
          ignoreFailures = false,
        },
        {
          text = 'target extended-remote localhost:3333',
          description = 'Connect to OpenOCD',
          ignoreFailures = false,
        },
        {
          text = 'monitor reset init',
          description = 'Reset target',
          ignoreFailures = false,
        },
        {
          text = 'load',
          description = 'Load program',
          ignoreFailures = false,
        },
      }
    end,
  },
}
