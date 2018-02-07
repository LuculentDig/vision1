function result = Q2e (im)
    the_size=size(im);
    row = the_size(1);
    col = the_size(2);

    subtracting_m = zeros(row,col) + randi(255,row, col);
    
    newImg = double(im) - subtracting_m;

    the_max = max(newImg(:));
    the_min = min(newImg(:));

    newImg = uint8((double(newImg)-double(the_min))/(the_max - the_min) * 255);
    result = newImg;
    
end
