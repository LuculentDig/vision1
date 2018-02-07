function [output] = reduceWidth(im, numPixels)
    im_gray=rgb2gray(im);
    energy=energyfunc(im_gray);
    
    % loop throught the image
    [x,y]=size(energy);
    disp(energy(x,:))
    for i= 2:x
        for j=1:y
            % we purposely start at row 2. Modify each value so that it
            % adds the lowest value above.
            % take care of edge cases
            if(j==1)
                energy(i,j)=energy(i,j)+min([energy(i-1,j) energy(i-1,j+1)]);
            elseif(j==y)
                energy(i,j)=energy(i,j)+min([energy(i-1,j) energy(i-1,j-1)]);
            else
                energy(i,j)=energy(i,j)+min([energy(i-1,j-1) energy(i-1,j) energy(i-1,j-1)]);
            end
        end
    end
    disp(energy(x,:))
    
    
    
    output = 0;
end
