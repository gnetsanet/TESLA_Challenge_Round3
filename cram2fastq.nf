/*
CRAM to FASTQ Converter for TESLA  Round3 Challenge



Patient20_normal.cram
Patient20_tumor.cram
Patient21_normal.cram
Patient21_tumor.cram
Patient22_normal.cram
Patient22_tumor.cram
Patient23_normal.cram
Patient23_tumor.cram
Patient24_normal.cram
Patient24_tumor.cram
Patient25_normal.cram
Patient25_tumor.cram
Patient26_normal.cram
Patient26_tumor.cram
Patient27_normal.cram
Patient27_tumor.cram
Patient28_normal.cram
Patient28_tumor.cram
Patient29_normal.cram
Patient29_tumor.cram
Patient30_normal.cram
Patient30_tumor.cram
Patient31_normal.cram
Patient31_tumor.cram
Patient32_normal.cram
Patient32_tumor.cram
Patient33_normal.cram
Patient33_tumor.cram
Patient34_normal.cram
Patient34_tumor.cram
Patient35_normal.cram
Patient35_tumor.cram
Patient36_normal.cram
Patient36_tumor.cram
Patient37_normal.cram
Patient37_tumor.cram

into 




[Patient20_normal, Patient20_normal.cram]
[Patient20_tumor, Patient20_tumor.cram]
[Patient21_normal, Patient21_normal.cram]
[Patient21_tumor, Patient21_tumor.cram]
[Patient22_normal, Patient22_normal.cram]
[Patient22_tumor, Patient22_tumor.cram]
[Patient23_normal, Patient23_normal.cram]
[Patient23_tumor, Patient23_tumor.cram]
[Patient24_normal, Patient24_normal.cram]
[Patient24_tumor, Patient24_tumor.cram]
[Patient25_normal, Patient25_normal.cram]
[Patient25_tumor, Patient25_tumor.cram]
[Patient26_normal, Patient26_normal.cram]
[Patient26_tumor, Patient26_tumor.cram]
[Patient27_normal, Patient27_normal.cram]
[Patient27_tumor, Patient27_tumor.cram]
[Patient28_normal, Patient28_normal.cram]
[Patient28_tumor, Patient28_tumor.cram]
[Patient29_normal, Patient29_normal.cram]
[Patient29_tumor, Patient29_tumor.cram]
[Patient30_normal, Patient30_normal.cram]
[Patient30_tumor, Patient30_tumor.cram]
[Patient31_normal, Patient31_normal.cram]
[Patient31_tumor, Patient31_tumor.cram]
[Patient32_normal, Patient32_normal.cram]
[Patient32_tumor, Patient32_tumor.cram]
[Patient33_normal, Patient33_normal.cram]
[Patient33_tumor, Patient33_tumor.cram]
[Patient34_normal, Patient34_normal.cram]
[Patient34_tumor, Patient34_tumor.cram]
[Patient35_normal, Patient35_normal.cram]
[Patient35_tumor, Patient35_tumor.cram]
[Patient36_normal, Patient36_normal.cram]
[Patient36_tumor, Patient36_tumor.cram]
[Patient37_normal, Patient37_normal.cram]
[Patient37_tumor, Patient37_tumor.cram]

*/


Channel
        .fromPath("/Users/ngebremedhin/neoantigen_pipeline/cram_files.txt")
        .splitCsv(header: false, strip: true)
        .map { line -> [line[0].tokenize(".")[0], line[0]]}
        .set { metaData }


process cram2fastq {
	
	tag { sampleId }

	memory 8.GB
	

	input:
	set sampleId, cramFile from metaData

	script:
	"""
	mkdir -p /efs/TESLA
	cd /efs/TESLA
	/root/.local/bin/aws s3 cp s3://bioinformatics-analysis/TESLA/round3_ref_all_sequences.fa ./
	/root/.local/bin/aws s3 cp s3://bioinformatics-analysis/TESLA/round3_ref_all_sequences.fa.fai ./
	/root/.local/bin/aws s3 cp s3://bioinformatics-analysis/TESLA/${cramFile} ./
	/opt/conda/bin/bamtofastq inputformat=cram filename=${cramFile} reference=round3_ref_all_sequences.fa F=${sampleId}.R1.fastq F2=${sampleId}.R2.fastq
	/root/.local/bin/aws s3 cp ${sampleId}.R1.fastq s3://bioinformatics-analysis/TESLA/
	/root/.local/bin/aws s3 cp ${sampleId}.R2.fastq s3://bioinformatics-analysis/TESLA/
	"""
}
