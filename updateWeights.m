function [W, previousDeltaW, minDeltaW] = updateWeights(W, eta, delta, V, inp, momentum, previousDeltaW, firstTime)
  if (firstTime == 0)
	  momentum = 0;
  endif
  actualDeltaW = (eta * (delta{1}' * inp')) + momentum * previousDeltaW{1};
  minDeltaW = min(min(actualDeltaW));
  W{1} = W{1} + actualDeltaW;
  previousDeltaW{1} = actualDeltaW;
  for m = 2 : length(W)
    if(minDeltaW > min(min(actualDeltaW)))
      minDeltaW = min(min(actualDeltaW));
    endif
    actualDeltaW = (eta * (delta{m}' * V{m-1}')) + momentum * previousDeltaW{m};
    W{m} = W{m} + actualDeltaW;
    previousDeltaW{m} = actualDeltaW;
  endfor
endfunction
