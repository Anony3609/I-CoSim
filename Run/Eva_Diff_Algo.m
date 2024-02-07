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
newG = sparse(start_nodes +1, end_nodes +1, weight, num_nodes, num_nodes);

deltaGa = RandomG(50,newG, 1);
deltaGd = sparse(size(newG,1),size(newG,2));
oldG = newG - deltaGa - deltaGd;
oldW = normA(oldG);
S =  CoSim(oldG, 0.8, 2); % Static CoSimRank 
I_CoSim(S,oldW,deltaGa, deltaGd,0.8,5,20); %I-CoSim
DCsim(oldG,deltaGa,0.8, 3); %D-CoSim
E_CoSim(S,oldW,deltaGa, deltaGd,0.8,3); %E-CoSim