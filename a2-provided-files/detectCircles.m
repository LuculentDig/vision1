function[centers] = detectCircles(im, radius)
    centers=[];
    % find the edge of the image first
    im_gray=rgb2gray(im);
    im_edge=edge(im_gray,'canny',0.3);
    % create a counter matrix same size of the image. For each detected edge 
    %pixel draw the circle and for each pixel on that circle increment count in the
    % counter matrix.
    [x,y]=size(im_edge);
    counter_matrix=zeros(x,y);
    angles=0:0.01:2*pi;
    [xa,ya]=size(angles);
    for i =1:x
        for j=1:y
            if(im_edge(i,j)>0) % there is an edge point
                xp=radius*cos(angles);
                yp=radius*sin(angles);
                new_x=int16(i+xp);
                new_y=int16(j+yp);
                for k=1:ya
                    if(new_x(k)>0 && new_x(k)<=x && new_y(k)>0 && new_y(k)<=y)
                        %disp([new_x(k) new_y(k)]);
                        counter_matrix(new_x(k),new_y(k))=counter_matrix(new_x(k),new_y(k))+1;
                    end
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
            if(counter_matrix(i,j)>100)
                %counter_matrix2(i,j)=counter_matrix(i,j);
                centers=[centers;[i j]];
                image_copy(i,j,:)=[255 0 0];
                viscircles([j i],radius);
                
            end
        end
    end
    %imagesc(counter_matrix)
    %imshow(image_copy);
    title('step size 0.1, threshold 21, radius 39')
end
    