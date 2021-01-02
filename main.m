clc;
clear;
close all;

pathfile = 'in.txt';
solution = false;
[adj, coordinates]= AdjMaker(pathfile, solution);
community= Louvain(adj);
coordinates(:,3)=community(:);
ImageCreator(coordinates);