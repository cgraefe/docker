local json = require ("dkjson")
local driver = require ("luasql.mysql")
local env = assert(driver.mysql())

local MYSQL_DB = os.getenv('MYSQL_DB') or "owntracks"
local MYSQL_USER = os.getenv('MYSQL_USER') or "owntracks"
local MYSQL_PASSWORD = os.getenv('MYSQL_PASSWORD') or ""
local MYSQL_HOST = os.getenv('MYSQL_HOST') or "mysql"
local MYSQL_PORT = os.getenv('MYSQL_PORT') or 3306

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function otr_init()
	otr.log("mysql.lua starting; using mysql server on host " .. MYSQL_HOST)
end

function otr_hook(topic, _type, data)
	if _type == "location" then
	    local con, res, err
        con, err = env:connect(MYSQL_DB, MYSQL_USER, MYSQL_PASSWORD, MYSQL_HOST, MYSQL_PORT)
        if con then
          res, err = con:execute(string.format([[
            INSERT INTO location (topic, username, device, lat, lon, tst, acc, batt, revgeo, json) 
            VALUES ('%s', '%s', '%s', %f, %f, FROM_UNIXTIME(%d), %d, %d, '%s', '%s')]], 
            topic, data['username'], data['device'], data['lat'], data['lon'], data['tst'], data['acc'], data['batt'], data['addr'], json.encode(data, { indent = false })))
          if res then
            otr.log("Location written to mysql, id: " .. con:getlastautoid())      
          else
            otr.log(err)
          end
          con:close()
        else
          otr.log("Failed to connect to mysql server: " .. err)
        end
	end
end

function otr_exit()
end

