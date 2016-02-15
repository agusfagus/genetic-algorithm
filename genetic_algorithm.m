function genetic_algorithm(replace_method, community_size, parents_size, max_generations, mutammunittion_probability, pick_criteria, replacement_criteria)
  community = generate_initial_population_frum(community_size); %implementar una generacion de 'comunity_size' W cells randomly
  community_fitness = evaluate_fitness(community); % implementar el forward propagation que calcule los errores de cada individuo.
  while(!finished(community_fitness, max_generations)) % finished tiene que ser una funcion que evalue si hay que terminar, segun los criterios que dice en la consigna
    people = pick_people(community, pick_criteria); %implementar elite, ruleta, boltzman, torneos y mixto.
    children = copulate(people); % implementar los algoritmos de cruza: clasico(un solo punto), dos puntos, uniforme, anular.
    mutants = mutate(children); % mutacion clasica y no uniforme
    trained = train(mutants, ages_to_train) % hacer backpropagation durante x cantidad de epocas.
    trained_fitness = evaluate_fitness(trained);
    community = generate_new_community(community, mutants) % metodos de reemplazo 1, 2 y 3
  endwhile
endfunction
