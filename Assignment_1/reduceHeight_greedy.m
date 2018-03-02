function [output] = reduceHeight_greedy(im, numPixels)
    im=rot90(im);
    im=rot90(im);
    im=rot90(im);
    im=reduceWidth_greedy(im,numPixels);
    output=rot90(im);
end