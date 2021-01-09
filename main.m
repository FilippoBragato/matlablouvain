% MAIN esegue l'algoritmo di Louvain
%   Alla fine dell'esecuzione viene mostrata una rappresentazione
%   bidimensionale dell'output, che poi viene salvata in un file .png
%
%   name: il nome del file di tipo .txt da cui vengono prese le coordinate
%   in input
%
%   random: se true riordina in modo casuale i punti in ingresso
%
%   trials: imposta quante volte viene iterato l'algoritmo, alla fine viene
%   mostrato solo il risultato a modularità più alta
%
%   maxDistance: imposta qual è la distanza massima con viene creato un arco
%   tra ogni coppia di nodi, se è 0 tutte le coppie di nodi sono connesse
clc;
clear;
close all;
%% PARAMETRI
name = 'Aggregation';
solution = true;
random = false;
trials = 100;
maxDistance = 0;
% Se non si usa la funzione random non ha senso fare più di una iterazione
if(~random)
    trials = 1;
end
%%
pathfile = strcat('input/',name, '.txt');
maxMod = -0.5;
for i = 1:trials
    disp('Sto eseguendo il tentativo ');
    disp(i);
    [adj, coordinates]= AdjMaker(pathfile, solution, random);
    % Gli archi che pesano meno del minimo (legato alla distanza) vengono rimossi 
    if maxDistance > 0
        adj(adj < 1/maxDistance^2) = 0;
    end
    numberOfArch=length(find(adj))/2;
    community = Louvain(adj);
    q = ModularityCalcolator(adj, community);
    disp(strcat('Ho trovato modularità= ', string(q)));
    if(q>maxMod)
        maxMod = q;
        betterComm = community;
        betterCoo = coordinates;
    end
end
% L'output viene salvato come immagine in un file chiamato:
% nomeDelGrafo_numeroDiNodi_numeroDi archi.png, analogamente viene salvato
% come matrice delle coordinate dei punti e relativa community in un file  
% di tipo .mat con lo stesso nome
name = strcat(name,'_', string(size(coordinates,1)), '_', string(numberOfArch));
display(maxMod);
coordinates=[betterCoo, betterComm(:)];
ImageCreator(coordinates, name);
save(strcat('output/',name), 'coordinates');