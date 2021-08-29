--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

--Begin

Icon = { };

--Copy

Icon.Copy = function(owner, ship, clone)
	if (owner) then owner:setShipIcon(clone.name, owner:getShipIcon(ship.name)); end
end

--Exports

return Icon;