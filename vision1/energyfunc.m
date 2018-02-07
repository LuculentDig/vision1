function[energy] = energyfunc(im)
    energy =abs(imfilter(im,[-1,0,1],'replicate'))+abs(imfilter(im,[-1;0;1],'replicate'));
end