clear all
close all

K=imread('../Stars2.jpg');
K = rgb2gray(K);
uu0=double(K);
[M,N]=size(uu0);

u0 = uu0(:,1:M)/255;
u0 = imresize(u0,0.25);

figure(1)
imagesc(u0); axis image; axis off; colormap(gray);

imwrite(u0,'../SmallStars2.jpg');