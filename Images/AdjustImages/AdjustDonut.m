clear all
close all

K = imread('donut.jpg');
K = rgb2gray(K);
figure(2)
imagesc(K); colormap(gray);
uu0=double(K);
[M,N]=size(uu0);
uu0 = uu0/255;

u0 = uu0(:,40:M+39);

figure(1)
imagesc(u0); axis image; axis off; colormap(gray);

imwrite(u0,'GrayDonut.jpg');