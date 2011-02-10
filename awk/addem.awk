awk '/^#/ {
	amount=$2*$3
	printf "%s %6.2f\n",$0,amount
	next
	}
{print}' $*
