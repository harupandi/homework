#!/usr/bin/env bash
set -euo pipefail

bytes=$(openssl rand 10)
bytes_base64=$(base64 <<<"$bytes")
bytes_count=$(wc -c <<<"$bytes")
bytes_base64_count=$(wc -c <<<"$bytes_base64")
combined_count=$((bytes_count + bytes_base64_count)) 

echo "Combined count: $combined_count"
echo "Bytes count: $bytes_count"
echo "Bytes base64: $bytes_base64"
echo "Bytes base64 count: $bytes_base64_count"
