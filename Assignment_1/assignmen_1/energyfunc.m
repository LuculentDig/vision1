function[energy] = energyfunc(im)
    [gx,gy]=imgradient(im);
    %energy=abs(gx)+abs(gy);
    energy =abs(imfilter(im,[1,0,-1],'replicate'))+abs(imfilter(im,[1;0;-1],'replicate'));
end
    