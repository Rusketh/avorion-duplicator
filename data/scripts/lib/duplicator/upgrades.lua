--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

--Begin

Upgrades = { };

--Copy

Upgrades.Copy = function(owner, ship, clone)
	local shipSystems = ShipSystem(ship);

	if (not shipSystems) then return; end

	local cloneSystems = ShipSystem(clone);

	if (not cloneSystems) then return; end

	for upgrade, permanent in pairs( shipSystems:getUpgrades() ) do
		cloneSystems:addUpgrade(upgrade, permanent);
	end
end

--Exports

return Upgrades;