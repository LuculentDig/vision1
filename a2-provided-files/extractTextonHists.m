function [featIm] = extractTextonHists(origIm, bank, textons, winSize)
    % first compute the featIm. Run it and test with the images.
    [x,y,z]=size(origIm);
    [m,m,d]=size(bank);
    [k,d]=size(textons);
    featIm=[];
    for j =1:d
        filter=bank(:,:,j);
        % run filter.
        filter_result=imfilter(origIm,filter);
        featIm(:,:,j)=filter_result;
    end
    
    labelIm=quantizeFeats(featIm,textons);

    
    % find the frequency of each texton within the window. if window is 3.
    % Then 3 left, 3 right. 3 up and 3 down. Use labelIm as reference
    
    %try to do it for each pixel for now. See how heavy the computation is.
    featIm=[];
    [x,y]=size(labelIm);
    for i =1:x
        for j=1:y
            % left right top bottom. size of window. create a bound. if
            % out of bound use the bound. find the 4 edges of the window
            % and get the matrix within the window.
            
            %left bound
            if((j-winSize<1)==1)
                left=1;
            else
                left=j-winSize;
            end
            
            %right bound
            if((j+winSize>y)==1)
                right=y;
            else
                right=j+winSize;
            end
            
            %upper bound
            if((i-winSize<1)==1)
                upper=1;
            else
                upper=i-winSize;
            end
            
            %bottom bound
            if((i+winSize>x)==1)
                bottom=x;
            else
                bottom=i+winSize;
            end
            
            
            % create the window matrix.
            window=labelIm(upper:bottom,left:right);
            %fill in the texton historgam for each texton
            histogram=[];
            for t=1:k
                count=sum(window(:)==t);
                histogram=[histogram count];
            end
            histogram=reshape(histogram,[1 1 k]);
            featIm(i,j,:)=histogram;
        end
    end
    
    %featIm is returned. For coins.jpg this programs runs about 2 minutes.
    
end
