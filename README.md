# I-CoSim: Efficient Dynamic CoSimRank Retrieval on Evolving Networks
## Environment
- Windows 10
- Dual Intel Xeon E5-2643 v3 @3.4 GHz CPU, with 60 CPU cores and 128GB memory
- MATLAB

## Main:
(1) Time evaluation:
```matlab
tic;

% Put running code

elapsed_time = toc;
disp(['Execution time: ', num2str(elapsed_time), ' seconds']);
```
(2) Memory evaluation:
```matlab
w = whos;
totalMemoryUsed = sum([w.bytes]);
disp(['Total memory used: ', num2str(totalMemoryUsed/(1024^2)), ' MB']);
```

## Algorithms:
Each algorithm is saved in a different file.

- I-CoSim (file):
  - `I_CoSim.m`: Implementation of the I-CoSim algorithm for updating whole ΔS.
  - `H_I_CoSim.m`: Implementation of the I-CoSim algorithm for updating only ΔS[:,u] to compute accuracy.

- E-CoSim (file):
  - `E_CoSim.m`: Implementation of the E-CoSim algorithm for updating whole ΔS. (Exact results)
  - `H_E_CoSim.m`: Implementation of the E-CoSim algorithm for updating only ΔS[:,u] to compute accuracy.

- Basic (file):
  - `CoSim.m`: Use CoSimRank to compute the old S.
  - `normA.m`: Build the column-normalized adjacency matrix (W/delW..).
  - `delW.m`: Thm1: Update the column-normalized adjacency matrix (delW).
  - `RandomG.m`: Randomly select the edges from the old graph to build ΔG for future computation.
- Run (file):
  - `Eva_Acc.m`: Evaluate the accuracy for I-CoSim.
  - `Eva_Diff_Algo.m`: Evaluate the efficiency between I-CoSim, D-CoSim, and E-CoSim.
  - `Eva_Diff_delG.m`: Evaluate the impact of the size of ΔG on the efficiency of I-CoSim's computational complexity.
  - `Eva_Diff_l.m`: Evaluate the I-CoSim's computational complexity for different (l, k) values (size of subspace, number of iterations).


## Datasets: all from SNAP
- EEA : EU email communication network
  - sparse matrix
  - https://snap.stanford.edu/data/email-EuAll.html
- WND : Note Dame web graph
  - sparse matrix
  - https://snap.stanford.edu/data/web-NotreDame.html
- AMZ : Amazon product co-purchasing network, May 05 2003
  - sparse matrix 
  - https://snap.stanford.edu/data/amazon0505.html
- RCA : California road network
  - sparse matrix
  - https://snap.stanford.edu/data/roadNet-CA.html

