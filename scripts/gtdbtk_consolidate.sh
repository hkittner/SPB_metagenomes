#!/usr/bin/env bash
set -euo pipefail

# Root where your GTDB-Tk classify outputs live
GTDB_ROOT="/ocean/projects/ees240004p/hkittner/gtdbtk_output"

OUT="${GTDB_ROOT}/combined_gtdbtk.tsv"
> "$OUT"
header_done=0

# loop over all classify outputs
for d in "${GTDB_ROOT}"/gtdbtk_classify_*_coassembly; do
  [[ -d "$d" ]] || continue
  sample="$(basename "$d" | sed 's/^gtdbtk_classify_//')"   # e.g. A08_01_coassembly

  # try bac120 first, then ar53 (some dirs have both; we'll include both)
  for tsv in "$d"/gtdbtk.bac120.summary.tsv "$d"/gtdbtk.ar53.summary.tsv; do
    [[ -s "$tsv" ]] || continue

    # write header once, with a leading Sample column
    if (( header_done == 0 )); then
      { printf "Sample\t"; head -n1 "$tsv"; } > "$OUT"
      header_done=1
    fi

    # append rows; add Sample; strip .fa/.fasta from user_genome for easier joining later
    tail -n +2 "$tsv" \
      | awk -v S="$sample" 'BEGIN{OFS="\t"}{
           g=$1; sub(/\.(fa|fasta|fna|fas)$/,"",g); $1=g; print S,$0
         }' >> "$OUT"
    echo "Added $(basename "$tsv")"
  done
done

echo "Wrote: $OUT"
