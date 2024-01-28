TMUX_POWERLINE_SEG_AIR_JSON="jq"


__get_coordinates(){
    location_data=$(curl -s "https://api.ipgeolocation.io/ipgeo?apiKey=${TMUX_POWERLINE_SEG_AIR_IP_GEOLOCATION_API_KEY}&fields=geo")

    jsonparser="${TMUX_POWERLINE_SEG_AIR_JSON}"
    latitude=$(echo "$location_data" | $jsonparser -r .latitude)
    longitude=$(echo "$location_data" | $jsonparser -r .longitude)

    echo "$latitude, $longitude"
}

__get_coordinates
