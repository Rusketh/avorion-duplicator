--Package
package.path = package.path .. ";data/scripts/lib/?.lua"

--Name Space

Duplicator = { };

--Import libraries into name space

Duplicator.Plan = include("data/scripts/lib/duplicator/plan");

Duplicator.Scripts = include("data/scripts/lib/duplicator/scripts");

Duplicator.Crew = include("data/scripts/lib/duplicator/crew");

Duplicator.Upgrades = include("data/scripts/lib/duplicator/upgrades");

Duplicator.Turrets = include("data/scripts/lib/duplicator/turrets");

Duplicator.Torpedoes = include("data/scripts/lib/duplicator/torpedoes");

Duplicator.Fighters = include("data/scripts/lib/duplicator/fighters");

Duplicator.Cargo = include("data/scripts/lib/duplicator/cargo");

Duplicator.Icon = include("data/scripts/lib/duplicator/icon");

Duplicator.Title = include("data/scripts/lib/duplicator/title");

--Util Name Space

Duplicator.Util = include("data/scripts/lib/duplicator/util");

--Exports

return Duplicator;