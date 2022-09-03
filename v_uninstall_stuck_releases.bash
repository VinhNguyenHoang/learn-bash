#!/bin/bash

echo "-- Deleting releases that might get stuck in deployment"

declare -A mapNsReleases=(
    ["backend"]="manabie-all-in-one"
    ["local-manabie-kafka"]="kafka-connect"
)

check_exist_and_delete() {
    ns=$1
    release=$2
    res=$(helm -n "${ns}" status "${release}" 2>/dev/null | grep 'STATUS:' | cut -c 9-)
    if [ "$res" == "deployed" ]; then
        echo "Found release ${release}, uninstalling..."
        helm uninstall -n "$1" "$release"
    fi
}

for i in "${!mapNsReleases[@]}"; do
    check_exist_and_delete "$i" "${mapNsReleases[$i]}"
done
