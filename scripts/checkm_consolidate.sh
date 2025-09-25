#!/usr/bin/env bash
set -euo pipefail

BASE_OUT="/ocean/projects/ees240004p/hkittner/checkm_output"
COMBINED="${BASE_OUT}/combined_checkm.tsv"

> "$COMBINED"
first=1

for d in "${BASE_OUT}"/*_coassembly; do
  [[ -d "$d" ]] || continue
  tsv="$d/checkm_summary.tsv"
  if [[ ! -s "$tsv" ]]; then
    checkm qa -o 2 --tab_table -f "$tsv" "$d/lineage.ms" "$d"
  fi
  [[ -s "$tsv" ]] || { echo "Skipping $(basename "$d") (no TSV)"; continue; }

  if (( first )); then
    { printf "Sample\t"; head -n1 "$tsv"; } > "$COMBINED"
    first=0
  fi
  sample="$(basename "$d")"
  tail -n +2 "$tsv" | awk -v S="$sample" 'BEGIN{OFS="\t"}{print S,$0}' >> "$COMBINED"
done

echo "Wrote: $COMBINED"
