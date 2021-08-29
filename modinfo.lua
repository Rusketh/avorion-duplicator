
meta =
{
    -- ID of your mod; Make sure this is unique!
    -- Will be used for identifying the mod in dependency lists
    -- Will be changed to workshop ID (ensuring uniqueness) when you upload the mod to the workshop
    id = "Duplicator",

    -- Name of your mod; You may want this to be unique, but it's not absolutely necessary.
    -- This is an additional helper attribute for you to easily identify your mod in the Mods() list
    name = "Duplicator",

    -- Title of your mod that will be displayed to players
    title = "Ship Duplicator",

    -- Type of your mod, either "mod" or "factionpack"
    type = "mod",

    -- Description of your mod that will be displayed to players
    description = [[
    Allows you to quickly create duplicate(s) of any ship as well as its crew, modules, weapons, etc.
    The must have Creative Fleet Builder!

    Command: /duplicate <names> <flag value>
    - Names: A list of names, sperated by a comma (,) a duplicate will be created for each name.
    - Flags: 
        Bool = scripts: Duplicates the ships internal components, true by default (do not change this).
        Bool = crew: Duplicates the ships crew, false by default.
        Bool = upgrades: Duplicates the ships System Upgrades, false by default.
        Bool = turrets: Duplicates the ships Turrets, false by default.
        Bool = torpedos: Duplicates the ships Torpedo bay storage, false by default.
        Bool = fighters: Duplicates the ships Fighter Squads, false by default.
        Bool = cargo: Duplicates the ships Cargo, false by default.
        Bool = icon: Duplicates the ships Icon, true by default.
        Bool = title: Duplicates the ships Class Name, true by default.
        Bool = exact: Sets all of the above flags to true if set to true.
        Number = offset: The offset distance between each duplicated ship.
        Direction = direction: The direction to spawn the line duplicated ships in (forward, backward, left, etc).
        Craft = target: The ship to duplicate (craft, target, <name of a ship your own in sector>), current target or craft by default.
        Bool = alliance: Adds the duplicate ships to the alliance.

    Examples:
        /duplicate "EG 001" upgrades true turrets true - Spawns a single duplicate of your current ship with System Upgrades & Turrets.
        /duplicate "EG 001", EG002 - Spawns two blank duplicates of your ship.
        /duplicate "EG 001" direction up - Spawns a duplicate of your ship above your current ship.
    ]],

    -- Insert all authors into this list
    authors = {"MarcusWithSpots"},

    -- Version of your mod, should be in format 1.0.0 (major.minor.patch) or 1.0 (major.minor)
    -- This will be used to check for unmet dependencies or incompatibilities, and to check compatibility between clients and dedicated servers with mods.
    -- If a client with an unmatching major or minor mod version wants to log into a server, login is prohibited.
    -- Unmatching patch version still allows logging into a server. This works in both ways (server or client higher or lower version).
    version = "1.0",

    -- If your mod requires dependencies, enter them here. The game will check that all dependencies given here are met.
    -- Possible attributes:
    -- id: The ID of the other mod as stated in its modinfo.lua
    -- min, max, exact: version strings that will determine minimum, maximum or exact version required (exact is only syntactic sugar for min == max)
    -- optional: set to true if this mod is only an optional dependency (will only influence load order, not requirement checks)
    -- incompatible: set to true if your mod is incompatible with the other one
    -- Example:
    -- dependencies = {
    --      {id = "Avorion", min = "0.17", max = "0.21"}, -- we can only work with Avorion between versions 0.17 and 0.21
    --      {id = "SomeModLoader", min = "1.0", max = "2.0"}, -- we require SomeModLoader, and we need its version to be between 1.0 and 2.0
    --      {id = "AnotherMod", max = "2.0"}, -- we require AnotherMod, and we need its version to be 2.0 or lower
    --      {id = "IncompatibleMod", incompatible = true}, -- we're incompatible with IncompatibleMod, regardless of its version
    --      {id = "IncompatibleModB", exact = "2.0", incompatible = true}, -- we're incompatible with IncompatibleModB, but only exactly version 2.0
    --      {id = "OptionalMod", min = "0.2", optional = true}, -- we support OptionalMod optionally, starting at version 0.2
    -- },
    dependencies = {

    },

    -- Set to true if the mod only has to run on the server. Clients will get notified that the mod is running on the server, but they won't download it to themselves
    serverSideOnly = false,

    -- Set to true if the mod only has to run on the client, such as UI mods
    clientSideOnly = false,

    -- Set to true if the mod changes the savegame in a potentially breaking way, as in it adds scripts or mechanics that get saved into database and no longer work once the mod gets disabled
    -- logically, if a mod is client-side only, it can't alter savegames, but Avorion doesn't check for that at the moment
    saveGameAltering = false,

    -- Contact info for other users to reach you in case they have questions
    contact = "",
}
