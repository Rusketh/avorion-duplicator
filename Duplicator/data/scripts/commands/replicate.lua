--Package

package.path = package.path .. ";data/scripts/lib/?.lua"

--Import Command

Command = include("/data/scripts/lib/duplicator/commands/replicate");

--Execute Command

function execute(sender, commandName, ...)
	return Command(sender, commandName, ...);
end

function getDescription()
    return "Copies your ship load out to another ship."
end

function getHelp()
    return "Copies your ship load out to another ship. Usage: '/replicate [...flag value]' Flags: scripts, crew, upgrades, turrets, torpedoes, fighters, cargo, icon, title, exact."
end
