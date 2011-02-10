awk '
	FILENAME=="acronyms" {
		split($0,entry,"|")
		print "1:" entry[1],"2:" entry[2]
		acro[entry[1]]=entry[2]
		print "first:" $acro[entry[1]],"second:" $entry[2]
		next
		}
	/[A-Z][A-Z]+/ {
		for (i=1;i<=NF;i++)
			if ($i in acro) {
				$i=acro[$i] "("$i")"
			}
		}
	{ print $0}' acronyms $*
