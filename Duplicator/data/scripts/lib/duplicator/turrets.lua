--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

--Begin

Turrets = { };

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