--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

--Begin

Title = { };

--Copy

Title.Clear = function(owner, ship)
	ship:setTitle("", { });
end

--Copy

Title.Copy = function(owner, ship, clone)
	clone:setTitle(ship.title, ship:getTitleArguments() or { });
end

--Exports

return Title;