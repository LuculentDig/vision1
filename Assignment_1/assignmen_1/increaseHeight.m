function [output] = increaseHeight(im, numPixels)
    im=rot90(im);
    im=rot90(im);
    im=rot90(im);
    im=increaseWidth(im,numPixels);
    output=rot90(im);
end