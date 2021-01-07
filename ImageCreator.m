function ImageCreator(coordinates, name)
standardX = 470;

colors = zeros(125,3);
for r = 0:1:4
    for g = 0:1:4
        for b = 0:1:4
            colors(25*r+5*g+b+1,:)=[(r+1)*51,(g+1)*51,(b+1)*51];
        end
    end
end
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
           
relativeCoo(relativeCoo==0)=1;
rgb = zeros(round(maxX*proportion+10),round(maxY*proportion+10),3,'uint8');

for i=1:length(relativeCoo)
    rgb(relativeCoo(i,1),relativeCoo(i,2),1)=colors(mod(relativeCoo(i,3)*97,119)+1,1);
    rgb(relativeCoo(i,1),relativeCoo(i,2),2)=colors(mod(relativeCoo(i,3)*97,119)+1,2);
    rgb(relativeCoo(i,1),relativeCoo(i,2),3)=colors(mod(relativeCoo(i,3)*97,119)+1,3);
end

imshow(rgb);
imwrite(rgb, strcat(name, '.png'));

