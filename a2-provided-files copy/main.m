
[x,y,z]=size(t);
labelIm2=zeros(x,y,z);
for i=1:x
    for j=1:y
        if(t(i,j)==1)
            labelIm2(i,j,:)=uint8(1);
        elseif(t(i,j)==2)
            labelIm2(i,j,:)=uint8(200);
        elseif(t(i,j)==3)
            labelIm2(i,j,:)=uint8(50);
        elseif(t(i,j)==4)
            labelIm2(i,j,:)=uint8(250);
        else
            labelIm2(i,j,:)=uint8(150);
        end
    end
end
imshow(uint8(labelIm2))