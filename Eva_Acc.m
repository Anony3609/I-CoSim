cd('/dcs/pg22/u2223948/Desktop/CoSameRank/code'); % Change directory to the specified location
fileID = fopen('roadNet-CA.txt','r'); %RCA
%fileID = fopen('web-NotreDame.txt','r'); %WND
%fileID = fopen('email-EuAll.txt','r'); %EEA
%fileID = fopen('Amazon0505.txt','r'); %AMZ
data = textscan(fileID, '%d %d');
fclose(fileID);

start_nodes = data{1};
end_nodes = data{2};
num_edges = numel(start_nodes);
num_nodes = max(max(start_nodes), max(end_nodes)) + 1;
weight = ones(num_edges, 1);
basicG = sparse(start_nodes + 1, end_nodes + 1, weight, num_nodes, num_nodes);
nnz(basicG)
% Generate random graphs
deltaGa = RandomG(25, basicG, 1);
oldG = basicG - deltaGa;
deltaGd = RandomG(25, oldG, -1);
oldW = normA(oldG);
S =  CoSim(oldG, 0.8, 2); % Static CoSimRank 

% Parameters for experiments
l_values = [5, 10, 15, 15, 15]; %size of subspace
k_values = [20, 20, 20, 25, 30]; %number of iterations
u_values = [10609, 100608, 38696, 13222, 18693, 27097, 21392, 33042, 6088, 10]; %randomly select 10 end nodes in datasets 

% Iterate through different parameter settings
for i = 1:length(l_values)
    acc = 0;
    for u = 1:length(u_values)
	   % Approximate computation
	   AdelS = H_I_CoSim(S, oldW, deltaGa, deltaGd, 0.8, l_values(i), k_values(i), u_values(u)); %I-CoSim
 	   % Exact computation
 	   EdelS = H_E_CoSim(S, oldW, deltaGa, deltaGd, 0.8, k_values(i),u_values(u) ); %E-CoSim

  	   % Compute accuracy
	   acc = acc + sum(abs(AdelS - EdelS));
    end
	% Display results
 	disp(['For l = ', num2str(l_values(i)), ', k = ', num2str(k_values(i)), ', accuracy is ', num2str(acc)]);
end
