--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

--Begin

Turrets = { };

--Clear

Turrets.Clear = function(owner, ship)
	
	for k, base in pairs( { ship:getTurrets() } ) do
		
		local turret = Weapons(base);

		if (turret) then turret:clearWeapons(); end

	end
	
end

--Copy

Turrets.Copy = function(owner, ship, clone)

	for k, base in pairs( { ship:getTurrets() } ) do
		
		local template = TurretTemplate();

		for j, weapon in pairs( {Weapons(base):getWeapons()} ) do

			template:addWeapon(weapon);
			
		end

		clone:addTurret(template, base.position * ship.position:getInverse(), base:getAttachedBlockIndex());

	end

end

--Exports

return Turrets;