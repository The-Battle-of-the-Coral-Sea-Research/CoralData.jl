# data

# Typing `Dict{String, Vector{Vector{Action}}}` is used to suppress vscode julia plugin unreasonable warning info.

const scouting_action_group_map = Dict{String, Vector{Vector{Action}}}(
    "MO Carrier Striking Force, 4 May" => normal_single_sector_search.(
        "MO Carrier Striking Force",
        [130, 140, 150], # Zuikaku (瑞鶴)
        460, CT(4, 9, 22), CT(4, 13, 50), 90, 37
    ),
    "MO Carrier Striking Force, 5 May" => normal_single_sector_search.(
        "MO Carrier Striking Force",
        [105, 120, # Myōkō (妙高) 
         130, 140, 150, # Zuikaku (瑞鶴)
         160, 170, 180, # Shōkaku (翔鶴)
         190, 200], # Haguro (羽黒)
        [160mi, 250mi,
         300mi, 300mi, 300mi, 300mi, 300mi, 300mi,
         250mi, 160mi],
        CT(5, 6, 0), CT(5, 11, 24), # the end time is not known, fill it with a reasonable value.
        90,
        [30mi, 25mi,
         25mi, 25mi, 25mi, 25mi, 25mi, 25mi,
         25mi, 30mi]
    ),
    "MO Carrier Striking Force, 7 May" => normal_single_sector_search.(
        "MO Carrier Striking Force",
        [180, 200, 220, # Shōkaku (翔鶴)
         235, 250, 265], # Zuikaku (瑞鶴)
        250mi, CT(7, 6, 9), CT(7, 10, 30), -90, # end time = (7, 12, 30)?
        [40mi, 40mi, 40mi,
         30mi, 30mi, 30mi]
    ),
    "MO Carrier Striking Force, 7 May Afternoon" => normal_single_sector_search.(
        "MO Carrier Striking Force",
        [230, 250, # Shōkaku (翔鶴)
         270, 290], # Zuikaku (瑞鶴)
        500, CT(7, 15, 15), CT(7, 18, 30), -90, # end time = (7, 12, 30)?
        37
    ),
    "MO Carrier Striking Force, 7 May Afternoon Attack" => [normal_single_line_search(
        "MO Carrier Striking Force", 270, 500, CT(7, 14, 30), CT(7, 18, 20)
    )],
    "MO Carrier Striking Force, 8 May" => normal_single_sector_search.(
        "MO Carrier Striking Force",
        [140, 155, 170, # Zuikaku (瑞鶴)
         185, 200, 215, 230], # Shōkaku (翔鶴)
        250mi, CT(7, 8, 0), CT(8, 11, 50), -90, # end time CT(8,10, 26) ~ CT(8, 11, 50)
        30mi
    )
)

