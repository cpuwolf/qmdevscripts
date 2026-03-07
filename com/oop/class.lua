local Object = require 'com.oop.Object'


local function class(...)
	local cls = {}
	local comps = {}

	-- Object's metatable
	cls.__objmt = {__index=cls, __class=cls}
	-- Class data, currently only stores package name and class name
	cls.__classData = {}
	-- Base classes
	cls.__components = comps

	Object.inherit(cls, Object, ...)
	return cls
end

return class
