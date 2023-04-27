# split_amplicon
An awk script for split each amplicon data from multiple samples NGS fastq file.

Just run this script as below line:

bash 1.extractFq_v0.2.sh path_to_your_barcode path_to_your_multiple_samples_fastq out_path

Attention: multiple_samples_fastq should be decompressed.
The barcode file should be in Tab-Separated format.
The barcoded primer contain 6 nt unique barcode, but we use more longer seq (contain protection bases around barcode) than 6nt can improve the specificity.

