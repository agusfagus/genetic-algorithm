function last = calculateLastDelta(yValues, lastVvalues, dg, betaValue)

	dif = dg(betaValue, lastVvalues) .* (yValues - lastVvalues);
	% dif = yValues - lastVvalues;
  last = dif;

endfunction
