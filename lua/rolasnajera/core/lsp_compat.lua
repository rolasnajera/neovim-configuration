local M = {}

if vim.fn.has("nvim-0.11") == 1 then
  local util = vim.lsp.util

  local function resolve_buf(window)
    if type(window) ~= "number" or window == 0 then
      return vim.api.nvim_get_current_buf()
    end

    local ok, buf = pcall(vim.api.nvim_win_get_buf, window)
    if ok then
      return buf
    end

    return vim.api.nvim_get_current_buf()
  end

  local function normalize_bufnr(bufnr)
    if type(bufnr) ~= "number" or bufnr == 0 then
      return vim.api.nvim_get_current_buf()
    end

    local ok_valid, is_valid = pcall(vim.api.nvim_buf_is_valid, bufnr)
    if ok_valid and is_valid then
      return bufnr
    end

    return vim.api.nvim_get_current_buf()
  end

  local function prefer_utf16(clients)
    for _, client in ipairs(clients) do
      if client.offset_encoding == "utf-16" then
        return "utf-16"
      end
    end
  end

  local function infer_encoding(bufnr)
    bufnr = normalize_bufnr(bufnr)
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if not clients or vim.tbl_isempty(clients) then
      return "utf-16"
    end

    local preferred = prefer_utf16(clients)
    if preferred then
      return preferred
    end

    for _, client in ipairs(clients) do
      if client.offset_encoding then
        return client.offset_encoding
      end
    end

    return "utf-16"
  end

  local make_position_params = util.make_position_params
  util.make_position_params = function(window, position_encoding)
    if position_encoding == nil then
      position_encoding = infer_encoding(resolve_buf(window))
    end
    return make_position_params(window, position_encoding)
  end

  local make_range_params = util.make_range_params
  util.make_range_params = function(window, position_encoding)
    if position_encoding == nil then
      position_encoding = infer_encoding(resolve_buf(window))
    end
    return make_range_params(window, position_encoding)
  end

  local make_given_range_params = util.make_given_range_params
  util.make_given_range_params = function(start_pos, end_pos, bufnr, position_encoding)
    if position_encoding == nil then
      position_encoding = infer_encoding(bufnr)
    end
    return make_given_range_params(start_pos, end_pos, bufnr, position_encoding)
  end
end

return M
