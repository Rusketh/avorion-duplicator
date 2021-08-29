# avorion-duplicator
A mod for duplicating ships in avorion.

#Description
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

