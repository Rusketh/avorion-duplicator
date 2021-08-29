--Package

package.path = package.path .. ";data/scripts/lib/?.lua"

--Import Command

Command, Helper = include("/data/scripts/lib/duplicator/commands/replicate");

--Description

function getDescription()
    return "Copies your ship load out to another ship."
end

--Help

function getHelp()
    
    return table.concat( {

        "Description: " .. getDescription(),

        "Usage: '/replicate [...flag value]'",

        "Flags:", Helper()

    }, "\n");

end

--Execute Command

function execute(sender, commandName, a, ...)

    if (a == "?") then return 1, "", getHelp(); end

    return Command(sender, commandName, a, ...);

end