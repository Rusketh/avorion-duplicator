--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

--Begin

Cargo = { };

--Clear

Cargo.Clear = function(owner, ship)
	
	local cargobay = CargoBay(ship);

	if (cargobay) then cargobay:clear(); end
	
end

--Copy

Cargo.Copy = function(owner, ship, clone)
	
	local cargobay = CargoBay(ship);

	if (not cargobay) then return end
	
	local copy = CargoBay(clone);

	if (not copy) then return end

	for good, count in pairs( cargobay:getCargos() ) do

		copy:addCargo(good, count);

	end

end

--Exports

return Cargo;