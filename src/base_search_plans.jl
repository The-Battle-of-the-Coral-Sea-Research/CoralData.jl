

const plan_PQRYZ_KOO = Dict{String, SectorSearchPlan}(
	"P" => (Rabaul, (45, 75), 600mi, 2), 
	# While other source gives distance = 1100km, but the KOO radius is not given in that source,
	# so I use 600mi and 650mi
	"Q" => (Rabaul, (75, 105), 600mi, 2),
	"R" => (Rabaul, (135, 165), 600mi, 2),
	"Y" => (Lae, (130, 160), 600mi, 2),
	"Z" => (Lae, (160, 190), 600mi, 2),
	"KOO" => (Rabaul, (170, 210), 650mi, 3)
)

# The order was issuesd on 29 April, but Tulagi was occupied on 3 May (the patrol started from 5 May)
# It may be inferred that distance=600mi as well from other source.
const plan_ABCDEFGI = Dict{String, SectorSearchPlan}(
	"A" => (Lae, (124, 190), 600mi, 5),
	"B" => (Rabaul, (135, 172), 600mi, 4),
	"C" => (Rabaul, (53, 115), 600mi, 4),
	# "D" => (Shortland, (100, 194), 600mi, 4),
	"D" => (Shortland, (100, 194), 600mi, 8), # 1-4 take half of the sector according to reference??? can't find a exact value, so use dummy value 8 to index.
	"E" => (Shortland, (45, 100), 600mi, 4), # unknown num, use 4 as a trade-off between other average value
	"F" => (Tulagi, (95, 225), 600mi, 11),
	"G" => (Tulagi, (45, 95), 600mi, 5),
	"I" => (Deboyne, (155, 180), 600mi, 2)
)


const plan_allied_late = Dict{String, SectorSearchPlan}(
	"Moresby" => (Moresby, (45, 115), 480mi, 5), # Num is unknown, should be range from 3~7.
	"Townsville" => (Townsville, (20,90), 500mi, 7), # num unknown, TODO: way to denote twice a day
	"Noumea_late_wn" => (Noumea, (305, 360), 1100, 6),
	"Noumea_late_en" => (Noumea, (11, 30), 600, 1)
)

#=
# before 5 May
plan_allied_early = (
    Moresby=plan_allied_late.Moresby,
    Townsville=plan_allied_late.Townsville,
	Noumea_early=(base="Noumea", bearing=340, distance=700mi, edge=[-50mi, 50mi]), 
)
=#