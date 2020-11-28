
"""
    function normal_single_sector_search(base, angle, distance, time_begin, time_end, rot_angle, rot_distance)

base: String, SpatPos or (longitude, latitude)

`normal` means that the scouting found nothing and return base (carrier or airfield) normally.
It's expected to use broadcast to denote plans which share similar parameters. Ex:
```
normal_single_sector_search.(
    "MO Carrier Striking Force",
    [130, 140, 150],
    460, CT(4, 9, 22), CT(4, 13, 50))
```
"""
function normal_single_sector_search(base, angle, distance, time_begin, time_end, 
            rot_angle, rot_distance)
    return [
        MoveTo(base, time_begin), 
        TurnAngleTo(angle), 
        MoveForward(distance), 
        TurnAngle(rot_angle),
        MoveForward(rot_distance),
        MoveTo(base, time_end)
    ]
end

function normal_single_line_search(base, angle, distance, time_begin, time_end)
    return [
        MoveTo(base, time_begin), 
        TurnAngleTo(angle), 
        MoveForward(distance), 
        MoveTo(base, time_end)
    ]
end

function get_deg_vec(deg_start, deg_end, length; search_lines)
    if deg_end < deg_start
        deg_end = deg_end + 360
    end
    if !search_lines
        return range(deg_start, deg_end, length=length) .% 360
    else
        diff = abs(deg_end - deg_start) / (length+1) / 2
        return (range(deg_start, deg_end, length=length+1)[1:end-1] .+ diff) .% 360
    end
end

function Vector{Vector{Action}}(ssp::SectorSearchPlan, time_begin::DateTime, time_end::DateTime)
    deg_vec = get_deg_vec(ssp.bearing[1], ssp.bearing[2], ssp.num; search_lines=true)
    return normal_single_line_search.(ssp.base, deg_vec, ssp.distance, time_begin, time_end)
end

function Vector{Vector{Action}}(ssp::SectorSearchPlan, time_begin::DateTime, time_end::DateTime,
        rot_angle::Float64, rot_distance::Float64)
    deg_vec = get_deg_vec(ssp.bearing[1], ssp.bearing[2], ssp.num; search_lines=true)
    return normal_single_line_search.(ssp.base, deg_vec, ssp.distance, time_begin, time_end,
                                      rot_angle, rot_distance)
end

function Dict{String, Vector{Vector{SpatTempPos}}}(scouting_action_group_map::Dict{String, Vector{Vector{Action}}}, fleet_stpi_vec_map::Dict{String})
    return Dict{String, Vector{Vector{SpatTempPos}}}(
        key => map(x->Vector{SpatTempPos}(x, fleet_stpi_vec_map), soucting_action_group) 
        for (key, soucting_action_group) in scouting_action_group_map
    )
end

"""
    flatten_stpi_vec_group(stpi_vec_group_map)

Flatten out the group level by reducing it to name.
This function can be used to convert scouting plan groups to fleet dict like data.

Dict("A" => [a1, a2, a3], "B" => [b1, b2, b3])
->
Dict("A_1"=>a1, "A_2"=>a2, "A_3"=>a3, "B_1"=>b1, "B_2"=>b2, "B_3"=>b3)
"""
function flatten_vec_group(vec_group_map::Dict{String, <:AbstractVector{T}}) where T
    rd = Dict{String, T}()
    for (key, v_vec) in vec_group_map
        for i in eachindex(v_vec)
            rd["$(key)[$i]"] = v_vec[i]
        end
    end
    return rd
end

function Dict{String, Vector{SpatTempPos}}(scouting_action_group_map, fleet_stpi_vec_map)
    rd = Dict{String, Vector{Vector{SpatTempPos}}}(scouting_action_group_map, fleet_stpi_vec_map)
    return flatten_vec_group(rd)
end

# debug and editing helper

"""
    redirect(action_vec::Vector{<:Vector{<:Action}}, loc)

last MoveTo(old_loc, time) -> MoveTo(new_loc, time)
"""
function redirect(action_vec::Vector{<:Action}, loc)
    return [action_vec[1:end-1]; MoveTo(loc, action_vec[end].time)]
end

# Compatible purpose
redirect(action_vec_vec::Vector{<:Vector{<:Action}}, loc) = redirect.(action_vec_vec, loc)

#=
function append_end(action_vec_vec::Vector{<:Vector{<:Action}}, loc)
    map(append_end, action_vec_vec) do action_vec
        [action_vec[1:end-1]; 
         MoveTo(action_vec[end].pos);
         MoveTo(loc, action_vec[end].time)]
    end
end
=#

"""
    append_end(action_vec::Vector{<:Action}, loc)

last MoveTo(old_loc, time) -> [MoveTo(old_loc), MoveTo(loc, time)]
"""
function append_end(action_vec::Vector{<:Action}, loc)
    return [
        action_vec[1:end-1]; 
        MoveTo(action_vec[end].pos);
        MoveTo(loc, action_vec[end].time)
    ]
end

# Compatible purpose
append_end(action_vec_vec::Vector{<:Vector{<:Action}}, loc) = append_end.(action_vec_vec, loc)

# introduce data section

include("actions_data.jl")

