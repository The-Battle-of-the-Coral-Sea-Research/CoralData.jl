
@recipe function f(fleet_trajectory_map::Dict{String, Vector{SpatTempPos}})
    for (fleet_name, stp_vec) in fleet_trajectory_map
        @series begin
            longitude = map(p -> p.longitude, stp_vec)
            latitude = map(p -> p.latitude, stp_vec)
            label --> fleet_name
            (longitude, latitude)
        end
    end
end

@recipe function f(loc_map::Dict{String, SpatPos})
    keys_loc_map = Vector{String}(undef, length(loc_map))
    longitude_vec = Vector{Float64}(undef, length(loc_map))
    latitude_vec = Vector{Float64}(undef, length(loc_map))
    for (idx, (name, sp)) in enumerate(loc_map)
        keys_loc_map[idx] = name
        longitude_vec[idx] = sp.longitude
        latitude_vec[idx] = sp.latitude
    end

    seriestype --> :scatter # hack to show text only
    series_annotations := keys_loc_map
    label --> false
    alpha --> 0
    (longitude_vec, latitude_vec)
end

