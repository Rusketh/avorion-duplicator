--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

--Begin

Fighters = { };

--Clear

Fighters.Clear = function(owner, ship)
	
	local hangar = Hangar(ship);

	if (hangar) then hangar:clear(); end
	
end

--Copy

Fighters.Copy = function(owner, ship, clone)
	
	local hangar = Hangar(ship);

	if (not hangar) then return; end

	local copy = Hangar(clone);

	if (not copy) then return; end

	for _, squad in pairs( { hangar:getSquads() } ) do
		local id = copy:addSquad( hangar:getSquadName(squad) );

		copy:setBlueprint(id, hangar:getBlueprint(squad));

		for i = 0, hangar:getSquadFighters(squad) do

			local fighter = hangar:getFighter(squad, i);

			if (fighter) then copy:addFighter(squad, fighter); end

		end

	end
	
end

--Exports

return Fighters;