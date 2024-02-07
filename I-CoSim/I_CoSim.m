function delS = I_CoSim(S,W,deltaGa, deltaGd,c,l,k) %I-CoSim
% S : old similarity matrix;
% deltaGa : all add edges in delG;
% deltaGb : all delte edges in delG;
% oldW : the column-normalized adjency matrix W for old graph G;
% c : damping factor; l : size of subspace ; k : number of iteration.

    dW = delW(deltaGa, deltaGd, W);
       nW = W + dW;
       tic;
        E = (1/2*dW + W)'*(S * dW);
        [~, nonzeroCols] = find(E);
        U = unique(nonzeroCols);
        I = speye(size(S, 1));
        delS = sparse(size(S, 1), size(S, 2));
        clear S;
        for i = 1:length(U)
            [Hl,Vl] = arnoldi(nW',c*E(:,U(i)),l);
            [Gl,Wl] = arnoldi(nW',I(:,U(i)),l);
            Mlj = c*norm(I(:,U(i)))*norm(E(:,U(i)))*I(1:l,1)*I(1:l,1)';
            ML = Mlj;
            for j = 1:k
                Mlj = c*Hl*Mlj*Gl';
                ML = sparse(Mlj + ML);
            end
        Ml = sparse(Vl*ML*Wl');
        delS = sparse(delS + Ml);
    end
    delS = delS + delS';

    elapsed_time = toc;
    disp(['Appro delS Code execution time: ', num2str(elapsed_time), ' seconds']); % time test

    clear W nW E Mlj Ml Vl Wl;
    w = whos;
    totalMemoryUsed = sum([w.bytes]);
    disp(['Appro delS : Total memory used: ', num2str(totalMemoryUsed/(1024^2)), ' MB']); % memory test
end