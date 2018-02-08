function [output] = reduceHeight(im, numPixels)
    im=rot270(im);
    reduceWidth(im,numPixels);
end