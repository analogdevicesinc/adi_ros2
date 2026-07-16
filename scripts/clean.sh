#!/usr/bin/env bash

set -euo pipefail

workspace_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

targets=(
    "${workspace_dir}/build"
    "${workspace_dir}/install"
    "${workspace_dir}/log"
)

printf 'Removing:'
printf ' %q' "${targets[@]}"
printf '\n'

rm -rf "${targets[@]}"