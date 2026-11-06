#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
mkdir -p tmp/pdfs output/pdf
background=cream
regenerate=false
while (($#)); do
    case "$1" in
        --charts) regenerate=true; shift ;;
        --background)
            if (($# < 2)); then
                printf '%s\n' 'Missing value for --background (cream, softcream, white, both, or all).' >&2
                exit 2
            fi
            background="$2"; shift 2 ;;
        --help|-h)
            printf '%s\n' 'Usage: bash build.sh [--background cream|softcream|white|both|all] [--charts]'
            exit 0 ;;
        *) printf 'Unknown argument: %s\n' "$1" >&2; exit 2 ;;
    esac
done
case "$background" in
    cream|white|softcream) variants=("$background") ;;
    both) variants=(cream white) ;;
    all) variants=(cream softcream white) ;;
    *) printf 'Unknown background: %s\n' "$background" >&2; exit 2 ;;
esac
for variant in "${variants[@]}"; do
    if [[ "$regenerate" == true ]]; then
        python3 generate_charts.py --background "$variant"
    fi
    deck=ffloyd_metropolis_demo
    if [[ "$variant" != cream ]]; then deck="ffloyd_metropolis_${variant}_demo"; fi
    latexmk -lualatex -interaction=nonstopmode -halt-on-error \
        -outdir=tmp/pdfs "${deck}.tex"
    cp "tmp/pdfs/${deck}.pdf" "output/pdf/${deck}.pdf"
    printf 'Built output/pdf/%s.pdf\n' "$deck"
done
