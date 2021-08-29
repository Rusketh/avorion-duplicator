--Package

package.path = package.path .. ";data/scripts/lib/?.lua"

--Import Duplicator

Duplicator = include("data/scripts/lib/duplicator/core");

--Flags

DefineFlag, ParseFlags, FlagHelper = Duplicator.Util.Arguments.Flags();

--Flags: Copy Content

DefineFlag("Bool", "crew", "staff") ("If set to true, generalization will include the ship crew.", true);
DefineFlag("Bool", "upgrades", "systems") ("If set to true, generalization will include the ships installed upgrades.", true);
DefineFlag("Bool", "turrets", "weapons", "guns") ("If set to true, generalization will include the ships installed weapons.", true);
DefineFlag("Bool", "torpedoes", "warheads", "bombs", "nukes") ("If set to true, generalization will include the ships torpedo shaft contents.", false);
DefineFlag("Bool", "fighters", "shuttles", "jets") ("If set to true, generalization will include the ships fighter squads and hangar bay contents.", true);
DefineFlag("Bool", "cargo", "stuff", "items", "inventory", "goods") ("If set to true, generalization will include the ships cargo hangar content.", false);
DefineFlag("Bool", "icon") ("If set to true, generalization will include the ships chosen icon.", false);
DefineFlag("Bool", "title", "class") ("If set to true, generalization will include the ships class name.", false);

--Command Function

return function(sender, commandName, ...)

	local args = { ... };

	--Get the player who will own this object.

	local player = Player(Sender);

	--Get a list fo crafts to generalize.

	local targets = Duplicator.Util.Arguments.CraftList(sender, args);

	if (player and not targets[1]) then

		if (player.craft and player.craft.selectedObject) then

			targets = { player.craft.selectedObject };

		end

	end

	if (not targets[1]) then return 0, "", "No craft selected to generalize"; end

	-- Parse flags

	local flags, error = ParseFlags(sender, args);

	if (error) then return 0, "", error; end

	local names = { };

	for _, canvas in pairs( targets ) do

		if (flags.crew) then
			Duplicator.Crew.Clear(player, canvas);
		end

		if (flags.upgrades) then
			Duplicator.Upgrades.Clear(player, canvas);
		end

		if (flags.turrets) then
			Duplicator.Turrets.Clear(player, canvas);
		end

		if (flags.torpedoes) then
			Duplicator.Torpedoes.Clear(player, canvas);
		end

		if (flags.fighters) then
			Duplicator.Fighters.Clear(player, canvas);
		end

		if (flags.cargo) then
			Duplicator.Cargo.Clear(player, canvas);
		end

		if (flags.icon) then
			Duplicator.Icon.Clear(player, canvas);
		end

		if (flags.title) then
			Duplicator.Title.Clear(player, canvas);
		end

		names[#names+1] = "'" .. canvas.name .. "'";

	end

	return 1, "", "Finished: Generalized " .. table.concat(names, ", ");

end, FlagHelper;