--Package

package.path = package.path .. ";data/scripts/lib/?.lua"

-- Begin

Util = { };

--Import Util Libraries

Util.Arguments = include("data/scripts/lib/duplicator/arguments");

--Flags

Util.Arguments.Flags = function()
	
	local _all = { };

	return function(type, name, ...)

		local flag = { name = name, type = type, func = Util.Arguments[type] };

		for _, alias in pairs({ name, ... }) do

			_all[alias] = flag;

		end

	end, function(sender, args)

		local values = { };

		while (true) do

			local key = Util.Arguments.String(sender, args);

			if (not key or key == "") then break; end

			local flag = _all[key];

			if (not flag) then return nil, "Invalid flag '" .. key .. "'"; end

			if (values[flag.name] ~= nil) then return nil, "Duplicate flag '" .. key .. "'"; end 

			local value, error = flag.func(sender, args);

			if (error) then return nil, "Invalid use of flag '" .. key .. "', " .. err; end

			if (value == nil) then return nil, "Invalid use of flag '" .. key .. "', No value defined"; end

			values[key] = value;

		end

		return values;

	end;

end

--Chat Messages

Util.SendMessage = function(sender, from, type, message, ...)

	local player = Player(sender);

	if (not player) then

		print(message, ...);

	else

		player:sendChatMessage(from, type, message, ...);

	end

end

--Exports

return Util;