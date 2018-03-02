im=imread('a.jpeg');

% original picture
subplot(3,2,1);
imshow(im);
title('original image');

%Qa
subplot(3,2,2);
result=Q2a(im);
imshow(result);
title('negative image');

%Qb
subplot(3,2,3);
result=Q2b(im);
imshow(result);
title('mirror image');

%Qc
subplot(3,2,4);
result=Q2c(im);
imshow(result);
title('swap red & green');

%Qd
subplot(3,2,5);
result=Q2d(im);
imshow(result);
title('average');

%Qe: gets a different result everytime
subplot(3,2,6);
result=Q2e(im);
imshow(result);
title('subtract random value');


