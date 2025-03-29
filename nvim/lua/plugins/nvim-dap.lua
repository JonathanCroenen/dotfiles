return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    dap.adapters.avr = {
      type = "executable",
      command = "avr-gdb",
      name = "avr",
    }

    dap.configurations.c = {
      {
        name = "Launch AVR",
        type = "avr",
        request = "launch",
        program = function()
          return vim.fn.input("Path to .elf file: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        target = "localhost:4242",
        gdbpath = "avr-gdb",
        preLaunchTask = function()
          -- launch AVaRICE
          local mcu = vim.fn.input("MCU: ", "atmega4809")
          local handle = vim.loop.spawn("avarice", {
            args = { "--jtag", "--debugwire", "--part", mcu, ":4242" },
            detached = true,
          }, function(code, _)
            if code ~= 0 then
              print("AVaRICE exited with code", code)
            end
          end)
          if not handle then
            error("Failed to spawn AVaRICE")
          end
        end,
      },
    }
  end,
}
