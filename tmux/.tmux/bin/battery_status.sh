#!/bin/bash

# # Define color codes
RED='#[fg=colour88, bg=colour237]'
GREEN='#[fg=colour28, bg=colour237]'
YELLOW='#[fg=colour130, bg=colour237]'
# REST='#[fg=colour8, bg=colour237]'

# TODO(?) using █, ░, ▒, etc for full, charging, empty states

# Get the battery state (Discharging, Charging, Full, etc.)
battery_state=$(acpi -b | awk '{print $3}' | tr -d [:punct:])
# Get the battery percentage
battery_percentage=$(acpi -b | grep -oP '\d+' | head -n 2 | tail -n 1)

# Determine the color based on the state and percentage
if [[ "$battery_state" == "Charging" ]]; then
    bar_color=$GREEN
    show_synbol="🗲"
elif [[ "$battery_percentage" -lt 15 ]]; then
    bar_color=$RED
    show_synbol=" "
else
    bar_color=$YELLOW
    show_synbol=" "
fi

# Calculate the number of full blocks based on the percentage
# +1 for compensating the floor divivison
num_blocks=$((battery_percentage / 10 + 1))
num_empty=$((10 - num_blocks))

# Create the progress bar
progress_bar=""
for ((i=0; i<num_blocks; i++)); do
    if [[ i -eq 0 ]]; then
        progress_bar+="${bar_color}["
        # progress_bar+="${bar_color}"
    else
        progress_bar+="■"
        # progress_bar+=">"
    fi
done
for ((i=0; i<num_empty; i++)); do
    progress_bar+=" "
done
# progress_bar+="]"
# progress_bar+="]⟩"
progress_bar+="⟩"

# Output the progress bar and state
# echo "${progress_bar}] ${battery_percentage}% (${battery_state})"
# echo "🔋${progress_bar}] ${battery_percentage}%"
echo "${progress_bar} ${battery_percentage}% ${show_synbol}"
