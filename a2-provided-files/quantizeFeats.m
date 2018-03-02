function [labelIm] = quantizeFeats(featIm, meanFeats) 
    %create a zero matrx of size h x w, let that be the return matrix for
    %now.
    featIm=double(featIm);
    meanFeats=double(meanFeats);
    [h,w,d]=size(featIm);
    [k,d]=size(meanFeats);
    labelIm=zeros(h,w);
    
    % label the clusters each dot in featIm belongs to
    for i = 1:h
        for j =1:w
            % obtain the point
            point=featIm(i,j,:);
            point=reshape(point,[1,d]); % change this three dimension matrix to one dimension
            
            % find the distance with all cluster centers. Find the shortest
            % distance.
            
            chosen_cluster=1; % default to the first custer center
            min_distance=intmax;
            
            for cluster_point=1:k
                features=meanFeats(cluster_point,:);
                
                %compute the distance
                distance=dist2(features,point);  
                if(distance<min_distance)
                    min_distance=distance;
                    chosen_cluster=cluster_point;
                end
                
            end
            
            % found the belonging cluster
            
            labelIm(i,j)=chosen_cluster;

        end
    end
    
    
end