function S = CoSta(graph, c, iter)
% graph : sparse graph;
% c : damping factor;
% iter : number of iterations.

    tic;
    I = speye(size(graph));
    S = I;
    
    colSum = sum(graph);
    normalizedG = graph;
    nonzeroCols = colSum ~= 0;
    normalizedG(:, nonzeroCols) = graph(:, nonzeroCols) ./ colSum(nonzeroCols);
    nG = I;
    for i = 1:iter
        nG = nG*normalizedG;
        S = S + (c^i)*nG'*I*nG;
	disp(i);
    end
    [maxValues, TOPK] = maxk(S(:,1),10);
    elapsed_time = toc;
    disp(['Code execution time: ', num2str(elapsed_time), ' seconds']);
    w = whos;
    totalMemoryUsed = sum([w.bytes]);
    disp(['Total memory used: ', num2str(totalMemoryUsed/(1024^2)), ' MB']);

end
