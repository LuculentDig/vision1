function [textons] = createTextons(imStack, bank, k)
    %initialize the sizes
    n=length(imStack);
    [m,m,d]=size(bank);
    textons=zeros(k,d);
    
    % for each image, run each filter. All pixels from all images should
    % have a vector of d features. Run clustering on all.
    all_image_features=[];
    for i=1:n
        image=imStack{i};
        d_features=[];
        for j =1:d
            filter=bank(:,:,j);
            % run filter.
            filter_result=imfilter(image,filter,'replicate');
            d_features(:,:,j)=filter_result;
        end
        
        % add this image d_features into the all_image_features. Reshape
        % that to a row before adding.
        [x,y,d]=size(d_features);
        all_image_features=[all_image_features reshape(d_features,[1 x*y d])];
    end
    
    % now all the d_dimenssionl features from all images are combined into
    % an array. perform k-mean clustering.
    [x,y,z]=size(all_image_features);
    
    % make a sample of the features pixles. every 300 pixels. 
    sample_pixels=all_image_features(1,1:100:end,:);
    [x,y,z]=size(sample_pixels);
    sample_pixels=reshape(sample_pixels,[y,z,1]);
    [labels,textons]=kmeans(sample_pixels,k);
end