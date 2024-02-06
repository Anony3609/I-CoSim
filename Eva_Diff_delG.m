%Assess the computational complexity for different sizes of Delta G, where |Delta G| takes values of [10, 20, 30, 40, 50], across four graphs.
cd('/dcs/pg22/u2223948/Desktop/CoSameRank/code') % Change directory to the specified location
fileID = fopen('roadNet-CA.txt','r'); %RCA
%fileID = fopen('web-NotreDame.txt','r'); %WND
%fileID = fopen('email-EuAll.txt','r'); %EEA
%fileID = fopen('Amazon0505.txt','r'); %AMZ
data = textscan(fileID,'%d %d');
fclose(fileID);

start_nodes = data{1};
end_nodes = data{2};
num_edges = numel(start_nodes);
num_nodes = max(max(start_nodes),max(end_nodes))+1;
weight = ones(num_edges,1);

basicG = sparse(start_nodes +1, end_nodes +1, weight, num_nodes, num_nodes);
nnz(basicG)
n = [10, 20, 30, 40, 50] %size of Delta G
for i = 1:length(n)
    disp(['n is ', num2str(n(i))])
    deltaGa = RandomG(n(i), basicG, 1);
    oldG = basicG - deltaGa;
    deltaGb =  RandomG(n(i), oldG, -1);
    oldW = normA(oldG);
    S = CoSim(oldG, 0.8, 2); % Static CoSimRank      
    AdelS = I_CoSim(S,oldW,deltaGa, deltaGb,0.8,5,20); %I-CoSim
end

