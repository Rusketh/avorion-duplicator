--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

--Begin

Torpedoes = { };

--Copy

Torpedoes.Copy = function(owner, ship, clone)
	
	local launcher = TorpedoLauncher(ship);

	if (not launcher) then return; end

	local copy = TorpedoLauncher(clone);

	if (not copy) then return; end

	for _, shaft in pairs( { launcher:getShafts() } ) do

		for i = 0, launcher:getNumTorpedoes(shaft) do

			local torpedo = launcher:getTorpedo(i, shaft);

			if (torpedo) then copy:addTorpedo(torpedo, shaft); end
		end

	end
	
end

--Exports

return Torpedoes;