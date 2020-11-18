
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


const scouting_action_group_map = Dict(
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
    "MO Carrier Striking Force, 7 May (plan)" => normal_single_sector_search.(
        "MO Carrier Striking Force",
        [180, 200, 300, # Shōkaku (翔鶴)
         235, 250, 265], # Zuikaku (瑞鶴)
        250mi, CT(7, 6, 9), CT(7, 10, 30), -90, 
        [40mi, 40mi, 40mi,
         30mi, 30mi, 30mi]
    )
)