import sys
import pandas as pd

# with open(sys.argv[1]) as classI:
# 		next(classI)
# 		for line in classI:
# 			data = line.strip().split(",")
# 			print data[-1]
# 			print float(data[-1])

			# if float(data[-1]) <= 2 and float(data[-2]) <=500:
			# 	print(data[1] + "\t" + data[2])
infoDic = {}
with open(sys.argv[2]) as patInfo:
	for line in patInfo:
			data = line.strip().split("\t")
			infoDic[data[0]] = { 'wt': data[1], 'protpos': data[3] }


data = pd.read_csv(sys.argv[1])
# data.sort_values(by=['RANK_BY_RANK'])
counter = 0
for k,i in data.sort_values(by=['RANK_BY_RANK']).iterrows():
# for k,i in data.iterrows():
	 if i['IC50_BY_RANK']<=500 and i['RANK_BY_RANK'] <=2:
		counter+=1
			# print ",".join([i['ID'], i['EPITOPE'],i['IC50_BY_RANK'], i['RANK_BY_RANK']])
	
		hla = list(i['HLA_BY_RANK'].split("-")[1])
		hla.insert(1,'*')
		tesla_hla = ''.join(hla)
		print str(counter)  + ",," + i['EPITOPE'] + "," + tesla_hla  + ","  + str(i['ID']) + "," + infoDic[i['ID']]['wt'] + "," + str(9) + "," + infoDic[i['ID']]['protpos'] + ",,,,,,"  + "IC50:"+str(i['IC50_BY_RANK']) + ";" + "RANK:" + str(i['RANK_BY_RANK'])
