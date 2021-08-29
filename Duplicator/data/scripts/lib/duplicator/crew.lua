--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

-- Avoid Namespace conflict.

local _Crew = Crew;


--Begin

Crew = { };

--Crew Types

Crew.Types = { };
Crew.Types.unemployed = CrewProfessionType.None;
Crew.Types.engineers = CrewProfessionType.Engine;
Crew.Types.gunners = CrewProfessionType.Gunner;
Crew.Types.miners = CrewProfessionType.Miner;
Crew.Types.mechanics = CrewProfessionType.Repair;
Crew.Types.pilots = CrewProfessionType.Pilot;
Crew.Types.security = CrewProfessionType.Security;
Crew.Types.attackers = CrewProfessionType.Attacker;
Crew.Types.sergeants = CrewProfessionType.Sergeant;
Crew.Types.lieutenants = CrewProfessionType.Lieutenant;
Crew.Types.commanders = CrewProfessionType.Commander;
Crew.Types.generals = CrewProfessionType.General;
Crew.Types.captains = CrewProfessionType.Captain;

--Util Functions

Crew.TotalStaff = function(crew)
	if (not crew) then return 0; end

	return (crew.unemployed or 0) + (crew.engineers or 0) + (crew.gunners or 0) + (crew.miners or 0) + (crew.mechanics or 0) + (crew.pilots or 0) + (crew.security or 0) + (crew.attackers or 0);
end

Crew.TotalManagers = function(crew)
	if (not crew) then return 0; end

	return (crew.captains or 0) + (crew.generals or 0) + (crew.commanders or 0) + (crew.lieutenants or 0) + (crew.sergeants or 0);
end

Crew.TotalCrew = function(crew)
	return Crew.TotalStaff(crew) + Crew.TotalManagers(crew);
end

--Calculate Managers

Crew.CaculateManagment = function(crew)
	local staff = Crew.TotalStaff(crew);
	local sergeants = math.ceil(staff / 10);
	local lieutenants = math.ceil(sergeants / 4);
	local commanders = math.ceil(lieutenants / 3);
	local generals = math.ceil(commanders / 3.5);
	return { sergeants = sergeants, lieutenants = lieutenants, commanders = commanders, generals = generals, captains = 1 };
end

--Populate

Crew.Populate = function(crew, requirments, managment)
	
	if (requirments) then

		for type, position in pairs(Crew.Types) do

			local desired, current = requirments[type] or 0, crew[type] or 0;

			if (desired > current) then

				crew:add(desired - current, CrewMan(position));

			end

		end

	end

	if (managment) then

		Crew.Populate(crew, Crew.CaculateManagment(crew), false);

	end

	return crew;
end

--Clone

Crew.Clone = function(crew)

	local copy = _Crew();

	if (crew) then

		for type, position in pairs(Crew.Types) do

			copy:add(crew[type], CrewMan(position));

		end
	end

	return copy;
end

--Copy

Crew.Copy = function(owner, ship, clone)
	clone.crew = Crew.Clone(ship.crew);
end

--Export

return Crew;