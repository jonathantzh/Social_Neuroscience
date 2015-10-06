function ibd = brainDensity(adj, threshold)

% Density is the fraction of present connections to possible connections.
% Connection weights are ignored in calculations.
% In other words, the actual number of edges in the network divided by the 
% number of possible edges. A network with density 0 contains no edges, 
% whereas a density of 1 indicates that all possible edges exist.

adj(adj<threshold) = 0;
N = size(adj,1);
K = nnz(adj);
ibd = K/(N^2-N);
end