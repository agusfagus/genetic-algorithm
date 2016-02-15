function ret = halfCuadraticError(expectedValues, obtainedValues)
	ret = (0.5*sum((expectedValues - obtainedValues) .^ 2)) / length(expectedValues);
endfunction

