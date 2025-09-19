
#!/usr/bin/env bash


# make bash options stricter.
set -euo pipefail

# Assign a variable to the path
TOPDIR="/ocean/projects/ees240004p/hkittner/coassembly_analysis/bins"


for REF_DIR in "${TOPDIR}"/bin_refinement_*; do
    # [[ ... ]] is Bash "test" syntax. -d "$REF_DIR" tests if REF_DIR is an existing directory
    # || means OR, so if the test fails (the directory doesn't exit), then the right command runs and the loop continues to the next line
    [[ -d "$REF_DIR" ]] || continue
    
    # $( ... ) = command substitution. Run the command inside and capture its output.
    # basename strips the path and leaves just the last part
    # s/// means substitute -> ^ = start of string, replace with nothing
    SAMPLE=$(basename "$REF_DIR" | sed 's/^bin_refinement_//')

    # if there's a subdirectory called metawrap_80_5_bins, use that as $BIN_DIR, otherwise just use $REF_DIR
      BIN_DIR="$REF_DIR"
  if [[ -d "$REF_DIR/metawrap_80_5_bins" ]]; then
    BIN_DIR="$REF_DIR/metawrap_80_5_bins"
  fi

  cd "$BIN_DIR"

  for f in bin.*.fa; do
      # tests in the file exists and skips this file if it doesn't
      [[ -e "$f" ]] || continue
      # echo "$f" prints the filename.
      # cut -d. -f2 = split string by delimiter . and take field 2
      num=$(echo "$f" | cut -d. -f2)


