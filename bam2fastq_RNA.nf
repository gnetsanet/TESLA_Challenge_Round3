/*
BAM to FASTQ Converter for TESLA  Round3 Challenge



Patient20_RNA.bam
Patient21_RNA.bam
Patient22_RNA.bam
Patient23_RNA.bam
Patient24_RNA.bam
Patient25_RNA.bam
Patient26_RNA.bam
Patient27_RNA.bam
Patient28_RNA.bam
Patient29_RNA.bam
Patient30_RNA.bam
Patient31_RNA.bam
Patient32_RNA.bam
Patient33_RNA.bam
Patient34_RNA.bam
Patient35_RNA.bam
Patient36_RNA.bam
Patient37_RNA.bam

into 




[Patient20_RNA, Patient20_RNA.bam]
[Patient21_RNA, Patient21_RNA.bam]
[Patient22_RNA, Patient22_RNA.bam]
[Patient23_RNA, Patient23_RNA.bam]
[Patient24_RNA, Patient24_RNA.bam]
[Patient25_RNA, Patient25_RNA.bam]
[Patient26_RNA, Patient26_RNA.bam]
[Patient27_RNA, Patient27_RNA.bam]
[Patient28_RNA, Patient28_RNA.bam]
[Patient29_RNA, Patient29_RNA.bam]
[Patient30_RNA, Patient30_RNA.bam]
[Patient31_RNA, Patient31_RNA.bam]
[Patient32_RNA, Patient32_RNA.bam]
[Patient33_RNA, Patient33_RNA.bam]
[Patient34_RNA, Patient34_RNA.bam]
[Patient35_RNA, Patient35_RNA.bam]
[Patient36_RNA, Patient36_RNA.bam]
[Patient37_RNA, Patient37_RNA.bam]

*/


Channel
        .fromPath("/Users/ngebremedhin/PeptideArrays_Part2/rna_bams.txt")
        .splitCsv(header: false, strip: true)
        .map { line -> [line[0].tokenize(".")[0], line[0]]}
        .set { metaData }


process bam2fastq {
	
	tag { sampleId }

	memory 32.GB
	

	input:
	set sampleId, bamFile from metaData

	script:
	"""
	mkdir -p /efs/TESLA
	cd /efs/TESLA
	
	/root/.local/bin/aws s3 cp s3://bioinformatics-analysis/data/TESLA/Round3/${bamFile} ./
	/opt/conda/bin/bamtofastq inputformat=bam filename=${bamFile}  F=${sampleId}.R1.fastq F2=${sampleId}.R2.fastq
	/root/.local/bin/aws s3 cp ${sampleId}.R1.fastq s3://bioinformatics-analysis/TESLA/
	/root/.local/bin/aws s3 cp ${sampleId}.R2.fastq s3://bioinformatics-analysis/TESLA/
	"""
}
