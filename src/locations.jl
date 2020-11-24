

const Rabaul = SpatPos(152.1, -4.25)
const Lae = SpatPos(147., -6.6)
const Shortland = SpatPos(155.8, -7.1)
const Tulagi = SpatPos(160.2, -9.1)
const Moresby = SpatPos(147.15, -9.3)
const Cooktown = SpatPos(145.2, -15.4)
const Townsville = SpatPos(146.45, -19.1)
const Efate = SpatPos(168.4, -17.5)
const Noumea = SpatPos(166.2, -22.0)
const Deboyne = SpatPos(152.4, -10.7)
const Rossel = SpatPos(154.3, -11.4)
const Jomard = SpatPos(152.138, -11.253)

const locs = (;Rabaul, Lae, Shortland, Tulagi, Moresby, Cooktown, Townsville, Efate, Noumea,
    Deboyne, Rossel, Jomard)
const loc_map = Dict([string(key)=>loc for (key, loc) in zip(keys(locs), locs)])
