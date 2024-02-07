function delta_G = RandomG(numRandomNumbers, old_G, weight) %Randomly select the delG for future compute
% numRandomNumbers : number of edges in delG ; 
% old_G : the old graph - sparse form matrix ; 
% weight : 1 (add edge) / -1 (delect edge).

    [start_nodes, end_nodes] = find(old_G);
    maxValue = numel(start_nodes);
    rng('shuffle');
    randomNumbers = randi([1, maxValue], 1, numRandomNumbers);

    delta_s_node = zeros(1, numRandomNumbers);
    delta_e_node = zeros(1, numRandomNumbers);

    for i = 1:numRandomNumbers
        node_ID = randomNumbers(i);
        delta_s_node(i) = start_nodes(node_ID);
        delta_e_node(i) = end_nodes(node_ID);
    end

    [delta_nodes, ~] = size(old_G);
    delta_weight = weight * ones(numRandomNumbers, 1);
    delta_G = sparse(delta_s_node , delta_e_node , delta_weight, delta_nodes, delta_nodes);
end