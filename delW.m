function deltaW = delW(deltaGa, deltaGd, oldW) % Thm1 : update column-normalized adjency matrix (delW)
% deltaGa : all add edges in delG;
% deltaGb : all delte edges in delG;
% oldW : the column-normalized adjency matrix W for old graph G.

    D = sum(oldW~=0);
    delDa = sum(deltaGa);
    delDd = sum(deltaGd);
    delD = delDa + delDd;
    [~, nonzeroCols] = find(delDa + abs(delDd));
    J = unique(nonzeroCols);
    n = size(oldW, 1);
    deltaW = sparse(n, n);

    for j = 1:length(J)
        % Find indices where deltaGd and deltaGa are nonzero for column j
        idx_deltaGd = deltaGd(:, J(j)) ~= 0;
        idx_deltaGa = deltaGa(:, J(j)) ~= 0;

        % If deltaGd is nonzero for column j
        deltaW(idx_deltaGd, J(j)) = -1 / D(J(j));

        % If deltaGa is nonzero for column j
        deltaW(idx_deltaGa, J(j)) = 1 / (D(J(j)) + delD(J(j)));

        % If oldW is nonzero for column j
        idx_oldW = oldW(:, J(j)) ~= 0 & deltaGd(:, J(j)) == 0;
        deltaW(idx_oldW, J(j)) = (- delD(J(j))) / (D(J(j)) * (D(J(j))+delD(J(j))));
    end
end