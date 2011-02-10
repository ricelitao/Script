#! /bin/sh
# addemup -- total customer orders
awk 'BEGIN {FS = "\n"; RS = ""}
#NF>=3. If you set RS to an empty string, then AWK will read the entire file into memory
{
	for (i=3;i<=NF;++i) {
	  print $i
		sv=split($i,order," ")
		if (sv==3){
			title=order[1]
			copies=order[2]
			price=order[3]
			amount=copies*price
			total_vol+=copies
			total_amt+=amount
			vol[title]+=copies
			amt[title]+=amount
		} else
			print "Incomplete Record"
		}
}	
END {
	printf "%5s\t%10s\t%6s\n\n","TITLE","COPIES SOLD","TOTAL"
	for (title in vol)
		printf "%5s\t%10d\t%7.2f\n", title,vol[title],amt[title]
	printf "%s\n","------------------------------------"
	printf "\t%s%4d\t$%7.2f\n","Total ",total_vol,total_amt
}' $*
