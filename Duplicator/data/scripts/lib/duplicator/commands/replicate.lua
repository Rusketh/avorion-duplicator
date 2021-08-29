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

DefineFlag("Craft", "from", "base", "template");
DefineFlag("Craft", "to", "target", "craft", "ship", "entity", "select", "object");

return function(sender, commandName, ...)

	local args = { ... };

	local flags, error = ParseFlags(sender, args);

	if (error) then return 0, "", error; end

	--Set up options for replicating.

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

	--Get the entity to be copied.

	local from = flags.from;

	if (player and not from) then

		from = player.craft;

	end

	if (not from) then return 0, "", "No craft found to copy from"; end

	--Get the entity to copy to.

	local to = flags.to;

	if (player and not to) then

		if (player.craft and player.craft.selectedObject) then

			to = player.craft.selectedObject;

		end

	end

	if (not to) then return 0, "", "No craft selected to copy to"; end

	--Perform copy operation.

	if (options.Scripts ) then Duplicator.Scripts.Copy(player, from, to); end

	if (options.Crew ) then Duplicator.Crew.Copy(player, from, to); end

	if (options.Upgrades ) then Duplicator.Upgrades.Copy(player, from, to); end

	if (options.Turrets ) then Duplicator.Turrets.Copy(player, from, to); end

	if (options.Torpedoes ) then Duplicator.Torpedoes.Copy(player, from, to); end

	if (options.Fighters ) then Duplicator.Fighters.Copy(player, from, to); end

	if (options.Cargo ) then Duplicator.Cargo.Copy(player, from, to); end

	if (options.Icon ) then Duplicator.Icon.Copy(player, from, to); end

	if (options.Title ) then Duplicator.Title.Copy(player, from, to); end

	return 1, "", "Finished: Copied build '" .. from.name .. "' to '" .. to.name .. "'";

end