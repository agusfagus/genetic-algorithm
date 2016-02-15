function outValues = forwardPropagation(W, values, M, betaValue, g)
		inp = values';
		inp(end+1, :) = -1;
		for j = 1 : M
			if (j == 1)
				H{j} = W{j} * inp;
			else
	    	H{j} = W{j} * V{j-1};
			endif
			% if(j == M)
			% 	V{j} = H{j};
			% else
				V{j} = g(betaValue, H{j});
			% endif
			if(j != M)
				V{j}(end + 1, :) = -1;
			endif
		endfor
		outValues = V{M}';
endfunction
