--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

--Begin

Scripts = { };

--Copy

Scripts.Copy = function(owner, ship, clone)
	for k, script in pairs( ship:getScripts() ) do
		if ( not clone:hasScript(script) ) then clone:addScript(script); end
	end
end

--Exports

return Scripts;