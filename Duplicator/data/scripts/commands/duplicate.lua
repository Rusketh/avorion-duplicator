--Package

package.path = package.path .. ";data/scripts/lib/?.lua"

--Import Command

Command, Helper = include("/data/scripts/lib/duplicator/commands/duplicate");

--Description

function getDescription()
    return "Creates a duplicate of a ship."
end

--Help

function getHelp()
    
    return table.concat( {

        "Description: " .. getDescription(),

        "Usage: '/duplicate [...names(,)] [...flag value]'",

        "Flags:", Helper()

    }, "\n");

end

--Execute Command

function execute(sender, commandName, a, ...)

    if (a == "?") then return 1, "", getHelp(); end

    return Command(sender, commandName, a, ...);

end