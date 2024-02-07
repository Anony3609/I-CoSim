function normA = normA(oldG) % build the column-normalized adjacency matrix (W/delW..)
%oldG : the old graph - sparse form matrix

    % Compute the sum of each column in oldG
    colSum = sum(oldG);

    % Create a copy of oldG as the normalized matrix
    normA = oldG;

    % Normalize the columns that have non-zero sum
    nonzeroCols = colSum ~= 0;
    normA(:, nonzeroCols) = oldG(:, nonzeroCols) ./ colSum(nonzeroCols);
end