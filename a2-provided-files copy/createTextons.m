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
    sample_pixels=all_image_features(1,1:300:end,:);
    
    [sample_x,sample_y,sample_z]=size(sample_pixels);
    % pick k random initial points as cluter centers. (indexes)
    centroids_centers=randi([sample_x sample_y],1,k);
    clusters=containers.Map();
    centroids=[]; % initial centroid values
    for i = 1:k
        centroid=sample_pixels(sample_x,centroids_centers(i),:);
       % disp(size(centroid))
        centroids=[centroids centroid];
        clusters(num2str(i))=[];
    end
    % began the dynamic programming. Assign each point to a cluster base on
    % the dist. Then use the average of each feature of the cluster as the
    % new cluster center. terminate if new cluster is the same as old
    % clusters.
    while(1)
        for i=1:sample_y
            point=sample_pixels(1,i,:);
            point=reshape(point,[1 d 1]);
            % check distance to each centroid

            min_distance=intmax;
            min_dis_cluster=1; %arbitrary
            for c=1:k
               %disp(centroid_center);
               centroid=centroids(1,c,:);
               centroid=reshape(centroid,[1 d 1]);
               distance=dist2(centroid,point);
               if(distance<min_distance)
                   min_dis_cluster=c;
                   min_distance=distance;
               end

            end

            % find the closest cluster. And use index 1-k as the key.
            point=reshape(point,[1 1 d]);
            clusters(num2str(min_dis_cluster))=[clusters(num2str(min_dis_cluster)) point];
        end

        % recompute the centroid centers. And run again.
        new_centroids=[];
        for i=1:k
            cluster=clusters(num2str(i));
            [x,y,z]=size(cluster);
            mean=sum(cluster)/y;
            new_centroids=[new_centroids mean];
        end

        % check if new cluster is the same as old clusters. compare each
        % pair of cluster centroid values( old and new) centroids and
        % new_centroid_centers
        if(isequal(centroids,new_centroids)==0)

            centroids=new_centroids;
            clusters=containers.Map();
            % compute the new centroid centers.
            for i = 1:k
                clusters(num2str(i))=[];
            end
        else
            break
        end
        
       
    end
    
    % change clusters to k x d matrix
    textons=centroids;
    textons=reshape(textons,[k d]);
    
    
end