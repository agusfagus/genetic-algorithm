function der = exponentialDerivated(betaValue, g)
  der = (2*betaValue*g) .* (1-g);
endfunction
