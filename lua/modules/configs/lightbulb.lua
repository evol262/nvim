local status_ok, _ = pcall(require, "nvim-lightbulb")
if not status_ok then
   return
end

require("core.autocmds").define_augroups {
   lightbulb = {
      {
         "CursorHold,CursorHoldI",
         [[\*\(^dashboard\)@<!]],
         "lua require('nvim-lightbulb').update_lightbulb()",
      },
   },
}
