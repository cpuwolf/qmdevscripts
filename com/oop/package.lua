-- Is the first letter uppercase?
local function isFirstUpper(str)
	local first = str:sub(1,1) 
	return first == first:upper()-- and first:match('%a')
end

-- Split string
local function splitString(str, delimiter)
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find( str, delimiter, from, true  )
  while delim_from do
    table.insert( result, string.sub( str, from , delim_from-1 ) )
    from  = delim_to + 1
    delim_from, delim_to = string.find( str, delimiter, from , true )
  end
  table.insert( result, string.sub( str, from  ) )
  return result
end

local setMeta = function(package, packageName)
	local mt={}
	mt.__index=function(table, key)
		-- Load file by package name and class name
		local got
		if packageName then
			got = require(packageName..'.'..key)
		-- If not uppercase, return nil immediately
		elseif not isFirstUpper(key) then 
			return nil
		else
			if key ~= "_PROMPT" then
				got = require(key)
			end
		end
		---- Result must be a table
		--if type(got)~='table' then
		--	print(packageName, key, 'not found')
		--	return nil
		--end
		-- Set package name and class name
		if type(got)=='table' and got.setClassData~=nil then
			if packageName then
				got:setClassData('package_name', packageName)
			end
			got:setClassData('class_name', key)
		end
		-- Put into package
		package[key] = got
		return got
	end

	setmetatable(package, mt)
end


-- Define package
local function package(name)
	-- A package is also a table
	local package = {}
	setMeta(package,name)
	local parts = splitString(name, '.')
	local var=_G
	for i=1, #parts-1 do 
		var = var[parts[i]]
	end
	var[parts[#parts]] = package
end

-- Make _G a package as well
setMeta(_G)


return package
