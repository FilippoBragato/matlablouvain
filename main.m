clc;
clear;
close all;

name = 'random';
pathfile = strcat(name, '.txt');
solution = false;
random = true;
trials = 1;
maxDistance = 0;
if(~random)
    trials = 1;
end
maxMod = -0.5;
for i = 1:trials
    disp('Sto eseguendo il trial ');
    disp(i);
    [adj, coordinates]= AdjMaker(pathfile, solution, random);
    if maxDistance > 0
        adj(adj < 1/maxDistance^2) = 0;
    end
    numberOfArch=length(find(adj));
    community = Louvain(adj);
    q = ModulatityCalcolator(adj, community);
    disp(strcat('Ho trovato modularità= ', string(q)));
    if(q>maxMod)
        maxMod = q;
        betterComm = community;
        betterCoo = coordinates;
    end
end
name = strcat(name,'_', string(size(coordinates,1)), '_', string(numberOfArch))
coordinates=[betterCoo, betterComm(:)];
ImageCreator(coordinates, name);
save(name, 'coordinates');