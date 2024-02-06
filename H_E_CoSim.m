function delS = H_E_CoSim(S,W,deltaGa, deltaGd,c,k,u) %update one column delS to compute accuracy
% S : old similarity matrix;
% deltaGa : all add edges in delG;
% deltaGb : all delte edges in delG;
% oldW : the column-normalized adjency matrix W for old graph G;
% c : damping factor; k : number of iteration ; u : number of end node in graph.

    dW = delW(deltaGa, deltaGd, W);
    nW = W + dW;
    tic;
    E = (1/2*dW + W)'*(S * dW);
       
    [~, nonzeroCols] = find(E);
    U = unique(nonzeroCols);
    I = speye(size(S, 1));
    delS = sparse(size(S, 1), 1);
    clear S dW;
    for i = 1:length(U)
        l = c*E(:,U(i));
        r = I(:,U(i))';
        halfS = sparse(l(u)*r' + r(u)*l); % only a vector here
        for j = 1:k
            l = c*nW'*l;
            r = r*nW;
            col = sparse(l(u)*r' + r(u)*l);
            halfS = sparse(halfS + col);
        end
        delS = delS + sparse(halfS);
    end    
end