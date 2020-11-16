module CoralData

using Dates
using RecipesBase

export fleet_trajectory_map, fleet_size_map, loc_map, 
    plan_PQRYZ_KOO, plan_ABCDEFGI, plan_allied_late

include("defs.jl")
include("locations.jl")
include("fleets.jl")
include("base_search_plans.jl")
include("recipes.jl")

end # module
