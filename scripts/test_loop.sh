cd /ocean/projects/ees240004p/hkittner/trimmomatic_output

for file1 in *_forward_paired_trim1.fastq.gz
do
    file2=${file1/forward/reverse}
    out=${file1%%_forward_paired_trim1.fastq.gz}

    echo "files:" ${file1} ${file2}
    echo "Out:" ${out}
done
