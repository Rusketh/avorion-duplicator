--Package

package.path = package.path .. ";data/scripts/lib/?.lua"

-- Begin

Util = { };

--Import Util Libraries

Util.Arguments = include("data/scripts/lib/duplicator/arguments");

--Flags

Util.Arguments.Flags = function()
	
	local _defaults = { };

	local _flags = { };

	local _all = { };

	return function(type, name, ...)

		local flag = { name = name, type = type, func = Util.Arguments[type] };

		_flags[name] = flag;

		for _, alias in pairs({ name, ... }) do

			_all[alias] = flag;

		end

		return function(description, default)
			flag.description, flag.default = description, default;

			_defaults[flag.name] = default;
		end

	end, function(sender, args)

		local values = { };

		local duplicates = { };

		for k, v in pairs(_defaults) do

			values[k] = v;

		end

		while (true) do

			local key = Util.Arguments.String(sender, args);

			if (not key or key == "") then break; end

			local flag = _all[key];

			if (not flag) then return nil, "Invalid flag '" .. key .. "'"; end

			if (duplicates[flag.name]) then return nil, "Duplicate flag '" .. key .. "'"; end 

			local value, error = flag.func(sender, args);

			if (error) then return nil, "Invalid use of flag '" .. key .. "', " .. err; end

			if (value == nil) then return nil, "Invalid use of flag '" .. key .. "', No value defined"; end

			values[key] = value;

			duplicates[flag.name] = true;

		end

		return values;

	end, function(format, format2)
		
		format = format or " - %s: %s";

		format2 = format2 or "%s, '%s' by default.";

		local lines = { };

		for _, flag in pairs(_flags) do

			local line = string.format(format, flag.name, flag.description or "");

			if (flag.default ~= nil) then line = string.format(format2, line, tostring(flag.default)); end
			
			lines[#lines+1] = line;

		end

		return table.concat( lines, "\n");

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