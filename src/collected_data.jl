
#=

We might leverage declaration based `ForwardDeg` to move collected_data from CoralTools to CoralData.
But while it's interesting from engineering perspective. We don't know enough time to pursue it sadly.

=#


"""
    get_collected_data(get_pos_by_name::Function, forward_deg::Function, V)

get_pos_by_name: (object_name) -> pos
forward_deg: (pos, angle, dist) -> (pos, end_angle)
V: target container or final formatter
"""
function get_collected_data(get_pos_by_name::Function, forward_deg::Function, V)
    # let S=SectorSearchPlan, V=Vector{Vector{SpatTempPosInt}}, VVA=Vector{Vector{Action}}, D=set_distance
    let S=SectorSearchPlan, VVA=Vector{Vector{Action}}, D=set_distance
        
        day7_target = forward_deg(Rossel, 170, 82mi)[1]
        # day7_target2 = forward_deg(Deboyne, 152, 280)[1]
        plan_F_ext = D(plan_ABCDEFGI["F"], 650mi)
        day8_target = forward_deg(
            get_pos_by_name("MO Carrier Striking Force", CT(8, 8, 22)),
            205, 170mi
        )[1]
        
        # Dict{String, V}(
        Dict(
            # 3 May (Scouting from Rabaul in 3 May and 4 May are guessed value)
            "Shortland, Z D, 3 May" => V(plan_ABCDEFGI["D"][CounterClockwise(), 3:5], CT(3, 7, 15), CT(3, 16, 55)),
            "Air Transport 3 May" => V([[MoveTo(Rabaul, CT(3, 11, 40)), MoveTo(Tulagi, CT(3, 16, 15))]]),
            "Rabaul, B F, 3 May" => V(plan_ABCDEFGI["B"], CT(3, 7, 30), CT(3, 16, 30)), # very poor guess
            "Rabaul, C F, 3 May" => V(plan_ABCDEFGI["C"], CT(3, 7, 30), CT(3, 16, 30)), # very poor guess

            # 4 May
            "Tulagi, G F, 4 May" => V(plan_ABCDEFGI["G"][CounterClockwise(), 1:3], CT(4, 7, 0), CT(4, 17, 30)),
            "Rabaul, B F, 4 May" => V(plan_ABCDEFGI["B"], CT(4, 7, 30), CT(4, 16, 30)), # very poor guess
            "Rabaul, C F, 4 May" => V(plan_ABCDEFGI["C"], CT(4, 7, 30), CT(4, 16, 30)), # very poor guess

            # 5 May
            "Rabaul, S, 5 May" => V(S(Rabaul, (165, 190), 1300, 3), CT(5, 8, 5), CT(5, 17, 30)), # end time -> (15:45, 17:30)
            "Rabaul, Z C, 5 May" => V(plan_ABCDEFGI["C"][CounterClockwise(), 1:3], CT(5, 7, 15), CT(5, 17, 27)), # C[1:3] -> C line 2-4
            "Shortland, Z D, 5 May" => V(plan_ABCDEFGI["D"][CounterClockwise(), 2:4], CT(5, 3, 30), CT(5, 17, 0)),
            "Tulagi, Z F, 5 May" => V(plan_ABCDEFGI["F"][CounterClockwise(), 5:10], CT(5, 6, 30), CT(5, 17, 30)),
            
            # 6 May, the value is "guessed" in some extent. Rabaul and Shortland is copied from 5 May, and value of Tulagi is infered from result
            "Rabaul, S, 6 May" =>  V(S(Rabaul, (165, 190), 1300, 3), CT(6, 8, 5), CT(6, 17, 30)), # TODO: Verify +
            "Rabaul, Z C, 6 May" => V(plan_ABCDEFGI["C"][CounterClockwise(), 1:3], CT(6, 7, 15), CT(6, 17, 27)), # Verify +
            # "Shortland, Z D, 6 May" => V(plan_ABCDEFGI["D"][CounterClockwise(), 2:4], CT(6, 3, 30), CT(6, 17, 0)), # Verify +
            # The above plan is not seen in "昭和１７年４月～昭和１７年５月　横浜空　飛行機隊戦闘行動調書"
            "Tulagi, Z F, 6 May" => V(plan_F_ext[CounterClockwise(), 3:7], CT(6, 6, 30), CT(6, 15, 30)), # Verify -
            "Tulagi, 2, 6 May" => V([normal_single_line_search(Tulagi, 192, 420mi, CT(6, 14, 0), CT(6, 7, 1))]),
            
            # 7 May
            "Rossel, SE, 7 May" => V(append_end(VVA(S(Rossel, (90, 210), 150mi, 4), CT(7, 5, 0), CT(7, 11, 30)), Deboyne)), # `time_begin=5:00` is infered by aircraft report time and ship
            "Rossel, 2, 7 May" => V(append_end(VVA(S(Rossel, (90, 210), 150mi, 4), CT(7, 10, 30), CT(7, 16, 30)), Deboyne)), # TODO: elaborate
            # "Deboyne, S, 7 May" => V(S(Deboyne, (160, 230), 250mi, 4), CT(7, 5, 0), CT(7, 9, 0)), # split it into follow two plans
            "Deboyne, S, 7 1" => V(S(Deboyne, (160, 230), 250mi, 4)[CounterClockwise(), 1:3], CT(7, 6, 30), CT(7, 11, 45)), # Kamikawa Maru (神川丸) 
            "Deboyne, S, 7 2" => V(S(Deboyne, (160, 230), 250mi, 4)[CounterClockwise(), 4:4], CT(7, 7, 45), CT(7, 13, 0)), # Kiyokawa Maru (聖川丸) 1 poor 
            "Deboyne, S, 7 3" => V([[MoveTo(Deboyne, CT(7, 12, 15)), MoveTo("Support Group", CT(7, 13, 30)), MoveTo("Support Group", CT(7, 15, 30)), MoveTo(Deboyne, CT(7, 16, 45))]]), # Kiyokawa Maru (聖川丸) 2
            "Deboyne, S, 7 4" => V([[MoveTo(Deboyne, CT(7, 16, 0)), MoveTo("Support Group", CT(7, 17, 15)), MoveTo("Support Group", CT(7, 18, 45)), MoveTo(Deboyne, CT(7, 20, 0))]]), # Kiyokawa Maru (聖川丸) 3
            "Rabaul, Z C, 7 May" => V(plan_ABCDEFGI["C"][CounterClockwise(), 1:3], CT(7, 7, 15), CT(7, 17, 27)), # TODO: Verify
            "Rabaul, S, 7 May" => V(normal_single_sector_search.(Rabaul, [160, 170, 180], 700mi, CT(7, 6, 30), CT(7, 13, 50), 90, 60mi)),
            "Rabaul, 2, 7 May" => V([[MoveTo(Rabaul, CT(7, 9, 15)), MoveTo(day7_target), MoveTo(Rabaul, CT(7, 17, 5))]]), # 12 Betty, torpedo attack
            # The striking time will be treated as contact report
            "Rabaul, 3, 7 May" => V([[MoveTo(Rabaul, CT(7, 9, 0)), MoveTo(day7_target), MoveTo(Rabaul, CT(7, 17, 45))]]), # 20 Nell, level bombing
            "Tulagi, Z F, 7 May" => V(plan_F_ext[CounterClockwise(), 1:4], CT(7, 7, 0), CT(7, 13, 30)),
            "Tulagi, 2, 7 May" => V([[MoveTo(Tulagi, CT(7, 13, 0)), MoveTo(day7_target), MoveTo(Tulagi, CT(7, 20, 20))]]), # verify plane
            # the end time is obtained by excluding tracking time
            "Tulagi, 3, 7 May" => V([[MoveTo(Tulagi, CT(7, 15, 0)), MoveTo(day7_target), MoveTo(Tulagi, CT(8, 1, 15))]]), # attacking planes
            
            # 8 May
            "Rabaul, S, 8 May" => V(normal_single_sector_search.(Rabaul, [170, 180, 190, 200], 700mi, CT(8, 7, 18), CT(8, 16, 30), -90, 60mi)),
            "Deboyne, S, 8 May" => V(S(Deboyne, (160, 230), 250mi, 3), CT(8, 5, 0), CT(8, 9, 0)), # TODO: elaborate, 3 and time is guessed value
            "Tulagi, Z F, 8 May" => V(normal_single_sector_search.(Tulagi, [215, 225, 235], 600mi, CT(8, 7, 18), CT(8, 16, 30), -90, 60mi)),
            "Tulagi, 3, 8 May" => V([[MoveTo(Tulagi, CT(8, 13, 15)), MoveTo(day8_target), MoveTo(Tulagi, CT(8, 21, 15))]]), # attacking planes
        )
    end
end

"""
    get_collected_data() 

Return dummy value. It is used to show example data and the usage.
"""
function get_collected_data()
    get_pos_by_name(name, time) = SpatPos(0,0)
    forward_deg(pos, angle, dist) = (pos, angle)
    V(x...)=x

    return get_collected_data(get_pos_by_name, forward_deg, V)
end
