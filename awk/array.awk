awk '{a[$1]=$2}END{for(x in a)print a[x]}' awk1.txt

awk '{a[$1]=$2}END{for(x in a)printf("%s\t%d\n",a[x],x)}' awk1.txt

awk '{if (NR>1 && NR<6) a[$1]=$2}END{for(x in a)printf("%s\t%d\n",a[x],x)}' awk1.txt

awk -F'[/,]' 'NR==FNR{a[$0]}NR>FNR{if ($2 in a) print $0}' b a

awk 'NR==FNR{a[$1]++}NR>FNR&&a[$1]>1' test.txt test.txt