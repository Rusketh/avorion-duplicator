--Package

package.path = package.path .. ";data/scripts/lib/?.lua"

--Imports

include("defaultscripts");

--Name Space

Duplicator = include("data/scripts/lib/duplicator/duplicator");

-- Begin

Duplicator.Ship = { };

-- Create a new ship

Duplicator.Ship.Spawn = function(owner, name, plan, position)
	
	if (owner:ownsShip(name)) then

		return false, "Ship name allready exists.";

	end

	local matrix = Matrix();

	matrix.pos = position;

	local ship = Sector():createShip(owner, name, plan, matrix);

	if (not ship) then

		return false, "Could not create ship.";

	end

	AddDefaultShipScripts(ship);

    SetBoardingDefenseLevel(ship);

    return true, ship;

end

Duplicator.Ship.Duplicate = function(ship, owner, name, position, options)
	
	local ok, clone = Duplicator.Ship.Spawn(owner, name, ship:getFullPlanCopy(), position);
	
	if (not ok) then return ok, clone; end

	options = options or { };

	if (options.Scripts ) then Duplicator.Scripts.Copy(owner, ship, clone); end

	if (options.Crew ) then Duplicator.Crew.Copy(owner, ship, clone); end

	if (options.Upgrades ) then Duplicator.Upgrades.Copy(owner, ship, clone); end

	if (options.Turrets ) then Duplicator.Turrets.Copy(owner, ship, clone); end

	if (options.Torpedoes ) then Duplicator.Torpedoes.Copy(owner, ship, clone); end

	if (options.Fighters ) then Duplicator.Fighters.Copy(owner, ship, clone); end

	if (options.Cargo ) then Duplicator.Cargo.Copy(owner, ship, clone); end

	if (options.Icon ) then Duplicator.Icon.Copy(owner, ship, clone); end

	if (options.Title ) then Duplicator.Title.Copy(owner, ship, clone); end

	return true, clone;

end

--Exports

return Duplicator;