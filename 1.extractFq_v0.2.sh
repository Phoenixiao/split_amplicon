#!/bin/bash

#####
#Calculate time elapsed
calculate_time() {
	((h=${1}/3600))
	((m=(${1}%3600)/60))
	((s=${1}%60))
	printf "Time elapsed: %02dh:%02dm:%02ds\n" $h $m $s
}
#####
start=$(date +%s)

barcode_file=$1;
multi_fq=$2;
out_path=$3;

echo "Barcode file is $barcode_file"
echo "multiple_fastq file is $multi_fq"
echo "Out_path is $out_path"
echo -e "Starting extract multiple fastq...\n`date`\n"

awk -F "\t" -v out_path="$out_path" 'BEGIN{
	IGNORECASE = 1;
	header="";
	sequence="";
	plus="";
	quality="";
	}
FILENAME == ARGV[1]{
	barcode[$1] = toupper(substr($2, 3, 20));
	}
FILENAME == ARGV[2]{
	if(FNR%4==1){
		header = $0;
		}
	else if(FNR%4==2){
		sequence = $0;
		}
	else if(FNR%4==3){
		plus = $0;
		}
	else {
		quality = $0;
		#print length(barcode)
		for (i in barcode){
			bcPri = barcode[i];
			if (index(sequence, bcPri)){
				temp_fq = sprintf("%1$s/%2$s.fq", out_path, i);
				record = sprintf("%1$s\n%2$s\n%3$s\n%4$s\n", header, sequence, plus, quality);
				printf record >> temp_fq;
				close(temp_fq);
				}
			}
		}
	}' $barcode_file $multi_fq

end=$(date +%s)
duration=$((end - start))
echo -e "Finished.\n`date`\n"
calculate_time $duration

echo ExtractFq done!

