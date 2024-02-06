%Evaluate the computational complexity with l = [10, 15, 20, 25] on four datasets
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

deltaGa = RandomG(5, basicG, 1);
oldG = basicG - deltaGa;
deltaGd = RandomG(5, oldG, -1);
oldW = normA(oldG);
S =  CoSim(oldG, 0.8, 2); % Static CoSimRank 

l = [10, 15, 20, 25]; %size of subspace

for i = 1:length(l)
      disp([num2str(l(i))]);
      I_CoSim(S,oldW,deltaGa, deltaGd,0.8,l(i),50); %I-CoSim
end