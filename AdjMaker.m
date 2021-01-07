function [adj, coordinates]= AdjMaker(pathfile, solution, random)
% ADJMAKER crea la matrice delle adiacenze di un grafo.
%
%   [adj, coordinates] = ADJMAKER(pathfile, solution, random) dato pathfile, 
%   il percorso di un file di tipo .txt, legge il contenuto del file
%   interpretando i valori come double, interpreta ogni coppia di numeri
%   come ascissa e ordinata di un punto e quindi come nodo del grafo, crea
%   la matrice delle adiacenze impostando il peso di un arco come il
%   reciproco del quadrato della distanza euclidea tra i due punti. Se
%   solution è true si suppone che il file di testo abbia triplette di
%   valori i cui primi due sono le coordinate e il terzo è la community a
%   cui appartiene, in tal caso il terzo valore viene scartato. Random se
%   true rimescola l'ordine con cui sono rappresentati i punti nel grafo e
%   quindi nella matrice delle adiacenze.
%
%   adj è la matrice delle adiacenze risultante, coordinates invece è una
%   matrice nx2 in cui vengono scritte le coordinate dei punti nell'ordine
%   con cui sono stati rimescolati.
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