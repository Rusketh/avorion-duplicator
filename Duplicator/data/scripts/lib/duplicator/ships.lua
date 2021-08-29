--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

--Imports
local DalekEmpireDebug = include("data/scripts/lib/dalek/debug");

--Inlucdes
include("defaultscripts");

--[[
===================================================================================================
	DalekEmpireShips: Name Space
===================================================================================================
]]

DalekEmpireShips = { };

--[[
===================================================================================================
	DalekEmpireShips: Crew Name Space
===================================================================================================
]]

DalekEmpireShips.Crew = { };

--[[
===================================================================================================
	DalekEmpireShips: Crew Types
===================================================================================================
]]

DalekEmpireShips.Crew.Types = { };
DalekEmpireShips.Crew.Types.unemployed = CrewProfessionType.None;
DalekEmpireShips.Crew.Types.engineers = CrewProfessionType.Engine;
DalekEmpireShips.Crew.Types.gunners = CrewProfessionType.Gunner;
DalekEmpireShips.Crew.Types.miners = CrewProfessionType.Miner;
DalekEmpireShips.Crew.Types.mechanics = CrewProfessionType.Repair;
DalekEmpireShips.Crew.Types.pilots = CrewProfessionType.Pilot;
DalekEmpireShips.Crew.Types.security = CrewProfessionType.Security;
DalekEmpireShips.Crew.Types.attackers = CrewProfessionType.Attacker;
DalekEmpireShips.Crew.Types.sergeants = CrewProfessionType.Sergeant;
DalekEmpireShips.Crew.Types.lieutenants = CrewProfessionType.Lieutenant;
DalekEmpireShips.Crew.Types.commanders = CrewProfessionType.Commander;
DalekEmpireShips.Crew.Types.generals = CrewProfessionType.General;
DalekEmpireShips.Crew.Types.captains = CrewProfessionType.Captain;

local crewTypes = DalekEmpireShips.Crew.Types;

--[[
===================================================================================================
	DalekEmpireShips: Crew Helpers
===================================================================================================
]]

DalekEmpireShips.Crew.AsObject = function(crew)
	if (not crew) then crew = { }; end

	return {
		unemployed = crew.unemployed or 0,
		engineers = crew.engineers or 0,
		gunners = crew.gunners or 0,
		miners = crew.miners or 0,
		mechanics = crew.mechanics or 0,
		pilots = crew.pilots or 0,
		security = crew.security or 0,
		attackers = crew.attackers or 0,
		sergeants = crew.sergeants or 0,
		lieutenants = crew.lieutenants or 0,
		commanders = crew.commanders or 0,
		generals = crew.generals or 0,
		captains = crew.captains or 0
	};
end

DalekEmpireShips.Crew.CommandHelper = function(...)
	local results, args = { }, { ... };

	for i = 1, #args, 2 do
		local key, value = args[i], tonumber(args[i + 1]);

		if (not key or not value) then break; end

		local profession = DalekEmpireShips.Crew.Types[key];
		
		if (not profession) then return false, "Invalid crew type " .. key; end

		results[key] = value;
	end

	return true, results;
end

DalekEmpireShips.Crew.Copy = function(crew)

	local copy = Crew();

	if (crew) then
		for type, position in pairs(DalekEmpireShips.Crew.Types) do
			copy:add(crew[type], CrewMan(position));
		end
	end

	return copy;
end

--[[
===================================================================================================
	DalekEmpireShips: Crew Calculators
===================================================================================================
]]

DalekEmpireShips.Crew.GetStaffCount = function(crew)
	if (not crew) then return 0; end

	return (crew.unemployed or 0) + (crew.engineers or 0) + (crew.gunners or 0) + (crew.miners or 0) + (crew.mechanics or 0) + (crew.pilots or 0) + (crew.security or 0) + (crew.attackers or 0);
end

DalekEmpireShips.Crew.GetDesired = function(ideal, desired)
	local results = { };

	for type in pairs(crewTypes) do

		local idl = ideal[type] or 0;
		local des = desired[type] or 0;
		results[type] = (des > idl) and des or idl;
	end

	return results;
end

DalekEmpireShips.Crew.CaculateManagment = function(crew)
	local staff = DalekEmpireShips.Crew.GetStaffCount(crew);
	local sergeants = math.ceil(staff / 10);
	local lieutenants = math.ceil(sergeants / 4);
	local commanders = math.ceil(lieutenants / 3);
	local generals = math.ceil(commanders / 3.5);
	return { sergeants = sergeants, lieutenants = lieutenants, commanders = commanders, generals = generals, captains = 1 };
end

--[[
===================================================================================================
	DalekEmpireShips: Crew Populator
===================================================================================================
]]

