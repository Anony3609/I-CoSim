function dSq = DCsim(G,dG,c,K)
% G : old graph;
% dG : all add edges in delG;
% c : damping factor; k : number of iteration.
    tic;
    [~, nonzeroCols] = find(dG);
    U = unique(nonzeroCols);
    I = sparse(speye(size(G)));
    dSq = sparse(size(G, 1), size(G, 2));
    for i = 1:length(U)
        W = zeros(size(G, 1), K + 1);
        W(:, 1) = dG(:,U(i)) - sum(dG(:,U(i)))*G(:,U(i));
        for k = 1:K
            W(:, k+1) = sparse(G*W(:, k));
        end
        r = W(:, K+1);
        for k = 1:K
            r = sparse(c*G'*r + W(:, K + 1 - k));
        end
        dAu = (1/(sum(dG(:,U(i))) + nnz(G(:,U(i)))))*(dG(:,U(i)) - sum(dG(:,U(i)))*G(:,U(i)));
        nA = sparse(G + dAu*I(:, U(i))');
        P = zeros(size(G, 1), K + 1);
        P(:,1) = sparse(I(:, U(i)));
        for k = 1:K
            P(:,k+1) = sparse(nA'* P(:,k));
        end
	T = zeros(size(G, 1), K + 1);
	test = 2 * sum(dG(:, U(i))) + nnz(G(:, U(i)));

	if test == 0
    		T1 = zeros(size(G, 1), 1);
	else
    		tempResult = (G + nA)' * r;
    		T1 = sparse((c / (2 * test)) * tempResult);
	end
	
        T(:,1) = T1;
        for k = 1:K
            T(:,k+1) = sparse(nA*T(:,k));
        end

        s = sparse(size(G, 1), size(G, 2));
        for k = 1:(K+1)
            tk = sparse(T(:,k));
            pk = sparse(P(:,k));
            s = sparse(s+c^k*(tk*pk'+pk*tk'));
        end
        dSq = dSq + s;
        G = nA;
    end
       elapsed_time = toc;
    disp(['Code execution time: ', num2str(elapsed_time), ' seconds']);
    w = whos;
    totalMemoryUsed = sum([w.bytes]);
    disp(['Total memory used: ', num2str(totalMemoryUsed/(1024^2)), ' MB']);
end