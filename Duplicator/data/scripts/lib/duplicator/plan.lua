--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

--Begin

Plan = { };

--Copy

Plan.Copy = function(owner, ship, clone)
	clone:setPlan(ship:getFullPlanCopy());
end

--Exports

return Plan;