DalekEmpireShips.Crew.Populate = function(crew, ideal, mgmt)
	
	if (ideal) then
		for type, position in pairs(crewTypes) do
			local desired, current = ideal[type] or 0, crew[type] or 0;

			if (desired > current) then
				crew:add(desired - current, CrewMan(position));
			end
		end
	end

	if (mgmt) then
		DalekEmpireShips.Crew.Populate(crew, DalekEmpireShips.Crew.CaculateManagment(crew), false);
	end

	return crew;
end

--[[
===================================================================================================
	DalekEmpireShips: Duplicator Name Space
===================================================================================================
]]

DalekEmpireShips.Duplicator = { };

--[[
===================================================================================================
	DalekEmpireShips: Spawn a ship
===================================================================================================
]]

DalekEmpireShips.Duplicator.SpawnShip = function(owner, name, plan, pos)
	
	if (owner:ownsShip(name)) then return false, "Ship name allready exists."; end

	local position = Matrix();

	position.pos = pos;

	local ship = Sector():createShip(owner, name, plan, position);

	if (not ship) then return false, "Could not create ship."; end

	-- add base scripts
    AddDefaultShipScripts(ship);
    SetBoardingDefenseLevel(ship);

    return true, ship;
end

--[[
===================================================================================================
	DalekEmpireShips: Clone a ship
===================================================================================================
]]

DalekEmpireShips.Duplicator.SpawnClone = function(ship, owner, name, pos)
	return DalekEmpireShips.Duplicator.SpawnShip(owner, name, ship:getFullPlanCopy(), pos);
end

--[[
===================================================================================================
	DalekEmpireShips: Copy Ship Systems
===================================================================================================
]]

DalekEmpireShips.Duplicator.CopySystems = function(ship, clone)
	local shipSystems = ShipSystem(ship);
	local cloneSystems = ShipSystem(clone);

	for upgrade, permanent in pairs( shipSystems:getUpgrades() ) do
		cloneSystems:addUpgrade(upgrade, permanent);
	end
end

--[[
===================================================================================================
	DalekEmpireShips: Copy Entity Component Scripts
===================================================================================================
]]

DalekEmpireShips.Duplicator.CopyScripts = function(ship, clone)
	for k, script in pairs( ship:getScripts() ) do
		if ( not clone:hasScript(script) ) then clone:addScript(script); end
	end
end

--[[
===================================================================================================
	DalekEmpireShips: Copy Turrets
===================================================================================================
]]

DalekEmpireShips.Duplicator.CopyTurrets = function(ship, clone)
	for k, base in pairs( { ship:getTurrets() } ) do
		
		local template = TurretTemplate();

		for j, weapon in pairs( {Weapons(base):getWeapons()} ) do
			template:addWeapon(weapon);
		end

		clone:addTurret(template, base.position * ship.position:getInverse(), base:getAttachedBlockIndex());

	end
end



--[[
===================================================================================================
	DalekEmpireShips: Copy Torpedos
===================================================================================================
]]

DalekEmpireShips.Duplicator.CopyTorpedos = function(ship, clone)

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

--[[
===================================================================================================
	DalekEmpireShips: Copy Crew
===================================================================================================
]]

DalekEmpireShips.Duplicator.CopyCrew = function(ship, clone)
	clone.crew = DalekEmpireShips.Crew.Copy(ship.crew);
end

--[[
===================================================================================================
	DalekEmpireShips: Copy Fighters
===================================================================================================
]]

DalekEmpireShips.Duplicator.CopyFighters = function(ship, clone)
	
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

--[[
===================================================================================================
	DalekEmpireShips: Copy Icon
===================================================================================================
]]

DalekEmpireShips.Duplicator.CopyIcon = function(owner, ship, clone)
	if (owner) then owner:setShipIcon(clone.name, owner:getShipIcon(ship.name)); end
end

--[[
===================================================================================================
	DalekEmpireShips: Copy Title
===================================================================================================
]]

DalekEmpireShips.Duplicator.CopyTitle = function(ship, clone)
	clone:setTitle(ship.title, ship:getTitleArguments() or { });
end

--[[
===================================================================================================
	DalekEmpireShips: Build Complete Clone
===================================================================================================
]]

DalekEmpireShips.Duplicator.Clone = function(ship, owner, name, pos)
	local ok, clone = DalekEmpireShips.Duplicator.SpawnShip(owner, name, ship:getFullPlanCopy(), pos);
	
	if (not ok) then return ok, clone; end

	DalekEmpireShips.Duplicator.CopySystems(ship, clone);
	DalekEmpireShips.Duplicator.CopyTurrets(ship, clone);
	DalekEmpireShips.Duplicator.CopyScripts(ship, clone);
	DalekEmpireShips.Duplicator.CopyFighters(ship, clone);
	DalekEmpireShips.Duplicator.CopyTorpedos(ship, clone);
	DalekEmpireShips.Duplicator.CopyCrew(ship, clone);
	DalekEmpireShips.Duplicator.CopyTitle(ship, clone);
	DalekEmpireShips.Duplicator.CopyIcon(owner, ship, clone);

	return true, ship;
end

-- Exports
return DalekEmpireShips;

