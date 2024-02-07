function delS = E_CoSim(S,W,deltaGa, deltaGd,c,k) %update one column in E-CoSim
% S : old similarity matrix;
% W : the column-normalized adjency matrix W for old graph G;
% deltaGa : all add edges in delG;
% deltaGb : all delte edges in delG;
% c : damping factor; k : number of iteration.

    dW = delW(deltaGa, deltaGd, W);
    nW = W + dW; %newW = W + delW
    tic;
    E = (1/2*dW + W)'*(S * dW);
       
    [~, nonzeroCols] = find(E); 
    U = unique(nonzeroCols);
    I = speye(size(S, 1));
    delS = sparse(size(S, 1), size(S, 2));
    clear S dW;
    for i = 1:length(U) % set |J| update
        l = c*E(:,U(i));
        r = I(:,U(i))';
        halfS = sparse(l*r);
        for j = 1:k % number of iteration
            l = c*nW'*l;
            r = r*nW;
            col = sparse(l*r);
            halfS = sparse(halfS + col);
        end
        delS = delS + halfS + halfS';
    end    
    elapsed_time = toc;
    disp(['Exact delS execution time: ', num2str(elapsed_time), ' seconds']);
    clear W nW E;
    w = whos;
    totalMemoryUsed = sum([w.bytes]);
    disp(['Exact delS : Total memory used: ', num2str(totalMemoryUsed/(1024^2)), ' MB']);
end