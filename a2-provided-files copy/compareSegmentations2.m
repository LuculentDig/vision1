function [colorLabelIm, textureLabelIm] = compareSegmentations2(origIm, bank, textons, winSize,numColorRegions, numTextureRegions)
    colorLabelIm=0;
    textureLabelIm=0;
    % this method runs about 2 minutes and 10 seconds for coins.jpg. Be patient.
    % k-mean by color
    %pick a sample first, then pick initial cluster centers from the
    %sample.
    [x,y,z]=size(origIm);
    all_pixels=reshape(origIm,[1 x*y z]);
    all_pixels=double(all_pixels);
    sample_pixels=all_pixels(1,1:200:end,:); % use every 200 pixel as our sample.
    
    all_pixels=reshape(all_pixels,[x*y z]);
    [colorLabelIm stuff]=kmeans(all_pixels,numColorRegions);
    colorLabelIm=reshape(colorLabelIm,[x y]);
    
    
    
    %textures
    origIm_gray=rgb2gray(origIm);
    texton_histogram=extractTextonHists(origIm_gray,bank,textons,winSize);
    texton_histogram=double(texton_histogram);
    [h,w,k]=size(texton_histogram);
    texton_histogram=reshape(texton_histogram,[h*w k]);
    [textureLabelIm stuff]=kmeans(texton_histogram,numTextureRegions);
    textureLabelIm=reshape(textureLabelIm,[h w]);
    
    
    return

end