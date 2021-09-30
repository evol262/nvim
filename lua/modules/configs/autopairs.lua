local autopairs, autopairs_completion
if
   not pcall(function()
      autopairs = require "nvim-autopairs"
      autopairs_completion = require "nvim-autopairs.completion.cmp"
   end)
then
   return
end

autopairs.setup()
autopairs_completion.setup {
   map_cr = true,
   map_complete = true, -- insert () func completion
   auto_select = true,
   insert = false,
   map_char = {
      all = "(",
      text = "{",
   },
}
