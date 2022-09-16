local fterm = require("FTerm")

M = {}

-- # means the current file
-- Syntax of the command: "nil" | program n ( arguments | "#" ) 
opts = {
    -- List of compiled languages (expects run_release, build_release and build_debug on languages of this list)
    is_compiled = {"rust", "c", "cpp"},
    -- List of interpreted languages..
    is_interpreted = {"python", "lua"},
    -- Commands to run the tests for the program.
    testing = {
        rust = "cargo test",
    },
    rust = {
        run_debug = "cargo run",
        run_release = "cargo run --release",
        build_debug = "cargo build",
        build_release = "cargo build --release",
    },
    c = {
        run_debug = nil,
        run_release = nil,
        build_debug = "make",
        build_release = "make build",
    },
    cpp = {
        run_debug = nil,
        run_release = nil,
        build_debug = "make",
        build_release = "make build",
    },
    python = {
        run = "python #"
    },
}

function split(str)
    local res = {}

    for i in string.gmatch(str, "[^%s]+")
    do
        table.insert(res, i)
    end

    return res
end

function parse_command(str)
    local res = {}

    for _,i in pairs(split(str))
    do
        if(i == "#")
        then
            table.insert(res, vim.fn.expand("%:t"))
        else
            table.insert(res, i)
        end
    end

    return res
end

-- Argument must be nil, an empty string ("") or "release".
function M.run(mode)
    local ft = vim.bo.filetype

    if(opts[ft] == nil)
    then
        return
    end

    local command = nil

    for _,i in pairs(opts.is_compiled)
    do
        if(ft == i)
        then
            if(mode == "release")
            then
                command = opts[ft].run_release
            elseif(mode == "" or mode == nil)
            then
                command = opts[ft].run_debug
            end
        end
    end

    for _,i in pairs(opts.is_interpreted)
    do
        if(ft == i)
        then
            command = opts[ft].run
        end
    end
    
    fterm.scratch({cmd = parse_command(command)})
end

function M.build(mode)
    -- Should I do both build and run in same function, or will it be too slow?
    -- Or do I make both run and build call some function that does the heavy lifting?
    print "Not implemented yet and I'm not sure if I ever will."
end

return M
