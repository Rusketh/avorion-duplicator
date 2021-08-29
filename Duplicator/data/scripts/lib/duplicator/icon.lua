--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

--Begin

Icon = { };

--Copy

Icon.Clear = function(owner, ship)
	if (owner) then clone:setShipIcon(clone.name, ""); end
end

--Copy

Icon.Copy = function(owner, ship, clone)
	if (owner) then owner:setShipIcon(clone.name, owner:getShipIcon(ship.name)); end
end

--Exports

return Icon;