__get_us_aqi_score() {
    local carbon_monoxide=1949.31
    local nitrogen_dioxide=35.64
    local ozone=35.41
    local sulphur_dioxide=16.21
    local fine_particle_matter=31.14
    local coarse_particulate_matter=45.16

    carbon_monoxide_ppm=$(__convert_uqgm3_ppm "$carbon_monoxide")
    nitrogen_dioxide_ppb=$(__convert_uqgm3_ppb "$nitrogen_dioxide" "46.01")
    ozone_ppb=$(__convert_uqgm3_ppb "$ozone" "48.00")
    sulphur_dioxide_ppb=$(__convert_uqgm3_ppb "$sulphur_dioxide" "64.06")

    # CO ppm (8-hr)
    if (( $(echo "$carbon_monoxide_ppm < 4.5" | bc -l) )); then
        carbon_monoxide_aqi_value=$(echo "scale=3; (50/4.4) * $carbon_monoxide_ppm" | bc -l)
    elif (( $(echo "$carbon_monoxide_ppm < 9.5" | bc -l) )); then
        carbon_monoxide_aqi_value=$(echo "scale=3; (49/4.9) * ($carbon_monoxide_ppm - 4.5) + 51" | bc -l)
    elif (( $(echo "$carbon_monoxide_ppm < 12.5" | bc -l) )); then
        carbon_monoxide_aqi_value=$(echo "scale=3; (49/2.9) * ($carbon_monoxide_ppm - 9.5) + 101" | bc -l)
    elif (( $(echo "$carbon_monoxide_ppm < 15.5" | bc -l) )); then
        carbon_monoxide_aqi_value=$(echo "scale=3; (49/2.9) * ($carbon_monoxide_ppm - 12.5) + 151" | bc -l)
    elif (( $(echo "$carbon_monoxide_ppm < 30.5" | bc -l) )); then
        carbon_monoxide_aqi_value=$(echo "scale=3; (99/14.9) * ($carbon_monoxide_ppm - 15.5) + 201" | bc -l)
    elif (( $(echo "$carbon_monoxide_ppm < 40.5" | bc -l) )); then
        carbon_monoxide_aqi_value=$(echo "scale=3; (99/9.9) * ($carbon_monoxide_ppm - 30.5) + 301" | bc -l)
    elif (( $(echo "$carbon_monoxide_ppm < 50.5" | bc -l) )); then
        carbon_monoxide_aqi_value=$(echo "scale=3; (99/9.9) * ($carbon_monoxide_ppm - 40.5) + 401" | bc -l)
    fi

    # NO2 ppb (1-hr)
    if (( $(echo "$nitrogen_dioxide_ppb < 54" | bc -l) )); then
        nitrogen_dioxide_aqi_value=$(echo "scale=3; (50/53) * $nitrogen_dioxide_ppb" | bc -l)
    elif (( $(echo "$nitrogen_dioxide_ppb < 101" | bc -l) )); then
       nitrogen_dioxide_aqi_value=$(echo "scale=3; (49/46) * ($nitrogen_dioxide_ppb - 54) + 51" | bc -l)
    elif (( $(echo "$nitrogen_dioxide_ppb < 361" | bc -l) )); then
        nitrogen_dioxide_aqi_value=$(echo "scale=3; (49/259) * ($nitrogen_dioxide_ppb - 101) + 101" | bc -l)
    elif (( $(echo "$nitrogen_dioxide_ppb < 650" | bc -l) )); then
        nitrogen_dioxide_aqi_value=$(echo "scale=3; (49/288) * ($nitrogen_dioxide_ppb - 361) + 151" | bc -l)
    elif (( $(echo "$nitrogen_dioxide_ppb < 1250" | bc -l) )); then
        nitrogen_dioxide_aqi_value=$(echo "scale=3; (99/599) * ($nitrogen_dioxide_ppb - 650) + 201" | bc -l)
    elif (( $(echo "$nitrogen_dioxide_ppb < 1650" | bc -l) )); then
        nitrogen_dioxide_aqi_value=$(echo "scale=3; (99/399) * ($nitrogen_dioxide_ppb - 1250) + 301" | bc -l)
    elif (( $(echo "$nitrogen_dioxide_ppb < 2050" | bc -l) )); then
        nitrogen_dioxide_aqi_value=$(echo "scale=3; (99/399) * ($nitrogen_dioxide_ppb - 1650) + 401" | bc -l)
    fi

    # O3 ppb (8-hr)
    if (( $(echo "$ozone_ppb < 55" | bc -l) )); then
        ozone_aqi_value=$(echo "scale=3; (50/54) * $ozone_ppb" | bc -l)
    elif (( $(echo "$ozone_ppb < 71" | bc -l) )); then
        ozone_aqi_value=$(echo "scale=3; (49/15) * ($ozone_ppb - 55) + 51" | bc -l)
    elif (( $(echo "$ozone_ppb < 86" | bc -l) )); then
        ozone_aqi_value=$(echo "scale=3; (49/14) * ($ozone_ppb - 71) + 101" | bc -l)
    elif (( $(echo "$ozone_ppb < 106" | bc -l) )); then
        ozone_aqi_value=$(echo "scale=3; (49/19) * ($ozone_ppb - 86) + 151" | bc -l)
    elif (( $(echo "$ozone_ppb < 201" | bc -l) )); then
        ozone_aqi_value=$(echo "scale=3; (99/94) * ($ozone_ppb - 106) + 201" | bc -l)
    fi

    # SO2 ppb (1-hr)
    if (( $(echo "$sulphur_dioxide_ppb < 36" | bc -l) )); then
        sulphur_dioxide_aqi_value=$(echo "scale=3; (50/35) * $sulphur_dioxide_ppb" | bc -l)
    elif (( $(echo "$sulphur_dioxide_ppb < 76" | bc -l) )); then
        sulphur_dioxide_aqi_value=$(echo "scale=3; (49/39) * ($sulphur_dioxide_ppb - 36) + 51" | bc -l)
    elif (( $(echo "$sulphur_dioxide_ppb < 186" | bc -l) )); then
        sulphur_dioxide_aqi_value=$(echo "scale=3; (49/109) * ($sulphur_dioxide_ppb - 76) + 101" | bc -l)
    elif (( $(echo "$sulphur_dioxide_ppb < 305" | bc -l) )); then
        sulphur_dioxide_aqi_value=$(echo "scale=3; (49/118) * ($sulphur_dioxide_ppb - 186) + 151" | bc -l)
    elif (( $(echo "$sulphur_dioxide_ppb < 605" | bc -l) )); then
        sulphur_dioxide_aqi_value=$(echo "scale=3; (99/299) * ($sulphur_dioxide_ppb - 305) + 201" | bc -l)
    elif (( $(echo "$sulphur_dioxide_ppb < 805" | bc -l) )); then
        sulphur_dioxide_aqi_value=$(echo "scale=3; (99/199) * ($sulphur_dioxide_ppb - 605) + 301" | bc -l)
    elif (( $(echo "$sulphur_dioxide_ppb < 1005" | bc -l) )); then
        sulphur_dioxide_aqi_value=$(echo "scale=3; (99/199) * ($sulphur_dioxide_ppb - 805) + 401" | bc -l)
    fi

    # PM2.5 (24-hr)
    if (( $(echo "$fine_particle_matter < 12.1" | bc -l) )); then
        fine_particle_aqi_value=$(echo "scale=3; (50/12) * $fine_particle_matter" | bc -l)
    elif (( $(echo "$fine_particle_matter < 35.5" | bc -l) )); then
        fine_particle_aqi_value=$(echo "scale=3; (49/23.3) * ($fine_particle_matter - 12.1) + 51" | bc -l)
    elif (( $(echo "$fine_particle_matter < 55.5" | bc -l) )); then
        fine_particle_aqi_value=$(echo "scale=3; (49/19.9) * ($fine_particle_matter - 35.5) + 101" | bc -l)
    elif (( $(echo "$fine_particle_matter < 150.5" | bc -l) )); then
        fine_particle_aqi_value=$(echo "scale=3; (49/94.9) * ($fine_particle_matter - 55.5) + 151" | bc -l)
    elif (( $(echo "$fine_particle_matter < 250.5" | bc -l) )); then
        fine_particle_aqi_value=$(echo "scale=3; (99/99.9) * ($fine_particle_matter - 150.5) + 201" | bc -l)
    elif (( $(echo "$fine_particle_matter < 350.5" | bc -l) )); then
        fine_particle_aqi_value=$(echo "scale=3; (99/99.9) * ($fine_particle_matter - 250.5) + 301" | bc -l)
    elif (( $(echo "$fine_particle_matter < 500.5" | bc -l) )); then
        fine_particle_aqi_value=$(echo "scale=3; (99/149.9) * ($fine_particle_matter - 350.5) + 401" | bc -l)
    fi

    # PM10 (24-hr)
    if (( $(echo "$coarse_particulate_matter < 55" | bc -l) )); then
        coarse_particulate_aqi_value=$(echo "scale=3; (50/54) * $coarse_particulate_matter" | bc -l)
    elif (( $(echo "$coarse_particulate_matter < 155" | bc -l) )); then
        coarse_particulate_aqi_value=$(echo "scale=3; (49/99) * ($coarse_particulate_matter - 55) + 51" | bc -l)
    elif (( $(echo "$coarse_particulate_matter < 255" | bc -l) )); then
        coarse_particulate_aqi_value=$(echo "scale=3; (49/99) * ($coarse_particulate_matter - 155) + 101" | bc -l)
    elif (( $(echo "$coarse_particulate_matter < 355" | bc -l) )); then
        coarse_particulate_aqi_value=$(echo "scale=3; (49/99) * ($coarse_particulate_matter - 255) + 151" | bc -l)
    elif (( $(echo "$coarse_particulate_matter < 425" | bc -l) )); then
        coarse_particulate_aqi_value=$(echo "scale=3; (99/69) * ($coarse_particulate_matter - 355) + 201" | bc -l)
    elif (( $(echo "$coarse_particulate_matter < 505" | bc -l) )); then
        coarse_particulate_aqi_value=$(echo "scale=3; (99/79) * ($coarse_particulate_matter - 425) + 301" | bc -l)
    elif (( $(echo "$coarse_particulate_matter < 605" | bc -l) )); then
        coarse_particulate_aqi_value=$(echo "scale=3; (99/99) * ($coarse_particulate_matter - 505) + 401" | bc -l)
    fi

    aqi_value=$(__get_aqi_max "$carbon_monoxide_aqi_value" "$nitrogen_dioxide_aqi_value" "$ozone_aqi_value" "$sulphur_dioxide_aqi_value" "$fine_particle_aqi_value" "$coarse_particulate_aqi_value")
    IFS=' ' read -r aqi_level aqi_color aqi_symbol <<< "$(__get_aqi_level_color_symbol "$aqi_value")" 
    rounded_aqi=$(printf '%.*f\n' 0 "$aqi_value")

    # echo "aqi max: $rounded_aqi"
    # echo "aqi level: $aqi_level"
    # echo "aqi color: $aqi_color"
    # echo "aqi symbol: $aqi_symbol"

    # echo $rounded_aqi $aqi_level $aqi_color $aqi_symbol
    echo $aqi_symbol $rounded_aqi
}

