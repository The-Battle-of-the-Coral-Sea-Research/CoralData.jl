
# "key" => 120mi  :=  120 knot, 120nmi / hour

struct Aircraft
    cruise_speed::Float64 # km/h
    maximum_speed::Float64
    range::Float64 # km
end

Base.convert(::Type{Aircraft}, t::Tuple) = Aircraft(t...)

struct Ship
    cruise_speed::Float64
    maximum_speed::Float64
    range::Float64
end

Base.convert(::Type{Ship}, t::Tuple) = Ship(t...)

const aircraft_map = Dict{String, Aircraft}(
    # seaplane

    "Mavis" => (120mi, 180mi, 2590mi), # Kawanishi H6K, 九七式大型飛行艇, service in Shortland, Tulagi
    # https://en.wikipedia.org/wiki/Kawanishi_H6K
    "Dave" => (100mi, 160mi, 485mi), # Nakajima E8N, 九五式水上偵察機, service in MO Striking Force, MO Covering Force (Deboyne)
    # https://en.wikipedia.org/wiki/Nakajima_E8N
    "Alf" => (100mi, 149mi, 2200), # Kawanishi E7K, 九四式水上偵察機, service in MO Main Force (Rossel)
    # https://en.wikipedia.org/wiki/Kawanishi_E7K
    "Jake" => (120mi, 203mi, 1128mi), # Aichi E13A, 零式水上偵察機, service in MO Striking Force, MO Covering Force (Deboyne)
    # https://en.wikipedia.org/wiki/Aichi_E13A
    "Pete" => (160mi, 200mi, 400mi), # Mitsubishi F1M, 零式水上観測機, service in MO Covering Force (Deboyne)
    # https://en.wikipedia.org/wiki/Mitsubishi_F1M
    # The cruise speed is brought from JTS Midway since reference is not given.

    # land based

    "Betty" => (170mi, 231mi, 1540mi), # Mitsubishi G4M, 一式陸上攻撃機, service in Rabaul
    # https://en.wikipedia.org/wiki/Mitsubishi_G4M
    "Nell" => (150mi, 202mi, 2400mi), # Mitsubishi G3M, 九六式陸上攻撃機, service in Rabaul
    # https://en.wikipedia.org/wiki/Mitsubishi_G3M
    
    # carrier based

    # Only "Kate" is used for scouting

    "Claude" => (180mi, 235mi, 648mi), # Mitsubishi A5M, 九六式艦上戦闘機, service in MO Main Force
    # https://en.wikipedia.org/wiki/Mitsubishi_A5M
    # The cruise speed is brought from JTS Midway
    "Zeke" => (180mi, 288mi, 1010mi), # Mitsubishi A6M, 零式艦上戦闘機, service in MO Striking Force, Lae
    # https://en.wikipedia.org/wiki/Mitsubishi_A6M_Zero
    "Kate" => (140mi, 204mi, 528mi), # Nakajima B5N, 九七式艦上攻撃機, service in MO Striking Force, MO Main Force
    # https://en.wikipedia.org/wiki/Nakajima_B5N
    "Val" => (160mi, 209mi, 915mi), # Aichi D3A (D3A1), 九九式艦上爆撃機, service in MO Striking Force 
    # https://en.wikipedia.org/wiki/Aichi_D3A
)

const ship_map = Dict{String, Ship}(
    "Shokaku" => Ship(18mi, 34.2mi, 9700mi), # 翔鶴
    # https://en.wikipedia.org/wiki/Japanese_aircraft_carrier_Sh%C5%8Dkaku
    "Zuikaku" => Ship(18mi, 34.5mi, 6588mi), # 瑞鶴
    # https://en.wikipedia.org/wiki/Japanese_aircraft_carrier_Zuikaku
    "Shoho" => Ship(18mi, 28mi, 7800mi), # 祥鳳
    # https://en.wikipedia.org/wiki/Japanese_aircraft_carrier_Sh%C5%8Dh%C5%8D
    "Kinugasa" => Ship(14mi, 36mi, 8223mi), # 衣笠
    # https://en.wikipedia.org/wiki/Japanese_cruiser_Kinugasa
    "Furutaka" => Ship(14mi, 34.5mi, 6000mi), # 古鷹
    # https://en.wikipedia.org/wiki/Japanese_cruiser_Furutaka
)
