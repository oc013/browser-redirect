#!/bin/bash

main_browser="firefox"
redirect_browser="chromium"

redirect_matches_list="${HOME}/browser-redirect-matches.txt"

is_redirect_match=0

# Create matches file if it doesn't exist
if [ ! -f "${redirect_matches_list}" ]; then
    touch "${redirect_matches_list}"
else
    if [[ ! -z $1 ]]; then
        while read -r test; do
            if [[ ${1} =~ ${test} ]]; then
                is_redirect_match=1;
                break;
            fi
        done <$redirect_matches_list
    fi
fi

if (( $is_redirect_match < 1 )); then
    target_browser=${main_browser}
else
    target_browser=${redirect_browser}
fi

${target_browser} $@ &
