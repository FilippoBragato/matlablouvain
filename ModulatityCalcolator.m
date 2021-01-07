function q = ModulatityCalcolator(adj, community)
s = zeros(max(community), length(community));
for i = 1: length(community)
    s(community(i), i)=1;
end
doubleM = sum(adj, 'all');
k_v = sum(adj);
b = adj - (k_v'*k_v)/doubleM;
q = trace(s*b*s')/doubleM;
