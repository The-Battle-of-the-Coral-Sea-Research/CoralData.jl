module CoralData

using Dates
using RecipesBase

export fleet_trajectory_map, fleet_size_map, loc_map, 
    plan_PQRYZ_KOO, plan_ABCDEFGI, plan_allied_late,
    scouting_action_group_map, SpatPos, SpatTempPos, Action

include("defs.jl")
include("locations.jl")
include("fleets.jl")
include("base_search_plans.jl")
include("actions.jl")
include("recipes.jl")

end # module
