
const dummy_delta = Minute(10)

const contact_report_vec_vec = Vector{Vector{ContactReport}}(
    [
        [
            (("Shortland, Z D, 5 May", 1), CT(5, 6, 46), CT(5, 6, 46), CT(5, 6, 46) + dummy_delta)
        ],
        [
            (("Tulagi, Z F, 6 May", 3), CT(6, 10, 10), CT(6, 10, 0), CT(6, 14, 0), # last report came from 14:00 
                RelPos(Tulagi, 192, 420mi)),
            (("Tulagi, Z F, 6 May", 3), CT(6, 10, 30), CT(6, 10, 0), CT(6, 14, 0), 
                RelPos(Tulagi, 192, 420mi), 190, 20mi),
        ],
        [
            (("MO Carrier Striking Force, 7 May", 1), CT(7, 7, 22), CT(7, 7, 22), CT(7, 10, 40),
                SpatPos(157+50p, -(15+53p)), 15, 20mi),
            (("MO Carrier Striking Force, 7 May", 1), CT(7, 7, 45), CT(7, 7, 22), CT(7, 10, 40),
                SpatPos(157+50p, -(15+53p)), 0, 16mi),
            (("MO Carrier Striking Force, 7 May", 1), CT(7, 10, 40), CT(7, 7, 22), CT(7, 7, 22)), # cancel, time_begin == tine_end
        ],
        [
            (("Rabaul, S, 7 May", 2), CT(7, 9, 25), CT(7, 9, 15), CT(7, 12, 15)), 
            # assume 10min waiting and 2 hours searching + 1 hour line 3
        ],
        [
            (("Rabaul, S, 7 May", 1), CT(7, 9, 25), CT(7, 9, 25), CT(7, 9, 25)),
            # cancel line 3, the extra tracking time have been accounted by above code
        ],
        # Scouting of Kinugasa & Furutaka (Rossel, SE, 7 May) need more check and examination
        [
            (("Rossel, SE, 7 May", 4), CT(7, 8, 20), CT(7, 8, 0), CT(7, 8, 40),
                missing, 30, 20mi), 
            (("Rossel, SE, 7 May", 4), CT(7, 8, 30), CT(7, 8, 0), CT(7, 8, 40),
                RelPos(Deboyne, 152, 280), 30, 20mi)
        ],
        [
            (("Rossel, SE, 7 May", 3), CT(7, 8, 40), CT(7, 8, 20), CT(7, 9, 20), # assume 1 hoour tracking
                RelPos(Rossel, 170, 82mi))
        ],
        [
            (("Rossel, SE, 7 May", 2), CT(7, 7, 45), CT(7, 7, 45), CT(7, 7, 45)) # Shot down, cancelled
        ],
        # Tulagi's contact report is very strange if you compare it with a map, anyway if even Inoue can't figure it out, there's no reason we can figure it out.
        [
            (("Tulagi, Z F, 7 May", 4), CT(7, 8, 40), CT(7, 8, 40), CT(7, 11, 30))
            # While it's weird that the reported position, angle and speed are not avaiable 
            # and expected path is considerably distant from claimed target, but it's only what I can draw from the material :<  
        ],
        [
            (("Tulagi, 2, 7 May", 1), CT(7, 17, 10), CT(7, 17, 0), CT(7, 20, 0),
                RelPos(Rossel, 146, 340)), # assume 10min delay, angle=180, but the speed is not known. It's also possible to fill a common value.
        ],
        [
            (("MO Carrier Striking Force, 7 May Afternoon Attack", 1), CT(7, 18, 45), CT(7, 18, 45), CT(7, 19, 15), # Surprise! Equate it as 0.5h searching
                RelPos(Rossel, 160, 110mi)), # angle=120 but speed is not known
            (("MO Carrier Striking Force, 7 May Afternoon Attack", 1), CT(7, 21, 20), CT(7, 19, 0), CT(7, 19, 30),
                SpatPos(154+40p, -13), 120, 16mi)
        ],
        # For Deboyne, we can only infer time from map analysis. 
        [
            (("Deboyne, S, 7 2", 1), CT(7, 9, 0), CT(7, 9, 0), CT(7, 11, 45)) # all time are infered
        ],
        [
            (("Deboyne, S, 7 3", 1), CT(7, 13, 30), CT(7, 13, 30), CT(7, 15, 30))
        ],
        [
            (("Deboyne, S, 7 4", 1), CT(7, 17, 15), CT(7, 17, 15), CT(7, 18, 45))
        ],
        [
            (("MO Carrier Striking Force, 8 May", 5), CT(8, 8, 22), CT(8, 8, 22), CT(8, 9, 55),
                RelPos("MO Carrier Striking Force", 205, 235mi), 170, 16mi) # ?
        ],
        [
            (("MO Carrier Striking Force, 8 May Attack", 1), CT(8, 11, 5), CT(8, 11, 5), CT(8, 11, 55))
        ],
        [
            (("Tulagi, Z F, 8 May", 2), CT(8, 9, 30), CT(8, 9, 30), CT(8, 10, 30)) # strange location just like 7 May
        ],
        [
            (("Rabaul, S, 8 May", 3), CT(8, 10, 20), CT(8, 10, 20), CT(8, 10, 30)) # assume 10min tracking
        ]
    ]
)