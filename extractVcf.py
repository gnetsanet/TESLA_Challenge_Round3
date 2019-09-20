import sys

with open(sys.argv[1]) as vcFile:
	for line in vcFile:
		if line.startswith("#"):
			continue
		else:
			cols = line.split("\t")
			csq = cols[7].split(";")[3]
			if not csq.startswith("CSQ"):
				csq = cols[7].split(";")[4]
			csqs = csq.split("=")[1]
			acsq = csqs.split("|")
		
			#print line	
			
			if acsq[1]=="missense_variant":
				wt_seq =  acsq[69][int(acsq[14])-5:int(acsq[14])+4]
				mt_seq =  acsq[69][int(acsq[14])-5:int(acsq[14])-1] + acsq[15].split("/")[1] + acsq[69][int(acsq[14]):int(acsq[14])+4] 
				prot_pos = int(acsq[14])-4
				#print wt_seq
				#print mt_seq
				#print cols[2] + "\t" +  cols[0] + "\t" + cols[1] + "\t" + cols[3] + "\t" + cols[4] + "\t" + acsq[1] + "\t" + acsq[3] + "\t" + acsq[14] + "\t" + acsq[15] + "\t" + acsq[67] + "\t" + acsq[68] + "\t"  + wt_seq + "\t" + mt_seq + "\t" +  str(prot_pos)
				print cols[2] + "\t"  + wt_seq + "\t" + mt_seq + "\t" +  str(prot_pos)
				#print acsq[69]

