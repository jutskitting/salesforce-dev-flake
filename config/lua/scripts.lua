vim.api.nvim_exec([[
    au! BufRead,BufNewFile *.component setfiletype html
    au! BufRead,BufNewFile *.cls set filetype=java
    au! BufRead,BufNewFile *.cmp set filetype=html
    au! BufRead,BufNewFile *.trigger set filetype=java
    au! BufRead,BufNewFile *.page set filetype=java
]], false)


-- Global debug flag
_G.AI_DEBUG = false

-- Debug print function
local function debug_print(...)
    if _G.AI_DEBUG then
        print(...)
    end
end

local function get_filetype()
    return vim.bo.filetype
end
local function estimate_tokens_and_cost(input_text, output_text)
    -- Rough estimation: 1 token ≈ 4 characters
    local input_tokens = math.ceil(#input_text / 4)
    local output_tokens = math.ceil(#output_text / 4)
    
    -- Calculate cost
    local input_cost = (input_tokens / 1000000) * 3  -- $3 per million input tokens
    local output_cost = (output_tokens / 1000000) * 15  -- $15 per million output tokens
    local total_cost = input_cost + output_cost
    
    return input_tokens, output_tokens, total_cost
end

local function send_to_claude(text, filetype)
    local api_key = os.getenv("CLAUDE_API_KEY")
    if not api_key then
        debug_print("CLAUDE_API_KEY not found in environment variables")
        return nil
    end

    local intro_message = "The response you give will be directly input into an editor, so format it as if that were the case. Admonish me if I ever send you code that you could see as being proprietary. Focus on code generation rather than feedback, unless explicitly asked for review."
    
    local prompt = string.format("%s\n\nGenerate code in %s for the following request:\n\n%s", intro_message, filetype, text)
    
    -- Create a table with the request structure
    local request_body = {
        model = "claude-3-sonnet-20240229",
        max_tokens = 1024,
        messages = {
            {
                role = "user",
                content = prompt
            }
        }
    }

    -- Encode the entire request body as JSON
    local json_body = vim.fn.json_encode(request_body)

    local curl_command = string.format(
        "curl -s -X POST https://api.anthropic.com/v1/messages " ..
        "-H 'Content-Type: application/json' " ..
        "-H 'x-api-key: %s' " ..
        "-H 'anthropic-version: 2023-06-01' " ..
        "-d '%s'",
        api_key,
        json_body:gsub("'", "'\\''") -- Escape single quotes for shell
    )

    debug_print("Curl command:", curl_command)

    local handle = io.popen(curl_command)
    local result = handle:read("*a")
    handle:close()

    debug_print("Raw response:", result)

    local ok, response = pcall(vim.fn.json_decode, result)
    if not ok then
        debug_print("Failed to parse JSON:", response)
        return nil
    end

    if response.error then
        debug_print("API returned an error:", vim.inspect(response.error))
        return nil
    end

    debug_print("Parsed response:", vim.inspect(response))

    if response and response.content and response.content[1] and response.content[1].type == "text" then
        return response.content[1].text
    else
        debug_print("Unexpected response structure")
        debug_print(vim.inspect(response))
        return nil
    end
end

local function extract_code(response)
    debug_print("Extracting code from response:", response)
    -- Look for code blocks with or without language specifier
    local code = response:match("```[%w+]*%s*(.-)%s*```")
    if code then
        debug_print("Extracted code:", code)
        return code
    else
        -- If no code block found, try to extract just the code statement
        code = response:match("print%([^)]+%)")
        if code then
            debug_print("Extracted code statement:", code)
            return code
        else
            -- If no code block or statement found, return the entire response
            debug_print("No code block or statement found, returning entire response")
            return response
        end
    end
end

local function process_selected_text()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    if start_pos[2] > end_pos[2] or (start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3]) then
        start_pos, end_pos = end_pos, start_pos
    end

    local lines = vim.fn.getline(start_pos[2], end_pos[2])
    if #lines == 0 then
        debug_print("No text selected")
        return
    end

    if start_pos[2] == end_pos[2] then
        lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
    else
        lines[1] = string.sub(lines[1], start_pos[3])
        lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
    end

    local selected_text = table.concat(lines, "\n")
    local filetype = get_filetype()

    debug_print("Selected text:", selected_text)
    debug_print("Current filetype:", filetype)

    local claude_response = send_to_claude(selected_text, filetype)

    if claude_response then
        debug_print("Claude's response:", claude_response)
        local code_response = extract_code(claude_response)
        if code_response and code_response ~= "" then
            local input_tokens, output_tokens, total_cost = estimate_tokens_and_cost(selected_text, claude_response)
            local cost_in_cents = total_cost * 100
            local header = string.format("-- Generated code here:\n-- Estimated input tokens: %d\n-- Estimated output tokens: %d\n-- Estimated cost: %.2f cents\n\n", 
                input_tokens, output_tokens, cost_in_cents)
            local response_lines = vim.split(header .. code_response, "\n")
            vim.api.nvim_buf_set_lines(0, end_pos[2], end_pos[2], false, response_lines)
            debug_print("Inserted response into buffer")
        else
            debug_print("Extracted code was empty, nothing inserted into buffer")
        end
    else
        debug_print("No response received from Claude")
    end
end

-- Wrapper function to enable debug mode
local function process_selected_text_debug()
    _G.AI_DEBUG = true
    process_selected_text()
    _G.AI_DEBUG = false
end

-- Create Neovim commands
vim.api.nvim_create_user_command('AI', function()
    process_selected_text()
end, { range = true, nargs = 0 })

vim.api.nvim_create_user_command('AIDebug', function()
    process_selected_text_debug()
end, { range = true, nargs = 0 })