__convert_uqgm3_ppm(){
    local uqm3=$1

    ppm=$(echo "scale=3; $uqm3 / 1000" | bc)

    echo $ppm
}

__convert_uqgm3_ppb(){
    local uqm3=$1
    local molecular_weight=$2

    ppb=$(echo "scale=3; ($uqm3 * 24.45) / $molecular_weight" | bc)

    echo $ppb
}

__get_aqi_max(){
    local n1=$1
    local n2=$2
    local n3=$3
    local n4=$4
    local n5=$5
    local n6=$6
   
    max=$n1

    if (( $(echo "$n2 > $max" | bc -l) )); then
        max=$n2
    fi

    if (( $(echo "$n3 > $max" | bc -l) )); then
        max=$n3
    fi

    if (( $(echo "$n4 > $max" | bc -l) )); then
        max=$n4
    fi

    if (( $(echo "$n5 > $max" | bc -l) )); then
        max=$n5
    fi

    if (( $(echo "$n6 > $max" | bc -l) )); then
        max=$n6
    fi

    echo $max
}

__get_aqi_level_color_symbol(){
    local aqi_value=$1

    if (( $(echo "$aqi_value < 51" | bc -l) )); then
        aqi_level="Good"
        aqi_color="Green"
        aqi_symbol="😊"
    elif (( $(echo "$aqi_value < 101" | bc -l) )); then
        aqi_level="Moderate"
        aqi_color="Yellow"
        aqi_symbol="😐"
    elif (( $(echo "$aqi_value < 151" | bc -l) )); then
        aqi_level="Unhealthy for sensitive groups"
        aqi_color="Orange"
        aqi_symbol="🙁"
    elif (( $(echo "$aqi_value < 201" | bc -l) )); then
        aqi_level="Unhealthy"
        aqi_color="Red"
        aqi_symbol="😷"
    elif (( $(echo "$aqi_value < 301" | bc -l) )); then
        aqi_level="Very unhealthy"
        aqi_color="Purple"
        aqi_symbol="😨"
    elif (( $(echo "$aqi_value < 501" | bc -l) )); then
        aqi_level="Hazardous"
        aqi_color="Maroon"
        aqi_symbol="🛑"
    elif (( $(echo "$aqi_value < 1001" | bc -l) )); then
        aqi_level="Very Hazardous"
        aqi_color="Brown"
        aqi_symbol="💀"
    fi 

    echo $aqi_level $aqi_color $aqi_symbol
}

__get_us_aqi_score
