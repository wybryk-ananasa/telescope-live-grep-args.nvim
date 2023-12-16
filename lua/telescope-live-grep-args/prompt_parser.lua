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

function replace( str )
    local result = str:gsub( "\"", "\\\"" )
    result = result:gsub( "(", "\\(" )
    result = result:gsub( ")", "\\)" )
    return result
end

M.parse = function( prompt, autoquote )
    if string.len( prompt ) == 0 then
        return {}
    end

    local pattern, params = string.match( prompt, "(.*)%s%-%-%s(.*)" )
    local parts = {}

    if pattern and params then
        local params = split_string( params, " " )
        pattern = pattern:gsub( "\"", ".*" )
        table.insert( parts, replace( pattern ) )
        concat( parts, params )
    else
        table.insert( parts, replace( pattern ) )
    end

    for i, part in ipairs( parts ) do
        print( "part " .. tostring( i ) .. ": " .. part )
    end

    return parts
end

return M
