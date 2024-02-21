function [H, V] = arnoldi(A, v, m)
% Arnoldi Algorithm
% Input Parameters:
% A: Matrix to be solved
% v: Initial vector
% m: Number of steps in Arnoldi iteration
% Output Parameters:
% H: Upper Hessenberg matrix
% V: Arnoldi matrix

n = length(v);
V = sparse(zeros(n, m+1));
H = sparse(zeros(m+1, m));

V(:,1) = v / norm(v);

for j = 1:m
    w = sparse(A * V(:,j));
    for i = 1:j
        H(i, j) = dot(w, V(:,i));
        w = sparse(w - H(i, j) * V(:,i));
    end
    H(j+1, j) = norm(w);
    
    if H(j+1, j) ~= 0 && j ~= m
        V(:,j+1) = w / H(j+1, j);
    else
        break;
    end
end

V = V(:, 1:m);
H = H(1:m, :);
end