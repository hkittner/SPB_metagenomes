samples=(
    "A02_01"
    #"A08_01" "A13_01" "A18_01" "A18_03" "A18_04" "A19_01" "A21_01" "A21_04" "A21_05" "S1_01" "S2_01" "S2_04" "S2_05" "S3_01" "S4_01" "S5_01" "S6_01" "S6_06" "S6_10" "S9_01"
)

# Loop through each sample
for sample in "${samples[@]}"; do
    echo "Submitting jobs for sample: $sample"
    
    # Loop through lanes for each sample
    for lane in L001 L002 L003 L005; do  # Assuming lanes are L001, L002, etc. Adjust as needed
        job="trimmomatic_${sample}_${lane}.job"
        if [[ -f $job ]]; then  # Check if the job file exists
            echo "Submitting $job"
            sbatch $job
        else
            echo "Job file $job not found for $sample $lane."
        fi
    done
done
