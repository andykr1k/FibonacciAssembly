fillFib.out: initArrayStruct.c fillFibonnaciArray.s fillFibonnaciStruct.s
	gcc initArrayStruct.c *.s -o fillFib.out

rm:
	rm -f fillFib.out