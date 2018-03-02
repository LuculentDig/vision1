load filterBank.mat;
load imStack.mat; % i created this. 
textons=createTextons2(imStack,F,5);
% imput the images.
gumballs=imread('gumballs.jpg');
gumballs_gray=rgb2gray(gumballs);

snake=imread('snake.jpg');
snake_gray=rgb2gray(snake);

twins=imread('twins.jpg');
twins_gray=rgb2gray(twins);

coins=imread('coins.jpg');
coins_gray=rgb2gray(coins);

% display the images using appropriate cluster numbers and winsizes.
% gumballs
[gc,gt]=compareSegmentations2(gumballs,F,textons,8,5,2);
subplot(4,2,1);
imshow(label2rgb(gc))
title('gumballs kmeans of 5 by color');
hold on
subplot(4,2,2);
imshow(label2rgb(gt))
title('gumballs kmeans of 2, winsize of 8');

% snake
[sc,st]=compareSegmentations2(snake,F,textons,25,2,3);
subplot(4,2,3)
imshow(label2rgb(sc))
title('snake kmeans of 2 by color');
hold on
subplot(4,2,4);
imshow(label2rgb(st))
title('snake kmeans of 3 by texture, winsize of 25');

% twins
[tc,tt]=compareSegmentations2(twins,F,textons,15,5,3);
subplot(4,2,5);
imshow(label2rgb(tc))
title('twins kmeans of 5 by color');
hold on
subplot(4,2,6);
imshow(label2rgb(tt))
title('twins kmeans of 3 by texture, winsize of 15');

% coins
[cc,ct]=compareSegmentations2(coins,F,textons,20,5,3);
subplot(4,2,7);
imshow(label2rgb(cc))
title('coins kmeans of 5 by color');
hold on
subplot(4,2,8);
imshow(label2rgb(ct))
title('coins kmeans of 3 by texture, winsize of 20');


% consider different window sizes. Try different window sizes on coins.jpg
[cc,ct]=compareSegmentations2(coins,F,textons,20,5,3);
subplot(1,2,1);
imshow(label2rgb(ct))
title('windows size of 20. 3 clusters');
hold on
[cc,ct]=compareSegmentations2(coins,F,textons,5,5,3);
subplot(1,2,2);
imshow(label2rgb(ct))
title('windows size of 5. 3 clusters');


% consider different filter banks.
F2=F(:,:,1:5:end); % This new filter bank use every 5 filter from F
textons=createTextons2(imStack,F2,5);
[sc,st]=compareSegmentations2(snake,F,textons,25,2,3);
subplot(1,2,1);
imshow(label2rgb(st))
title('All filter banks');
hold on
[sc,st]=compareSegmentations2(snake,F2,textons,25,2,3);
subplot(1,2,2);
imshow(label2rgb(st))
title('partial filter banks');








