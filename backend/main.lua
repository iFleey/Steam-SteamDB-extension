local json = require('json')
local http = require('http')
local logger = require('logger')
local millennium = require('millennium')
local fs = require('fs')

local WEBKIT_CSS_FILE = 'public/steamdb-webkit.css'
local API_URL = 'https://extension.steamdb.info/api'

local DEFAULT_HEADERS = {
    Accept = 'application/json',
    ['X-Requested-With'] = 'SteamDB',
    ['User-Agent'] = 'https://github.com/iFleey/Steam-SteamDB-extension',
    Origin = 'https://github.com/iFleey/Steam-SteamDB-extension',
    ['Sec-Fetch-Dest'] = 'empty',
    ['Sec-Fetch-Mode'] = 'cors',
    ['Sec-Fetch-Site'] = 'cross-site',
}

local css_hook_id = nil

local function urlencode(value)
    local encoded = tostring(value)
    encoded = encoded:gsub('\n', '\r\n')
    encoded = encoded:gsub('([^%w%-_%.~])', function(char)
        return string.format('%%%02X', string.byte(char))
    end)
    return encoded
end

local function encode_query(params)
    local parts = {}
    for key, value in pairs(params) do
        parts[#parts + 1] = urlencode(key) .. '=' .. urlencode(value)
    end
    return table.concat(parts, '&')
end

local function request(endpoint, params)
    local query = encode_query(params)
    local url = API_URL .. endpoint
    if query ~= '' then
        url = url .. '?' .. query
    end

    local response, err = http.get(url, {
        headers = DEFAULT_HEADERS,
        timeout = 30,
        follow_redirects = true,
        verify_ssl = true,
    })

    if response == nil then
        local reason = err or 'No response'
        return json.encode({
            success = false,
            error = tostring(reason),
        })
    end

    if response.status < 200 or response.status >= 300 then
        return json.encode({
            success = false,
            error = string.format('HTTP %d %s', response.status, response.body or ''),
        })
    end

    return response.body or '{}'
end

local function get_plugin_root()
    local backend_root = MILLENNIUM_PLUGIN_SECRET_BACKEND_ABSOLUTE or '.'
    local absolute_root = fs.absolute(backend_root .. '/..')
    if absolute_root == nil then
        return backend_root .. '/..'
    end
    return absolute_root
end

local function apply_webkit_css()
    local css_path = get_plugin_root() .. '/' .. WEBKIT_CSS_FILE
    local absolute_css_path = fs.absolute(css_path)

    if absolute_css_path == nil then
        logger:error('Failed to resolve SteamDB webkit css path: ' .. css_path)
        return
    end

    if css_hook_id ~= nil then
        millennium.remove_browser_module(css_hook_id)
    end

    css_hook_id = millennium.add_browser_css(absolute_css_path)

    if css_hook_id == nil or css_hook_id < 0 then
        logger:error('Failed to register SteamDB webkit css: ' .. absolute_css_path)
        return
    end

    logger:info('Applied SteamDB webkit css: ' .. absolute_css_path)
end

function GetApp(appid, _contentScriptQuery)
    logger:info('Getting app info for ' .. tostring(appid))
    return request('/ExtensionApp/', {
        appid = tonumber(appid) or appid,
    })
end

function GetAppPrice(appid, currency, _contentScriptQuery)
    logger:info('Getting app price for ' .. tostring(appid) .. ' in ' .. tostring(currency))
    return request('/ExtensionAppPrice/', {
        appid = tonumber(appid) or appid,
        currency = currency or '',
    })
end

function GetAchievementsGroups(appid, _contentScriptQuery)
    logger:info('Getting achievements groups for ' .. tostring(appid))
    return request('/ExtensionGetAchievements/', {
        appid = tonumber(appid) or appid,
    })
end

function SteamDB_LogWarn(message)
    logger:warn(tostring(message))
end

function SteamDB_LogError(message)
    logger:error(tostring(message))
end

local plugin = {}

function plugin.on_frontend_loaded()
    apply_webkit_css()
end

function plugin.on_load()
    logger:info('Bootstrapping SteamDB plugin, Millennium ' .. tostring(millennium.version()))
    apply_webkit_css()
    millennium.ready()
end

function plugin.on_unload()
    logger:info('Unloading SteamDB plugin')
    if css_hook_id ~= nil then
        local ok, err = pcall(millennium.remove_browser_module, css_hook_id)
        if not ok then
            local message = tostring(err)
            if not string.find(message, "Failed to contact Millennium's plugin loader", 1, true) then
                logger:warn('Failed to remove SteamDB css hook during unload: ' .. message)
            end
        end
        css_hook_id = nil
    end
end

return plugin
