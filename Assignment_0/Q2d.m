function result=Q2d (im)
    gray=rgb2gray(im);
    gray=im2double(gray);
    mirror=Q2b(im);
    mirror=im2double(mirror);
    result=(gray+mirror)/2;
    
end
