function out =  exponential(betaValue, x)
  out = (1 + exp(-2*x*betaValue)) .^ -1;
endfunction
