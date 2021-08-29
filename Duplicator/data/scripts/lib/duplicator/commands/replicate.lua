--Package

package.path = package.path .. ";data/scripts/lib/?.lua"

--Import Duplicator

Duplicator = include("data/scripts/lib/duplicator/core");

--Flags

DefineFlag, ParseFlags, FlagHelper = Duplicator.Util.Arguments.Flags();

--Flags: Copy Content

DefineFlag("Bool", "scripts") ("If set to true, replication will include the entity's scripts (Only use if you know what your doing).", false);
DefineFlag("Bool", "plan", "model", "blocks") ("If set to true, replication will include the ship design itself.", false);
DefineFlag("Bool", "crew", "staff") ("If set to true, replication will include the ship crew.", false);
DefineFlag("Bool", "upgrades", "systems") ("If set to true, replication will include the ships installed upgrades.", false);
DefineFlag("Bool", "turrets", "weapons", "guns") ("If set to true, replication will include the ships installed weapons.", false);
DefineFlag("Bool", "torpedoes", "warheads", "bombs", "nukes") ("If set to true, replication will include the ships torpedo shaft contents.", false);
DefineFlag("Bool", "fighters", "shuttles", "jets") ("If set to true, replication will include the ships fighter squads and hangar bay contents.", false);
DefineFlag("Bool", "cargo", "stuff", "items", "inventory", "goods") ("If set to true, replication will include the ships cargo hangar content.", false);
DefineFlag("Bool", "icon") ("If set to true, replication will include the ships chosen icon.", false);
DefineFlag("Bool", "title", "class") ("If set to true, replication will include the ships class name.", false);
DefineFlag("Bool", "exact", "everything", "all") ("if set to true the ship will be duplicated exactly with turrets, crew, systems etc.", false);
DefineFlag("Bool", "clear", "reset") ("if set to true the ship will be cleared before the duplication.", false);

--Flags: Other

DefineFlag("Craft", "from", "base", "template") ("The craft to replicate from.");
DefineFlag("CraftList", "to", "target", "craft", "ship", "entity", "select", "object") ("The a list of ships to replace.");

return function(sender, commandName, ...)

	local args = { ... };

	local flags, error = ParseFlags(sender, args);

	if (error) then return 0, "", error; end

	--Get the player who will own this object.

	local player = Player(Sender);

	--Get the entity to be copied.

	local from = flags.from;

	if (player and not from) then

		from = player.craft;

	end

	if (not from) then return 0, "", "No craft found to copy from"; end

	--Get the entity to copy to.

	local to = flags.to or { };

	if (player and not to[1]) then

		if (player.craft and player.craft.selectedObject) then

			to = { player.craft.selectedObject };

		end

	end

	if (not to[1]) then return 0, "", "No craft selected to copy to"; end

	local names = { };

	for _, copy in pairs( to ) do

		if (copy.id ~= from.id) then

			--Perform copy operation.

			if (flags.plan or flags.exact) then
				Duplicator.Plan.Copy(player, from, copy);
			end

			if (flags.scripts or flags.exact) then
				if (flags.clear ~= false) then Duplicator.Scripts.Clear(player, copy); end;
				Duplicator.Scripts.Copy(player, from, copy);
			end

			if (flags.crew or flags.exact) then
				if (flags.clear) then Duplicator.Crew.Clear(player, copy); end;
				Duplicator.Crew.Copy(player, from, copy);
			end

			if (flags.upgrades or flags.exact) then
				if (flags.clear) then Duplicator.Upgrades.Clear(player, copy); end;
				Duplicator.Upgrades.Copy(player, from, copy);
			end

			if (flags.turrets or flags.exact) then
				if (flags.clear) then Duplicator.Turrets.Clear(player, copy); end;
				Duplicator.Turrets.Copy(player, from, copy);
			end

			if (flags.torpedoes or flags.exact) then
				if (flags.clear ~=se) then Duplicator.Torpedoes.Clear(player, copy); end;
				Duplicator.Torpedoes.Copy(player, from, copy);
			end

			if (flags.fighters or flags.exact) then
				if (flags.clear) then Duplicator.Fighters.Clear(player, copy); end;
				Duplicator.Fighters.Copy(player, from, copy);
			end

			if (flags.cargo or flags.exact) then
				if (flags.clear) then Duplicator.Cargo.Clear(player, copy); end;
				Duplicator.Cargo.Copy(player, from, copy);
			end

			if (flags.icon or flags.exact) then
				Duplicator.Icon.Copy(player, from, copy);
			end

			if (flags.title or flags.exact) then
				Duplicator.Title.Copy(player, from, copy);
			end

			names[#names+1] = "'" .. copy.name .. "'";

		end

	end

	return 1, "", "Finished: Copied build '" .. from.name .. "' to " .. table.concat(names, ", ");

end, FlagHelper;
