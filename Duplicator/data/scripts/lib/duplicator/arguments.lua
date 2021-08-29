--Package

package.path = package.path .. ";data/scripts/lib/?.lua"

-- Begin

Arguments = { };

-- Bool

Arguments.Bool = function(sender, args)
	
	local str = table.remove(args, 1);

	if (not str or str == "") then return; end

	if (str == "y" or str == "yes" or str == "t" or str == "true" or str == "1") then return true; end

	if (str == "n" or str == "no" or str == "f" or str == "false" or str == "0") then return true; end

	return nil, "y/n expected got " .. str;
end

-- number

Arguments.Number = function(sender, args)
	
	local str = table.remove(args, 1);

	if (not str or str == "") then return; end

	local num = tonumber(str);

	if (num) then return num; end

	return nil, "number expected got " .. str;
end

-- String

Arguments.String = function(sender, args, sep)
    
    local str = table.remove(args, 1);
    
    if (not str) then return; end
    
    local char = string.sub(str, 1, 1);
    
    if (not (char == "'" or char == "\"")) then

    	if (sep and sep == string.sub(str, -1)) then
    		return string.sub(str, 1, -2), true;
    	end

    	return str;

    end
    
    local sperated;
    
    local buf = { string.sub(str, 2); };
    
    while (true) do
        
        local str = table.remove(args, 1);
        
        if (not str or str == "") then break; end
    
        local last = string.sub(str, -1);
        
        if (last == char) then
            
            buf[#buf + 1] = string.sub(str, 1, -2);
            
            break;
            
        end
        
        if (sep and last == sep) then
            
            local snd = string.sub(str, -2, -2);
            
            if (snd == char) then
                
                buf[#buf + 1] = string.sub(str, 1, -3);
                
                sperated = true;
                
                break;
                
            end
                
        end
        
        buf[#buf + 1] = str;
        
    end
    
    return table.concat(buf, " "), sperated;
    
end
   
--List

Arguments.List = function(sender, args, sep)
    
    sep = sep or ",";

    local list = { };

    while (true) do
        
        local str, sperated = Arguments.String(sender, args, sep);
        
        if (not str) then break; end
        
        list[#list+1] = str;
        
        if (not sperated) then break; end
        
    end
        
    return list;
    
end
   
--Direction

Arguments.Direction = function(sender, args)
	
	local str = table.remove(args, 1);

	if (not str or str == "") then return; end

	if (str == "f" or str == "forward" or str == "0") then return "forward"; end

	if (str == "r" or str == "right" or str == "1") then return "right"; end

	if (str == "b" or str == "backward" or str == "2") then return "backward"; end

	if (str == "l" or str == "left" or str == "3") then return "left"; end

	if (str == "u" or str == "up" or str == "4") then return "up"; end

	if (str == "d" or str == "down" or str == "5") then return "down"; end

	return nil, "f/r/b/l/u/d expected got " .. str;
end

--Craft

Arguments.Craft = function(sender, args)
	
	local str, err = Arguments.String(sender, args);

	if (not str or str == "") then return; end

	local player = Player(sender);

	if (not player) then return nil, "Target can not be aquired by none player."; end

	local craft = player.craft;

	if (not craft) then return nil, "Target can not be aquired whilst player is not inside a craft."; end

	if (str == "m" or str == "me" or str == "self" or str == "craft") then return craft; end

	if (str == "t" or str == "this" or str == "that" or str == "target" or str == "selected") then

		craft = craft.selectedObject;

		if (not craft) then return nil, "Target can not be aquired, no target is selected."; end

		return craft;

	end

	for _, ship in pairs( { Sector():getEntitiesByType(1) } ) do

		if (str == ship.name) then

			return ship;

		end

	end

	return nil, "Target '" .. str .. "' does not exist in sector.";

end

--Error

Arguments.Error = function(i, msg, a, ...)

	if (a) then msg = string.format(a, ...); end

	return 0, "", string.format("#%i - %s", i, msg);
end

--Exports

return Arguments;


