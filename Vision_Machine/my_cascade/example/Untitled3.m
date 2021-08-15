close all;
I = imread('rice.jpg');
I = rgb2gray(I);

T = adaptthresh(I,0.99,'ForegroundPolarity','dark');
figure
imshow(I)

BW = imbinarize(I,T);
BW = double(BW);
figure
imshow(BW)