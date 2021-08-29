--Package

package.path = package.path .. ";data/scripts/lib/?.lua"

--Import Command

Command = include("/data/scripts/lib/duplicator/commands/duplicate");

--Execute Command

function execute(sender, commandName, ...)
	return Command(sender, commandName, ...);
end

function getDescription()
    return "Creates a duplicate of a ship."
end

function getHelp()
    return "Creates a duplicate of a ship. Usage: '/duplicate [...names(,)] [...flag value]' Flags: scripts, crew, upgrades, turrets, torpedoes, fighters, cargo, icon, title, exact, alliance, direction, target."
end

