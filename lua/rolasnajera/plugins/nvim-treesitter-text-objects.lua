return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = true,
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        include_surrounding_whitespace = false,
      },
      swap = {
        -- swap config is handled via keymaps below
      },
      move = {
        set_jumps = true,
      },
    })

    -- Select keymaps
    local select = require("nvim-treesitter-textobjects.select")
    local select_keymaps = {
      ["a="] = { "@assignment.outer", "Select outer part of an assignment" },
      ["i="] = { "@assignment.inner", "Select inner part of an assignment" },
      ["l="] = { "@assignment.lhs", "Select left hand side of an assignment" },
      ["r="] = { "@assignment.rhs", "Select right hand side of an assignment" },
      ["a:"] = { "@property.outer", "Select outer part of an object property" },
      ["i:"] = { "@property.inner", "Select inner part of an object property" },
      ["l:"] = { "@property.lhs", "Select left part of an object property" },
      ["r:"] = { "@property.rhs", "Select right part of an object property" },
      ["aa"] = { "@parameter.outer", "Select outer part of a parameter/argument" },
      ["ia"] = { "@parameter.inner", "Select inner part of a parameter/argument" },
      ["ai"] = { "@conditional.outer", "Select outer part of a conditional" },
      ["ii"] = { "@conditional.inner", "Select inner part of a conditional" },
      ["al"] = { "@loop.outer", "Select outer part of a loop" },
      ["il"] = { "@loop.inner", "Select inner part of a loop" },
      ["af"] = { "@call.outer", "Select outer part of a function call" },
      ["if"] = { "@call.inner", "Select inner part of a function call" },
      ["am"] = { "@function.outer", "Select outer part of a method/function definition" },
      ["im"] = { "@function.inner", "Select inner part of a method/function definition" },
      ["ac"] = { "@class.outer", "Select outer part of a class" },
      ["ic"] = { "@class.inner", "Select inner part of a class" },
    }
    for key, val in pairs(select_keymaps) do
      vim.keymap.set({ "x", "o" }, key, function()
        select.select_textobject(val[1], "textobjects")
      end, { desc = val[2] })
    end

    -- Swap keymaps
    local swap = require("nvim-treesitter-textobjects.swap")
    local swap_next_keymaps = {
      ["<leader>na"] = { "@parameter.inner", "swap parameters/argument with next" },
      ["<leader>n:"] = { "@property.outer", "swap object property with next" },
      ["<leader>nm"] = { "@function.outer", "swap function with next" },
    }
    for key, val in pairs(swap_next_keymaps) do
      vim.keymap.set("n", key, function()
        swap.swap_next(val[1])
      end, { desc = val[2] })
    end
    local swap_prev_keymaps = {
      ["<leader>pa"] = { "@parameter.inner", "swap parameters/argument with prev" },
      ["<leader>p:"] = { "@property.outer", "swap object property with prev" },
      ["<leader>pm"] = { "@function.outer", "swap function with previous" },
    }
    for key, val in pairs(swap_prev_keymaps) do
      vim.keymap.set("n", key, function()
        swap.swap_previous(val[1])
      end, { desc = val[2] })
    end

    -- Move keymaps
    local move = require("nvim-treesitter-textobjects.move")
    local move_next_start_keymaps = {
      ["]f"] = { "@call.outer", "Next function call start" },
      ["]m"] = { "@function.outer", "Next method/function def start" },
      ["]c"] = { "@class.outer", "Next class start" },
      ["]i"] = { "@conditional.outer", "Next conditional start" },
      ["]l"] = { "@loop.outer", "Next loop start" },
      ["]s"] = { "@scope", "Next scope", "locals" },
      ["]z"] = { "@fold", "Next fold", "folds" },
    }
    for key, val in pairs(move_next_start_keymaps) do
      local query = val[1]
      local group = val[3] or "textobjects"
      vim.keymap.set({ "n", "x", "o" }, key, function()
        move.goto_next_start(query, group)
      end, { desc = val[2] })
    end
    local move_next_end_keymaps = {
      ["]F"] = { "@call.outer", "Next function call end" },
      ["]M"] = { "@function.outer", "Next method/function def end" },
      ["]C"] = { "@class.outer", "Next class end" },
      ["]I"] = { "@conditional.outer", "Next conditional end" },
      ["]L"] = { "@loop.outer", "Next loop end" },
    }
    for key, val in pairs(move_next_end_keymaps) do
      vim.keymap.set({ "n", "x", "o" }, key, function()
        move.goto_next_end(val[1], "textobjects")
      end, { desc = val[2] })
    end
    local move_prev_start_keymaps = {
      ["[f"] = { "@call.outer", "Prev function call start" },
      ["[m"] = { "@function.outer", "Prev method/function def start" },
      ["[c"] = { "@class.outer", "Prev class start" },
      ["[i"] = { "@conditional.outer", "Prev conditional start" },
      ["[l"] = { "@loop.outer", "Prev loop start" },
    }
    for key, val in pairs(move_prev_start_keymaps) do
      vim.keymap.set({ "n", "x", "o" }, key, function()
        move.goto_previous_start(val[1], "textobjects")
      end, { desc = val[2] })
    end
    local move_prev_end_keymaps = {
      ["[F"] = { "@call.outer", "Prev function call end" },
      ["[M"] = { "@function.outer", "Prev method/function def end" },
      ["[C"] = { "@class.outer", "Prev class end" },
      ["[I"] = { "@conditional.outer", "Prev conditional end" },
      ["[L"] = { "@loop.outer", "Prev loop end" },
    }
    for key, val in pairs(move_prev_end_keymaps) do
      vim.keymap.set({ "n", "x", "o" }, key, function()
        move.goto_previous_end(val[1], "textobjects")
      end, { desc = val[2] })
    end

    -- Repeatable move keymaps
    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
  end,
}
