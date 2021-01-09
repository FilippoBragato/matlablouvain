function q = ModularityCalcolator(adj, community)
% MODULARITYCALCOLATOR calcola la modularità di un grafo data una divisione
% in community
%
%   q = MODULARITYCALCOLATOR(adj, community) data la matrice delle
%   adiacenze adj, simmetrica e quadrata di dimensione n, e community, un
%   array di dimensione n in cui ogni entrata indica con un intero a quale
%   community appartiene il corrispondente nodo in adj, calcola la
%   modularità del grafo diviso in community.
%
%   La notazione utilizzata fa riferimento alla pagina Wikipedia <a
%   href="matlab: web('https://en.wikipedia.org/wiki/Modularity_(networks)')
%   ">Modularity</a>

s = zeros(max(community), length(community));
for i = 1: length(community)
    s(community(i), i)=1;
end
doubleM = sum(adj, 'all');
if (doubleM==0)
    doubleM=1;
end
k_v = sum(adj);
b = adj - (k_v'*k_v)/doubleM;
q = trace(s*b*s')/doubleM;
