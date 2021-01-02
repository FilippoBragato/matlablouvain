function [adj, coordinates]= AdjMaker(pathfile, solution)
fileID = fopen(pathfile);
coordinates = fscanf(fileID, '%f');
if (solution == true)
    coordinates = reshape(coordinates, 3,length(coordinates)/3);
    coordinates = coordinates';
else
    coordinates = reshape(coordinates, 2,length(coordinates)/2);
    coordinates = coordinates';
end
x = coordinates(:,1);
y = coordinates(:,2);
adj = (x-x').^2+(y-y')^2;
adj = 1./adj;