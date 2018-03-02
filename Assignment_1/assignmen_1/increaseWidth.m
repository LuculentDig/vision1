function [output] = increaseWidth(im, numPixels)
    %imshow(im);
    %hold on;
    for z =1:numPixels
        output=[];
        im_gray=rgb2gray(im);
        energy=energyfunc(im_gray);
        %imshow(energy);
        %imagesc(energy)
        hold on;
        % loop throught the image
        [x,y]=size(energy);
        energy=im2double(energy);
        for i= 2:x
            for j=1:y
                % we purposely start at row 2. Modify each value so that it
                % adds the lowest value above.
                % take care of edge cases
                if(j==1)
                    energy(i,j)=energy(i,j)+min([energy(i-1,j) energy(i-1,j+1)]);
                elseif(j==y)
                    energy(i,j)=energy(i,j)+min([energy(i-1,j) energy(i-1,j-1)]);
                else
                    energy(i,j)=energy(i,j)+min([energy(i-1,j-1) energy(i-1,j) energy(i-1,j-1)]);
                end
            end
        end

        % find the smallest number at the bottom 
        min_value=min(energy(x,:));
        min_value_y=find(energy(x,:)==min_value);
        % trace back up for the seam
        next_x=x;
        next_y=min_value_y(1);
        seam=[next_x next_y];
        for i=x:-1:2
            if(next_y==1)
                [value,I]=min([energy(i-1,next_y) energy(i-1,next_y+1)]);
                seam=[[i-1 next_y+I-1];seam];
                next_y=next_y+I-1;
            elseif(next_y==y)
                [value,I]=min([energy(i-1,next_y-1) energy(i-1,next_y)]);
                seam=[[i-1 next_y+I-2];seam];
                next_y=next_y+I-2;
            else
                [value,I]=min([energy(i-1,next_y-1) energy(i-1,next_y) energy(i-1,next_y+1)]);
                seam=[[i-1 next_y+I-2];seam];
                next_y=next_y+I-2;
            end

        end
        %disp(seam)
        %imshow(im);
        hold on;
        a=seam(:,1);
        b=seam(:,2);
        a=a';
        b=b';
        %plot(b',a', 'r.');
        % create the return image without the seam
        for i =1:x
            row=im(i,:,:);
            row=[row(:,1:seam(i,2),:) im(i,seam(i,2),:) row(:,seam(i,2)+1:end,:)];
            %row(:,seam(i,2),:)=[];
            output=[output;row]; 
        end
        im=output;
    end
end
