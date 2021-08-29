--Package

package.path = package.path .. ";data/scripts/lib/?.lua"

--Import Duplicator

Duplicator = include("data/scripts/lib/duplicator/core");

--Flags

DefineFlag, ParseFlags = Util.Arguments.Flags();

--Flags: Copy Content

DefineFlag("Bool", "scripts");
DefineFlag("Bool", "crew", "staff");
DefineFlag("Bool", "upgrades", "systems");
DefineFlag("Bool", "turrets", "weapons", "guns");
DefineFlag("Bool", "torpedoes", "warheads", "bombs", "nukes");
DefineFlag("Bool", "fighters", "shuttles", "jets");
DefineFlag("Bool", "cargo", "stuff", "items", "inventory", "goods");
DefineFlag("Bool", "icon");
DefineFlag("Bool", "title", "class");
DefineFlag("Bool", "exact", "everything", "all");

--Flags: Other

DefineFlag("Number", "offset", "off");
DefineFlag("Bool", "alliance", "faction");
DefineFlag("Direction", "direction", "dir");
DefineFlag("Craft", "target", "craft", "ship", "entity", "select", "object");

--Command Function

return function(sender, commandName, ...)

	local args = { ... };

	--Get a list of ship names, these will be the duplicates.

	local names = Duplicator.Util.Arguments.List(sender, args);

	if (not names or not names[1]) then
		return Arguments.Error(1, "No name for duplicated ship provided.");
	end

	--Parse the paramaters of the command (flags).

	local flags, error = ParseFlags(sender, args);

	if (error) then return 0, "", error; end

	--Set up options for duplication.

	local options = { };

	options.Scripts = true;
	if (flags.scripts ~= nil) then options.Scripts = flags.scripts; end

	options.Crew = false;
	if (flags.crew ~= nil) then options.Crew = flags.crew; end

	options.Upgrades = false;
	if (flags.upgrades ~= nil) then options.Upgrades = flags.upgrades; end

	options.Turrets = false;
	if (flags.turrets ~= nil) then options.Turrets = flags.turrets; end

	options.Torpedoes = false;
	if (flags.torpedoes ~= nil) then options.Torpedoes = flags.torpedoes; end

	options.Fighters = false;
	if (flags.fighters ~= nil) then options.Fighters = flags.fighters; end

	options.Cargo = false;
	if (flags.cargo ~= nil) then options.Cargo = flags.cargo; end

	options.Icon = true;
	if (flags.icon ~= nil) then options.Icon = flags.icon; end

	options.Title = true;
	if (flags.title ~= nil) then options.Title = flags.title; end

	if (flags.exact) then
		options.Scripts = true;
		options.Crew = true;
		options.Upgrades = true;
		options.Turrets = true;
		options.Torpedoes = true;
		options.Fighters = true;
		options.Cargo = true;
		options.Icon = true;
		options.Title = true;
	end

	--Get the player who will own this object.

	local player = Player(Sender);

	--Get wether the owner will be the player or the alince

	local owner = player;

	if (flags.alliance) then

		if (not owner) then return 0, "", "Unable to obtain alliance to own duplicated ship, No player selected"; end

		if (not owner.alliance) then return 0, "", "Unable to obtain alliance to own duplicated ship, selected player is not in an alliance"; end

		owner = owner.alliance;

	end

	if (not owner) then return 0, "", "No player selected, to own duplicated ship"; end

	--Get the entity to be cloned.

	local craft = flags.target;

	if (player and not craft) then

		craft = player.craft;

		if (craft and craft.selectedObject) then

			craft = craft.selectedObject;

		end

	end

	if (not craft) then return 0, "", "No craft selected for duplication"; end

	--Calculate the directional offsets for placing down the duplicate ships

	local offset = flags.offset or 0;

	local amv = vec3( -1, -1, -1 );

	local dir = flags.direction or "forward";

	local direction = craft.position.look;

	local step = craft.size.y + offset;

	if (dir == "right") then

		direction = craft.position.right;

		step = craft.size.x + offset;

	elseif (dir == "backward") then

		direction = craft.position.look * amv;

		step = -(craft.size.x + offset);

	elseif (dir == "left") then

		direction = craft.position.right * amv;

		step = -(craft.size.y + offset);

	elseif (dir == "up") then

		direction = craft.position.up;

		step = craft.size.z + offset;

	elseif (dir == "down") then

		direction = craft.position.up * amv;

		step = -(craft.size.z + offset);

	end
	
	--Spawn Dupliacte Ships

	local ships = { };

	local pos = craft.position.pos;

	for _, name in pairs(names) do

		local position = pos + (direction * step);

		local ok, ship = Duplicator.Ship.Duplicate(craft, owner, name, position, options);

		if (not ok) then
			
			Util.SendMessage(sender, "", 0, "Failed to spawn duplicate '" .. name .. "' of '" .. craft.name .. "', " .. ship);
		
		else

			pos = position;

			Util.SendMessage(sender, "", 0, "Spawned duplicate '" .. name .. "' of '" .. craft.name .. "'");

			ships[#ships+1] = ship;

		end

	end

	return 1, "", "Finished: spawned " .. #ships .. " / " .. #names .. " duplicates of '" .. craft.name .. "'";

end