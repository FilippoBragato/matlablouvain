function [adj, coordinates]= AdjMaker(pathfile, solution, random)
fileID = fopen(pathfile);
coordinates = fscanf(fileID, '%f');
if (solution == true)
    coordinates = reshape(coordinates, 3,length(coordinates)/3);
    coordinates = coordinates';
    coordinates = [coordinates(:,1),coordinates(:,2)];
else
    coordinates = reshape(coordinates, 2,length(coordinates)/2);
    coordinates = coordinates';
end
if (random == true)
    rng = randperm(size(coordinates,1));
    coordinates = coordinates(rng, :);
end
x = coordinates(:,1);
y = coordinates(:,2);
adj = (x-x').^2+(y-y').^2;
adj = 1./adj;
adj(adj == inf) = 0;