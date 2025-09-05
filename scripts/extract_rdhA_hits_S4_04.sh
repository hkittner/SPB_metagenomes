# Define your directories (adjust as needed)
proteins_dir="/ocean/projects/ees240004p/hkittner/all_bins_analyses/S4_04"
rdhA_hits_dir="/ocean/projects/ees240004p/hkittner/rdhA/S4_04_hmmer_results"
output_dir="/ocean/projects/ees240004p/hkittner/rdhA/rdhA_sequences"


# Ensure output directory exists
mkdir -p "$output_dir"

# Loop through each rdhA_hits.tbl file
for tbl in "$rdhA_hits_dir"/*-proteins_rdhA_hits.tbl; do
    bin_name=$(basename "$tbl" "-proteins_rdhA_hits.tbl")  # Extract bin name
    faa_file="$proteins_dir/${bin_name}-proteins.faa"  # Find corresponding .faa file

    if [[ ! -f "$faa_file" ]]; then
        echo "No matching .faa file for $bin_name, skipping..."
        continue
    fi

    # Temporary file to store ORF IDs and E-values
    tmp_orf_file="$output_dir/${bin_name}_filtered_orfs.txt"

    # Extract ORF IDs and E-values from HMMER results (column 1 = ORF ID, column 5 = E-value)
    awk '$5 < 1e-3 {print $1, $5}' "$tbl" > "$tmp_orf_file"

    # Check if there are any hits before proceeding
    if [[ ! -s "$tmp_orf_file" ]]; then
        echo "No significant rdhA hits in $bin_name, skipping..."
        rm "$tmp_orf_file"
        continue
    fi

    # Create output FASTA file
    output_faa="$output_dir/${bin_name}_rdhA.faa"
    > "$output_faa"

    # Extract and rename matching sequences with metadata
    while read -r orf_id evalue; do
        # Use grep to extract full-length sequence
        seq=$(awk -v id="$orf_id" '
            BEGIN { found=0 }
            $0 ~ ">"id { found=1; print; next }
            found && $0 !~ ">" { print }
            found && $0 ~ ">" { found=0 }
        ' "$faa_file")

        # Only add to output if a valid sequence was found
        if [[ -n "$seq" ]]; then
            echo ">$bin_name|rdhA|$orf_id|E=$evalue" >> "$output_faa"
            echo "$seq" >> "$output_faa"
        else
            echo "Sequence not found for $orf_id in $bin_name"
        fi
    done < "$tmp_orf_file"

    echo "Extracted rdhA sequences for $bin_name"

    # Cleanup temporary file
    rm "$tmp_orf_file"
done

echo "All bins processed! Extracted rdhA sequences saved in: $output_dir"
