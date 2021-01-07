function ImageCreator(coordinates, name)
% IMAGECREATOR mostra e salva un'immagine rappresentante un grafo
%
%   IMAGECREATOR(coordinates, name) prende in input coordinates, una
%   matrice nx3 in cui le prime due colonne rappresentano ascisse e
%   ordinate dei nodi del grafo e la terza colonna rappreseta la community
%   a cui quel nodo appartiene, nodi della stessa community sono
%   rappresentati con lo stesso colore. name è il nome con cui verrà
%   salvata l'immagine
%
%   standardX: la dimensione in pixel della larghezza dell'immagine -10
standardX = 470;

colors = zeros(125,3);
for r = 0:1:4
    for g = 0:1:4
        for b = 0:1:4
            colors(25*r+5*g+b+1,:)=[(r+1)*51,(g+1)*51,(b+1)*51];
        end
    end
end
% Rimuovo i grigi
for i =1:31:125
    colors(i,:)=[0,0,0];
end
colors = colors(~(colors==0));
colors = reshape(colors, 120,3);
colors= uint8(colors);

maxX=max(coordinates(:,1));
maxY=max(coordinates(:,2));

proportion = standardX/maxX;

relativeCoo = [round(coordinates(:,1)*proportion) ,round(coordinates(:,2)* ...
               proportion) , coordinates(:,3)];
%Se qualche coordinata fosse nulla, viene impostata a 1
relativeCoo(relativeCoo==0)=1;
rgb = zeros(round(maxX*proportion+10),round(maxY*proportion+10),3,'uint8');

for i=1:length(relativeCoo)
    rgb(relativeCoo(i,1),relativeCoo(i,2),1)=colors(mod(relativeCoo(i,3)*97,119)+1,1);
    rgb(relativeCoo(i,1),relativeCoo(i,2),2)=colors(mod(relativeCoo(i,3)*97,119)+1,2);
    rgb(relativeCoo(i,1),relativeCoo(i,2),3)=colors(mod(relativeCoo(i,3)*97,119)+1,3);
end

imshow(rgb);
imwrite(rgb, strcat(name, '.png'));

