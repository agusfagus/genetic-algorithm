% datos utiles:
% M es la cantidad de capas (sin contar la primera)
% H es un cell array de M arrays
% H(i) es un array que es el resultado de haber hecho matriz de peso * el valor de las unidades de entrada
% V es un cell array de M arrays
% V{i} es un array igual a H pero todos los elementos evaluados en g

% delta es un cell array de M arrays
% delta{i} es un array de la i-esima capa con un delta por cada unidad de esa capa

% W es un cell array de M matrices
% W(i) es una matriz de k * (N+1). k va a representar cada nodo de la capa DESTINO de W(i), y N la cantidad de nodos de la capa ORIGEN de W (+1 por el umbral).

%cosas utiles:
% El V evaluado en la capa ORIGEN, osea el v(i) va a ser de tamaño (N+1) (sirve saber esto para la mult de matrices con W y V)

function perceptron = multiLayerPerceptron(max_ages, W,values, layerSizes, eta, gValue, betaValue, error, momentum, etaAdaptativo, a, b, minimumDeltaError, noisePercentage)
	% Esta funcion calcula con valores random todas las matrices de pesos iniciales, dependiendo de el layerSizes (Array en el que cada valor reprresenta cantidad de neuronas por capa)
	% Devuelve en A un cell de matrices de pesos. (No olvidar el peso del umbral)
  previousDeltaW = W;
	M = length(layerSizes);
  firstTime = 0;
  etaIterator = 1;
  initialMomentum = momentum;
  % tic;
  functions{1, 1} = @tanhFunc;
  functions{1, 2} = @derivativeTanh;
  functions{2, 1} = @exponential;
  functions{2, 2} = @exponentialDerivated;
  g = functions{gValue, 1};
  dg = functions{gValue, 2};
  age = 0;
  outValues = forwardPropagation(W, values(:, 1), M, betaValue, g);
  [finished, previousError] = compareOutValues(values(:, 2), outValues, error);
  errors(1) = previousError;
  previousW = W;
  do
    iterVector = randperm(length(values));
    for i = iterVector;
      inp = values(i, 1);
      inp(end+1, 1) = -1;
      for j = 1 : M
        if (j == 1)
          H{j} = outValue(inp, W{j});
        else
          H{j} = outValue(V{j-1}, W{j});
        endif
        % if(j == M)
        %   V{j} = H{j};
        % else
          V{j} = g(betaValue, H{j});
        % endif
        if(j != M)
          V{j}(end + 1, 1) = -1;
        endif
      endfor
      delta{M} = calculateLastDelta(values(i, 2), V{M}, dg, betaValue);
      for m = M : -1 : 2
        delta{m-1} = calculateDeltas(V{m-1}, W{m}, delta{m}, dg, betaValue);
      endfor
      [W, previousDeltaW, minDeltaW] = updateWeights(W, eta, delta, V, inp, momentum, previousDeltaW, firstTime);
      firstTime = 1;
    endfor
    outValues = forwardPropagation(W, values(:, 1), M, betaValue, g);
    age = age + 1;
    [finished, errorr] = compareOutValues(values(:, 2), outValues, error);
    errors(end+1) = errorr;

	  if(etaAdaptativo != 0)
      deltaError = errors(end) - errors(end-1);
      if(deltaError < 0)
        previousW = W;
        if(etaIterator == etaAdaptativo)
          eta = eta + a;
          momentum = initialMomentum;
        else
          etaIterator++;
        end
      elseif(deltaError > 0)
        W = previousW;
        momentum = 0;
        eta = eta - eta * b;
        errors(end) = errors(end-1);
        outValues = forwardPropagation(W, values(:, 1), M, betaValue, g);
      else

        etaIterator = 1;
      end
	  end
    if(age > 1 && abs(errors(end) - errors(end - 1)) > 0 && abs(errors(end) - errors(end - 1)) < minimumDeltaError)
      W = addNoise(W, minDeltaW, noisePercentage);
      added = minDeltaW * noisePercentage
    endif
    % if(mod(age, 1) == 0)
    %   % outValues
    %   err = errors(end)
    %   age
    %   eta
    %   hold on;
    %   subplot(2,1,1)
    %   plot(values(:, 1), values(:,2), values(:,1), outValues);
    %   xlabel ("x");
    %   ylabel("f(x)");
    %   subplot(2,1,2);
    %   plot(0 : age, errors);
    %   xlabel("epoca");
    %   ylabel("Error");
    %   hold off;
    % 	refresh;
    % endif
  until(finished || age == max_ages)

  % finalW = W
  % age
  % err = errors(end)
  % layerSizes
  % eta
  % betaValue
  % etaAdaptativo
  % a
  % b
  % toc
  % disp("\n\n");
  % disp("He Aprendido!!\n");

  % ended = 0;
 %
 %  while(ended == 0)
 %    in  = input("Ingrese el conjunto a probar\n");
 %    % if(in < values(1, 1) || in > values(end, 1))
 %    %   disp("El valor ingresado no se encuentra en el intervalo aprendido\n");
 %    %   continue;
 %    % endif
 %    outValues = forwardPropagation(W, in, M, betaValue, g);
 %      hold on;
 %      subplot(2,1,1)
 %      plot(values(:, 1), values(:,2), in, outValues);
 %      xlabel ("x");
 %      ylabel("f(x)");
 %      subplot(2,1,2);
 %      plot(1 : age, errors);
 %      xlabel("epoca");
 %      ylabel("Error");
 %      hold off;
 %      refresh;
 %    % disp("El resultado es: ");
 %    % disp(out);
 %    % disp("\n\n");
 %  endwhile

 perceptron.layerSizes = layerSizes;
 perceptron.eta = eta;
 perceptron.g = g;
 perceptron.dg = dg;
 perceptron.error = errors(end);
 perceptron.momentum = momentum;
 perceptron.etaAdaptativo = etaAdaptativo;
 perceptron.a = a;
 perceptron.b = b;
 perceptron.layerSizes = layerSizes;
 perceptron.weightsVector = weightsToVector(W)
 prueba = vectorToWeights(perceptron.weightsVector,layerSizes)

endfunction

