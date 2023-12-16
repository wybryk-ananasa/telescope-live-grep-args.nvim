-- SPDX-FileCopyrightText: 2021 Michael Weimann <mail@michael-weimann.eu>
--
-- SPDX-License-Identifier: MIT

local M = {}

function split_string( inputstr, sep )
    if sep == nil then
        sep = "%s"
    end
    local result = {}
    for str in string.gmatch( inputstr, "([^" .. sep .. "]+)" ) do
        table.insert( result, str )
    end
    return result
end

function concat( t1, t2 )
    for i = 1, #t2 do
        t1[ #t1 + 1 ] = t2[ i ]
    end
    return t1
end

M.parse = function( prompt, autoquote )
    if string.len( prompt ) == 0 then
        return {}
    end

    local separator = " -- "
    local parts = split_string( prompt, separator )

    if #parts > 1 then
        local second = table.remove( parts, 2 )
        local params = split_string( second, " " )
        concat( parts, params )
    end

    return parts
end

return M
