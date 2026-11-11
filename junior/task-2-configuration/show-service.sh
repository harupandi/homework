#!/usr/bin/env bash
set -euo pipefail

#echo ${BASH_SOURCE[0]}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

config_file="$SCRIPT_DIR/service.conf"

if [[ ! -f "$config_file" ]]; then
    printf 'Error: configuration file not found: %s\n' "$config_file" >&2
    exit 1
fi

source "$config_file"

echo "Service: $SERVICE_NAME"
echo "Environment: $ENVIRONMENT"