#!/usr/bin/env bash

((rows=63));
((startIdx=0));
((endIdx=100));
((branchHight=16));
(( treeHight = 0 ));
((root=(endIdx - startIdx) / 2 - 1));
ROOTS=(); # array
ROOTS+=($root);

drawVerticalBranches() {
	for (( i = 0; i < $branchHight; i++ )); do
		line="";

		for (( j = $startIdx;  j < $endIdx; j++ )); do

			# Check if current character index is equal to any of the root indexes
			for rootIdx in ${ROOTS[@]}; do
				if (( j == rootIdx )); then
					character="1";
					break;
				else
					character="_"
				fi
			done

			line="${line}${character}"
		done

		line="${line}\n";

		printf $line;
	done
}

drawDiagonalBranches() {
	for (( i = 0; i < $branchHight; i++ )); do
		line="";

		for (( j = $startIdx;  j < $endIdx; j++ )); do
			# Check if current character index is equal to any of the root indexes
			for rootIdx in $ROOTS; do
				if (( (j == rootIdx - i - 1) || (j == rootIdx + i + 1) )); then
					character="1";
					break;
				else
					character="_";
				fi
			done

			line="${line}${character}"
		done

		line="${line}\n";

		printf $line;
	done
}

drawUnfilledLines() {
	for (( i=0; i < rows - treeHight; i++ )); do
		line="";

		for (( j=$startIdx;  j < $endIdx; j++ )); do
			character="_"
			line="${line}${character}"
		done

		line="${line}\n";

		printf $line;
	done
}

main() {
	read -r N;

	for (( mI = 0; mI < N; mI++ )); do
		(( nRoots = 2 ** mI ));

		if (( nRoots > 1 )); then
			for (( j = 2; j <= nRoots; j++ )); do

				newRoots=();
				for r in ${ROOTS[@]}; do
					(( leftBranch = r - branchHight * 2 ));
					(( rightBranch = r + branchHight * 2 ));

					newRoots+=($leftBranch);
					newRoots+=($rightBranch);
				done

			done
			ROOTS=${newRoots[@]}
		fi

		drawVerticalBranches
		drawDiagonalBranches

		(( treeHight += branchHight * 2 ));
		(( branchHight /= 2 ));
	done

	drawUnfilledLines
}

main  | tac
