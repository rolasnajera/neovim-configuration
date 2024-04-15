# Personal neovim configuration 
In this readme I'm adding each step and important source to configure neovim in Mac

## Plugins

### Plugin manager
New plugin migrating from [packer.nvim](https://github.com/wbthomason/packer.nvim) which is not anymore mantained
[lazy.nvim](https://github.com/folke/lazy.nvim) 

important commands with lazy
- :Lazy -> to see lazy plugins
- :checkhealth lazy 

### Gui colorscheme
[bluz71/vim-nightfly-colors](https://github.com/bluz71/vim-nightfly-colors)
nightfly is a GUI-only colorscheme.

important notes: 
I created a new .lua file called colorscheme.lua which contains the plugin configuration.
Then in the lazy.lua file, I just make refernece to the folder "rolasnajera.plugins"

### File explorer
[nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)   A file explore for neovim written in Lua

### Split terminal
tmux 

### cmp 


