function ImageCreator(coordinates)
standardX = 710;

colors = zeros(30,1,3);
colors(:,:,1) = [128*ones(15,1);255*ones(15,1)];
colors(1:15,:,2) = [85*ones(5,1);170*ones(5,1);255*ones(5,1)];
colors(16:30,:,2) = [85*ones(5,1);170*ones(5,1);255*ones(5,1)];
B =51:51:255;
B=B(:);
for i =0:5
    colors(i*5+1:i*5+5, :, 3) = B;
end
colors= uint8(colors);
maxX=max(coordinates(:,1));
maxY=max(coordinates(:,2));

proportion = standardX/maxX;

relativeCoo = [round(coordinates(:,1)*proportion) ,round(coordinates(:,2)* ...
               proportion) , coordinates(:,3)];
           
rgb = zeros(round(maxX*proportion+10),round(maxY*proportion+10),3,'uint8');

%rgb(relativeCoo(:,1,:),relativeCoo(:,2,:),:) = colors(mod(relativeCoo(:,3,:),30),1,:);
for i=1:length(relativeCoo)
    rgb(relativeCoo(i,1),relativeCoo(i,2),1)=colors(relativeCoo(i,3),1,1);
    rgb(relativeCoo(i,1),relativeCoo(i,2),2)=colors(relativeCoo(i,3),1,2);
    rgb(relativeCoo(i,1),relativeCoo(i,2),3)=colors(relativeCoo(i,3),1,3);
end

imwrite(rgb, 'out.png');

