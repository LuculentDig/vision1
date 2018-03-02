function [colorLabelIm, textureLabelIm] = compareSegmentations(origIm, bank, textons, winSize,numColorRegions, numTextureRegions)
    textureLabelIm=0;
    % this method runs about 2 minutes and 10 seconds for coins.jpg. Be patient.
    % k-mean by color
    %pick a sample first, then pick initial cluster centers from the
    %sample.
    [x,y,z]=size(origIm);
    all_pixels=reshape(origIm,[1 x*y z]);
    all_pixels=double(all_pixels);
    sample_pixels=all_pixels(1,1:200:end,:); % use every 10 pixel as our sample.
    
    % pick initial random centroids. (will use similar code from createTextons)
    % EDIt: need to make sure these random centers all have unique features
    [sample_x,sample_y,sample_z]=size(sample_pixels);
    centroids_centers=[];
    flag=0;
    while(length(centroids_centers)<numColorRegions)
        center=randi([sample_x sample_y]);
        if(length(centroids_centers)==0)
            centroids_centers=[centroids_centers center];
        else
            len=length(centroids_centers);
            for i=1:len
                if (isequal(sample_pixels(1,center,:),sample_pixels(1,centroids_centers(i),:))==1)
                    flag=1;
                end
                
            end
            
            if(flag==0)
                centroids_centers=[centroids_centers center];
            end
            flag=0;
        end
    end
    disp(centroids_centers)
    clusters=containers.Map();
    centroids=[]; % initial centroid values
    for i = 1:numColorRegions
        centroid=sample_pixels(sample_x,centroids_centers(i),:);
       % disp(size(centroid))
        centroids=[centroids centroid];
        clusters(num2str(i))=[];
    end
    % began the dynamic programming. Assign each point to a cluster base on
    % the dist . Then use the average the three colors of the cluster as the
    % new cluster center. terminate if new cluster is the same as old
    % clusters.
    while(1)
        for i=1:sample_y
            point=sample_pixels(1,i,:);
            point=reshape(point,[1 3 1]);
            % check distance to each centroid

            min_distance=realmax;
            min_dis_cluster=1; %arbitrary
            for c=1:numColorRegions
               %disp(centroid_center);
               centroid=centroids(1,c,:);
               centroid=reshape(centroid,[1 3 1]);

               centroid=double(centroid);
               point=double(point);

               
               distance=dist2(centroid,point);
               if(distance<min_distance)
                   min_dis_cluster=c;
                   min_distance=distance;
               end

            end

            % find the closest cluster. And use index 1-k as the key.
            point=reshape(point,[1 1 3]);
            clusters(num2str(min_dis_cluster))=[clusters(num2str(min_dis_cluster)) point];
        end

        % recompute the centroid centers. And run again.
        new_centroids=[];
        for i=1:numColorRegions
            cluster=clusters(num2str(i));
            [x,y,z]=size(cluster);
            cluster=double(cluster);
            mean=double(sum(cluster)/y);
            new_centroids=[new_centroids mean];
        end

        % check if new cluster is the same as old clusters. compare each
        % pair of cluster centroid values( old and new) centroids and
        % new_centroid_centers
        if(isequal(centroids,new_centroids)==0)

            centroids=new_centroids;
            clusters=containers.Map();
            % compute the new centroid centers.
            for i = 1:numColorRegions
                clusters(num2str(i))=[];
            end
        else
            break
        end
       
    end
    k_mean_color_centers=reshape(centroids,[numColorRegions 3]); % kx3 size
    colorLabelIm=quantizeFeats(origIm,k_mean_color_centers);
    disp('finished k-mean color')
    
    
    %k-means by texture ***************************************************
    origIm_gray=rgb2gray(origIm);
    texton_histogram=extractTextonHists(origIm_gray,bank,textons,winSize);
    texton_histogram=double(texton_histogram);
    [h,w,k]=size(texton_histogram);
    % run similar algorithm. 
    [x,y,z]=size(texton_histogram);
    all_pixels=reshape(texton_histogram,[1 x*y z]);
    sample_pixels=all_pixels(1,1:200:end,:); % use every 300 pixel as our sample.
    % pick initial random centroids. (will use similar code from createTextons)
    [sample_x,sample_y,sample_z]=size(sample_pixels);
    %centroids_centers=randi([sample_x sample_y],1,numTextureRegions);
    centroids_centers=[];
    flag=0;
    while(length(centroids_centers)<numTextureRegions)
        center=randi([sample_x sample_y]);
        if(length(centroids_centers)==0)
            centroids_centers=[centroids_centers center];
        else
            len=length(centroids_centers);
            for i=1:len
                %disp(isequal(sample_pixels(1,center,:),sample_pixels(1,centroids_centers(i),:)));
                if (isequal(sample_pixels(1,center,:),sample_pixels(1,centroids_centers(i),:))==1)
                    flag=1;
                end
                
            end
            
            if(flag==0)
                centroids_centers=[centroids_centers center];
            end
            flag=0;
        end
    end  
    centroids_centers
    clusters=containers.Map();
    centroids=[]; % initial centroid values
    for i = 1:numTextureRegions
        centroid=sample_pixels(sample_x,centroids_centers(i),:);
        centroids=[centroids centroid];
        clusters(num2str(i))=[];
    end
    % began the dynamic programming. Assign each point to a cluster base on
    % the dist . Then use the average the histogram of the cluster as the
    % new cluster center. terminate if new cluster is the same as old
    % clusters.
    while(1)
        for i=1:sample_y
            point=sample_pixels(1,i,:);
            point=reshape(point,[1 k 1]);
            % check distance to each centroid

            min_distance=realmax;
            min_dis_cluster=1; %arbitrary
            for c=1:numTextureRegions
               %disp(centroid_center);
               centroid=centroids(1,c,:);
               centroid=reshape(centroid,[1 k 1]);

               centroid=double(centroid);
               point=double(point);

               
               distance=dist2(centroid,point);
               if(distance<min_distance)
                   min_dis_cluster=c;
                   min_distance=distance;
               end

            end

            % find the closest cluster. And use index 1-k as the key.
            point=reshape(point,[1 1 k]);
            clusters(num2str(min_dis_cluster))=[clusters(num2str(min_dis_cluster)) point];
        end
        % recompute the centroid centers. And run again.

        new_centroids=[];
        for i=1:numTextureRegions
            cluster=clusters(num2str(i));
            [x,y,z]=size(cluster);
            mean=double(sum(cluster)/y);
            new_centroids=[new_centroids uint8(mean)];
        end
        % check if new cluster is the same as old clusters. compare each
        % pair of cluster centroid values( old and new) centroids and
        % new_centroid_centers
        if(isequal(centroids,new_centroids)==0)

            centroids=new_centroids;
            clusters=containers.Map();
            % compute the new centroid centers.
            for i = 1:numTextureRegions
                clusters(num2str(i))=[];
            end
        else
            break
        end
       
    end
    k_means_texture_centers=reshape(centroids,[numTextureRegions k]);
    textureLabelIm=quantizeFeats(texton_histogram,k_means_texture_centers);
    
end