function [output] = reduceWidth_greedy(im, numPixels)
    %imshow(im);
    %hold on;
    for z =1:numPixels
        output=[];
        im_gray=rgb2gray(im);
        energy=energyfunc(im_gray);
        
        % start from the top, pick the smallest energy gradient, and go
        % down from there. keep picking the smallest energy gradient until
        % the end of row.
        [x y]=size(im);
        seam=[];
        min_value=min(energy(1,:));
        min_value_y=find(energy(1,:)==min_value);
        min_value_y=min_value_y(1);
        seam=[seam;[1 min_value_y]];
        for i =2:x
            if(min_value_y==1)
                if(energy(i,min_value_y)<energy(i,min_value_y+1))
                    min_value_y=min_value_y;
                else
                    min_value_y=min_value_y+1;
                end
            elseif(min_value_y==y)
                if(energy(i,min_value_y)<energy(i,min_value_y-1))
                    min_value_y=min_value_y;
                else
                    min_value_y=min_value_y-1;
                end
            else
                if(energy(i,min_value_y)<energy(i,min_value_y-1) & energy(i,min_value_y)<energy(i,min_value_y+1))
                    min_value_y=min_value_y;
                elseif(energy(i,min_value_y-1)<energy(i,min_value_y) & energy(i,min_value_y-1)<energy(i,min_value_y+1))
                    min_value_y=min_value_y-1;
                else
                    min_value_y=min_value_y+1;
                end
            end
            
            
            seam=[seam;[i min_value_y]];
            
        end
        for i =1:x
            row=im(i,:,:);
            row(:,seam(i,2),:)=[];
            output=[output;row]; 
        end
        im=output;
    end
end
