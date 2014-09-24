clear all
close all

K=imread('BoyWithGun.jpg');
K = rgb2gray(K);
uu0=double(K);
[M,N]=size(uu0);

u0 = uu0(:,100:100+M-1)/255;

figure(1)
imagesc(u0); axis image; axis off; colormap(gray);

imwrite(u0,'Gun.jpg');