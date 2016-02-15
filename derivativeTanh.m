function der = derivativeTanh(betaValue, g)
	der = betaValue*(1 - g .^ 2);
end
