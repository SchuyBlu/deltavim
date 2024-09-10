local function close_all_buffers_except_current()
    local current_buf_num = vim.api.nvim_get_current_buf()
    local buffers = vim.api.nvim_list_bufs()

    for _, buf_num in ipairs(buffers) do
        if
            vim.api.nvim_buf_is_loaded(buf_num)
            and vim.api.nvim_buf_is_valid(buf_num)
            and buf_num ~= current_buf_num
        then
            local buftype = vim.bo[buf_num].buftype
            if buftype ~= "terminal" then
                vim.api.nvim_buf_delete(buf_num, { force = false })
            end
        end
    end
end

vim.api.nvim_create_user_command("Bonly", close_all_buffers_except_current, {})
