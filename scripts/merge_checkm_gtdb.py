#!/usr/bin/env python3
import sys, os, pandas as pd

# Inputs (edit if you like, or pass as args)
CHECKM = "/ocean/projects/ees240004p/hkittner/checkm_output/combined_checkm.tsv"
GTDB   = "/ocean/projects/ees240004p/hkittner/gtdbtk_output/combined_gtdbtk.tsv"
OUT    = "/ocean/projects/ees240004p/hkittner/combined_checkm_gtdbtk.tsv"

if len(sys.argv) >= 3:
    CHECKM = sys.argv[1]
    GTDB   = sys.argv[2]
if len(sys.argv) >= 4:
    OUT = sys.argv[3]

# Read
cm = pd.read_csv(CHECKM, sep="\t")
gt = pd.read_csv(GTDB,   sep="\t")

# Normalize ID fields:
# - CheckM 'Bin Id' is the genome ID; ensure it's string
# - GTDB 'user_genome' is the filename-based ID; strip extensions to match CheckM
if "Bin Id" not in cm.columns:
    # some CheckM versions use 'Bin_Id' or 'Bin Id'
    alt = [c for c in cm.columns if c.replace("_"," ").lower() == "bin id"]
    if alt:
        cm = cm.rename(columns={alt[0]: "Bin Id"})
    else:
        raise SystemExit("Could not find 'Bin Id' in CheckM table headers.")

if "user_genome" not in gt.columns:
    # newer GTDB-Tk may use 'user_genome' consistently; if not, try to guess
    raise SystemExit("Could not find 'user_genome' in GTDB-Tk table headers.")

cm["Bin Id"] = cm["Bin Id"].astype(str)

def strip_ext(s):
    s = str(s)
    for ext in (".fa", ".fasta", ".fna", ".fas"):
        if s.endswith(ext):
            return s[: -len(ext)]
    return s

gt["user_genome_norm"] = gt["user_genome"].map(strip_ext)

# Merge strategy:
# 1) Merge on exact ID (CheckM 'Bin Id' == GTDB 'user_genome_norm')
merged = cm.merge(gt, left_on="Bin Id", right_on="user_genome_norm", how="left")

# Optional: tidy columns (move key taxonomy columns near front if present)
front_cols = [c for c in ["Sample_x","Sample_y","Bin Id","user_genome","classification"] if c in merged.columns]
other_cols = [c for c in merged.columns if c not in front_cols]
merged = merged[front_cols + other_cols]

# Prefer the CheckM Sample column if both exist
if "Sample_x" in merged.columns:
    merged = merged.rename(columns={"Sample_x":"Sample"})
    merged = merged.drop(columns=[c for c in ["Sample_y"] if c in merged.columns])
elif "Sample" not in merged.columns and "Sample_y" in merged.columns:
    merged = merged.rename(columns={"Sample_y":"Sample"})

# Write
merged.to_csv(OUT, sep="\t", index=False)
print(f"Wrote: {OUT}")
print(f"CheckM rows: {len(cm):,}   GTDB rows: {len(gt):,}   Merged rows: {len(merged):,}")
