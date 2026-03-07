local Object = {}


local function doCallInit(class, obj, ...)
	-- init of the same class cannot be called repeatedly
	local called = rawget(obj, '__initCalled')
	for _,cls in ipairs(called) do
		if cls==class then return end
	end
	local init = rawget(class, 'init')
	if init~=nil and type(init)=='function' then
		init(obj, ...)
	end
	called[#called+1] = class
end

local function callInit(class, obj, ...)
	local isCustom = rawget(class, '__customInit')
	if isCustom then
		doCallInit(class, obj, ...)
	else
		local parents = rawget(class, '__components')
		for _,comp in ipairs(parents) do
			callInit(comp, obj, ...)
		end
		doCallInit(class, obj, ...)
	end
end

local function new(class, ...)
	local obj = {__initCalled={}}
	setmetatable(obj, rawget(class, '__objmt'))
	-- Call init
	callInit(class, obj, ...)
	return obj
end

local function doCallOnDestroy(cls, obj, called)
	for _, calledClass in ipairs(called) do
		if calledClass == cls then return end
	end
	local onDestroy = rawget(cls, 'onDestroy')
	if onDestroy~=nil and type(onDestroy)=='function' then
		onDestroy(obj)
	end
	local comps = rawget(cls,'__components')
	for _,comp in ipairs(comps) do
		doCallOnDestroy(comp, obj, called)
	end
	table.insert(called, cls)
end

local function doDestroy(obj)
	local called = {}
	local cls = getmetatable(obj).__class
	doCallOnDestroy(cls, obj, called)
	obj._isDestroyed = true
end

local function isDestroyed(obj)
	return obj._isDestroyed
end

local function customInit(class)
	rawset(class, '__customInit', true)
end

local function setClassData(class, key,value)
	local data = rawget(class, '__classData')
	data[key] = value
	return class
end

local function getClassData(class, key)
	return rawget(class, '__classData')[key]
end

local function getClass(obj)
	return getmetatable(obj).__class
end

local function getClassName(obj)
	local class = getClass(obj)
	return getClassData(class, 'class_name')
end

local function getPackageName(obj)
	local class = getClass(obj)
	return getClassData(class, 'package_name')
end

local function getFullClassName(obj)
	local className = getClassName(obj)
	if not className then return nil end
	local package = getPackageName(obj)
	if not package then return className end
	return package ..'.'..className
end

local function copyFunctions(cls, comp)
	for key,value in pairs(comp) do
		if type(value) == 'function' and key~='init' and key~='onDestroy' then
			rawset(cls, key, value)
		end
	end
end

-- Add a parent class to a class; after calling this function, it affects all instances of this class
local function inherit(cls, ...)
	local arg = {...}
	for _, comp in ipairs(arg) do
		local comps = rawget(cls, '__components')
		comps[#comps+ 1] = comp
		copyFunctions(cls, comp)
	end
	return cls
end

local function initInstance(cls, ...)
	local mt = {__class=cls}
	setmetatable(cls, mt)
	cls.__initCalled = {}
	callInit(cls, cls, ...)
end

-- Add a component to an object; affects only this object
-- Following args are passed to the component's init
-- Note: init will be called here
--function Object.addClass(obj, cls, ...)
--	local comps = getmetatable(obj).__components
--	comps[#comps + 1] = cls 
--	Object.callInit(cls, obj,  ...)
--end



-- Required for normal operation
Object.__components = {}

-- Class function.
Object.new = new
-- Class function. Calls parent's init by itself
Object.inherit = inherit
-- Class function. Call this first when you need to call parent's init yourself.
Object.customInit = customInit
-- Class function. Calls parent's init by itself
Object.callInit = callInit
-- Class function. Set class custom data
Object.setClassData = setClassData
-- Class function. Get class custom data
Object.getClassData = getClassData
-- Class function. Initialize as singleton
Object.initInstance = initInstance

-- Obj function. Get class
Object.getClass = getClass
-- Obj function. Get class name
Object.getClassName = getClassName
-- Obj function. Get package name
Object.getPackgeName = getPackageName
-- Obj function. Get package name + class name
Object.getFullClassName = getFullClassName

-- Obj function.
Object.doDestroy = doDestroy
Object.isDestroyed = isDestroyed

return Object
