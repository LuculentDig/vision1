function result=Q2e (im)
    im=rgb2gray(im);
    result=im;
    the_size=size(im);
    row=the_size(1);
    col=the_size(2);

    subtracting_m=zeros(row,col)+randi([0 255]);
    
    %type cast
    im=uint8(im);
    subtracting_m=uint8(subtracting_m);
    result=im-subtracting_m;

    % clip the result
    the_max=max(result(:));
    the_min=min(result(:));
    
    imshow(result)
end
