--Package

package.path = package.path .. ";data/scripts/lib/?.lua"

--Import Duplicator

Duplicator = include("data/scripts/lib/duplicator/core");

--Flags

DefineFlag, ParseFlags, FlagHelper = Duplicator.Util.Arguments.Flags();

--Flags: Copy Content

--DefineFlag("Bool", "scripts") ("If set to true, duplication will include the entity's scripts (Only use if you know what your doing).", true);
DefineFlag("Bool", "crew", "staff") ("If set to true, duplication will include the ship crew.", false);
DefineFlag("Bool", "upgrades", "systems") ("If set to true, duplication will include the ships installed upgrades.", false);
DefineFlag("Bool", "turrets", "weapons", "guns") ("If set to true, duplication will include the ships installed weapons.", false);
DefineFlag("Bool", "torpedoes", "warheads", "bombs", "nukes") ("If set to true, duplication will include the ships torpedo shaft contents.", false);
DefineFlag("Bool", "fighters", "shuttles", "jets") ("If set to true, duplication will include the ships fighter squads and hangar bay contents.", false);
DefineFlag("Bool", "cargo", "stuff", "items", "inventory", "goods") ("If set to true, duplication will include the ships cargo hangar content.", false);
DefineFlag("Bool", "icon") ("If set to true, duplication will include the ships chosen icon.", false);
DefineFlag("Bool", "title", "class") ("If set to true, duplication will include the ships class name.", false);
DefineFlag("Bool", "exact", "everything", "all") ("if set to true the ship will be duplicated exactly with turrets, crew, systems etc.", false);

--Flags: Other

DefineFlag("Number", "offset", "off") ("The amount of additional space between the duplicated ships, when placed.");
DefineFlag("Bool", "alliance", "faction") ("If set to true, the duplicates will be owned by the players alliance.");
DefineFlag("Direction", "direction", "dir") ("The direction in witch to line up the duplicated ships.", false);
DefineFlag("Craft", "target", "craft", "ship", "entity", "select", "object") ("The ship or entity to duplicate.");

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

	options.Scripts = flags.exact or flags.scripts;
	options.Crew = flags.exact or flags.crew;
	options.Upgrades = flags.exact or flags.upgrades;
	options.Turrets = flags.exact or flags.turrets;
	options.Torpedoes = flags.exact or flags.torpedoes;
	options.Fighters = flags.exact or flags.fighters;
	options.Cargo = flags.exact or flags.cargo;
	options.Icon = flags.exact or flags.icon;
	options.Title = flags.exact or flags.title;

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

	local step = craft.size.x + offset + 1;

	if (dir == "right") then

		direction = craft.position.right;

		step = craft.size.y + offset + 1;

	elseif (dir == "backward") then

		direction = craft.position.look * amv;

		step = -(craft.size.y + offset + 1);

	elseif (dir == "left") then

		direction = craft.position.right * amv;

		step = -(craft.size.x + offset + 1);

	elseif (dir == "up") then

		direction = craft.position.up;

		step = craft.size.z + offset + 1;

	elseif (dir == "down") then

		direction = craft.position.up * amv;

		step = -(craft.size.z + offset + 1);

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

			clone.orientation = ship.orientation;

			Util.SendMessage(sender, "", 0, "Spawned duplicate '" .. name .. "' of '" .. craft.name .. "'");

			ships[#ships+1] = ship;

		end

	end

	return 1, "", "Finished: spawned " .. #ships .. " / " .. #names .. " duplicates of '" .. craft.name .. "'";

end, FlagHelper;