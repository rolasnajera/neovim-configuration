return {
	"bluz71/vim-nightfly-colors",
         priority = 1000,
         config = function ()
                 -- load the color schema here
                 vim.cmd([[colorscheme nightfly]])
         end,
}
