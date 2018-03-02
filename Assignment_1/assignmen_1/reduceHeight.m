function [output] = reduceHeight(im, numPixels)
    % same code used except flipping the image and then flip back.
    im=rot90(im);
    im=rot90(im);
    im=rot90(im);
    im=reduceWidth(im,numPixels);
    output=rot90(im);
end