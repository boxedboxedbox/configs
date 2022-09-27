opts = {
    file_types = {"c", "cpp", "h", "hpp"},
    locations = {"../include", "."},
    c = {"h"},
    h = {"c", "cpp"},
    cpp = {"hpp", "h"},
    hpp = {"cpp"},
}

function check_exists(file_name)
    local fp = io.open(file_name, "r")
    
    if fp == nil
    then
        return false
    else
        io.close(fp)
        return true
    end
end

function edit_file(file)
    vim.cmd(":e "..file)
end

function split_remove_build(s)
    result = {}
    str = ""

    -- split
    for match in (s.."/"):gmatch("(.-)".."/")
    do
        -- remove
        if(match == "..")
        then
            table.remove(result)
        else
            table.insert(result, match)
        end
    end

    -- build
    for _,v in pairs(result)
    do
        str = str.."/"..v
    end

    return str
end

M = {}

--[[ function M.setup(config)
    opts = config or opts
end]]

function M.switch_files()
    local ft = vim.fn.expand("%:e")
    local fn = vim.fn.expand("%:t:r")

    for _,file_type in pairs(opts.file_types)
    do
        if(file_type == ft)
        then
            for _,cp in pairs(opts[ft])
            do
                for _,l in pairs(opts.locations)
                do
                    if(l == ".")
                    then
                        local file = os.getenv("PWD").."/"..fn.."."..cp

                        if(check_exists(file))
                        then
                            edit_file(file)
                            return
                        end
                    elseif(string.find(l, ".."))
                    then
                        local file = split_remove_build(os.getenv("PWD").."/"..l.."/"..fn.."."..cp)

                        if(check_exists(file))
                        then
                            edit_file(file)
                            return
                        end
                    else
                        local file = os.getenv("PWD").."/"..l.."/"..fn.."."..cp
                        if(check_exists(file))
                        then
                            edit_file(file)
                        end
                    end
                end
            end
        end
    end
end

return M
