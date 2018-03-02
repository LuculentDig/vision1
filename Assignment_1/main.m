% run this function
austin=imread('austin.jpg');
disney=imread('disney.jpg');
austin2=imread('austin copy.jpg');


% question 1
% reduce the width by 100 on austin
austin_output=reduceWidth(austin,100);
%disney_output=reduceHeight(disney,100);

%{
imshow(austin);
disp(size(austin));
title('original image: 322 x 600 x 3');
imshow(austin_output);
title('resized image: 322 x 500 x 3');
hold on
austin_computer_resize=imresize(austin,[322,500]);
imshow(austin_computer_resize);
title('imresize: 322 x 500 x 3');

hold off

imshow(disney);
disp(size(disney));
title('original image: 412 x 617 x 3');
hold on 
imshow(disney_output);
disp(size(disney_output))
title('resized image: 312 x 617 x 3');
hold on
subplot(3,1,3)
disney_computer_resize=imresize(disney,[312,617]);
imshow(disney_computer_resize);
title('imresize: 312 x 617 x 3');

%}
% question3
