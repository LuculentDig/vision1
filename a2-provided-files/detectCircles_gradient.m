function[centers] = detectCircles_gradient(im, radius)
    centers=[];
    % find the edge of the image first
    im_gray=rgb2gray(im);
    im_edge=edge(im_gray,'canny',0.3);

    [Gx, Gy] = imgradientxy(im_gray);
    [Gmag, Gdir] = imgradient(Gx, Gy);
    
    [x,y]=size(Gdir);
%     for i=1:x
%         for j=1:y
%             if(Gdir(i,j)==20)
%                 im(i,j,:)=[250 0 0];
%             end
%         end
%     end
    
    % create a counter matrix same size of the image. For each detected edge 
    %pixel draw the circle and for each pixel on that circle increment count in the
    % counter matrix.
    [x,y]=size(im_edge);
    counter_matrix=zeros(x,y);
    for i =1:x
        for j=1:y
            if(im_edge(i,j)>0) % there is an edge point
                
                degree=atan2(-Gx(i,j),-Gy(i,j));
                xp=radius*cos(degree);
                yp=radius*sin(degree);
                new_x=int16(i+xp);
                new_y=int16(j+yp);

                if(new_x>0 && new_x<=x && new_y>0 && new_y<=y)
                    %disp([new_x(k) new_y(k)]);
                    counter_matrix(new_x,new_y)=counter_matrix(new_x,new_y)+1;
                end
                
            end
        end
    end
    
    % label the dots
    image_copy=im;
    imshow(image_copy);
    %counter_matrix2=zeros(x,y);
    hold on;
    for i =1: x
        for j=1:y
            if(counter_matrix(i,j)>9)
                %counter_matrix2(i,j)=counter_matrix(i,j);
                centers=[centers;[i j]];
                image_copy(i,j,:)=[255 0 0];
                viscircles([j i],radius);
                
            end
        end
    end
    %imagesc(counter_matrix)
    %imshow(image_copy);
    title('Using gradient, threshold 9, radius 39')
end
    