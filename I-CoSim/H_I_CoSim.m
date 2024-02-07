function delS = H_I_CoSim(S,W,deltaGa, deltaGd,c,l,k,u) %update one column delS to compute accuracy
% S : old similarity matrix;
% deltaGa : all add edges in delG;
% deltaGb : all delte edges in delG;
% oldW : the column-normalized adjency matrix W for old graph G;
% c : damping factor; l : size of subspace ; k : number of iteration ; u : number of end node in graph.

    dW = delW(deltaGa, deltaGd, W);
        nW = W + dW;
        tic;
        E = (1/2*dW + W)'*(S * dW);
        [~, nonzeroCols] = find(E); 
        U = unique(nonzeroCols);
        I = speye(size(S, 1));
        delS = sparse(size(S, 1), 1);
        
                for i = 1:length(U)
                        [Hl,Vl] = arnoldi(nW',c*E(:,U(i)),l);
                        [Gl,Wl] = arnoldi(nW',I(:,U(i)),l);
                        Mlj = c*norm(I(:,U(i)))*norm(E(:,U(i)))*I(1:l,1)*I(1:l,1)';
                        ML = Mlj;
                        for j = 1:k
                                Mlj = c*Hl*Mlj*Gl';
                                ML = Mlj + ML;
                        end
                        Wlt = Wl';
                        Mlu1 = Vl*ML*Wlt(:,u);
                        Mlu2 = Vl(u,:)*ML*Wl';
                        delS = delS + Mlu1 + Mlu2';
                end
        elapsed_time = toc;
        disp(['Appro delS Code execution time: ', num2str(elapsed_time), ' seconds']);
        clear W nW E Mlj Vl Wl;
        w = whos;
        totalMemoryUsed = sum([w.bytes]);
        disp(['Appro delS : Total memory used: ', num2str(totalMemoryUsed/(1024^2)), ' MB']);
end