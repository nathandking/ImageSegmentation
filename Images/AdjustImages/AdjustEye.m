clear all
close all

K=imread('BloodVessel.jpg');
figure(2)
imagesc(K); colormap(gray);
uu0=double(K);
[M,N]=size(uu0);
uu0 = uu0/255;

u0 = uu0(M/2-200:M/2+200,N/2-200:N/2+200);

figure(1)
imagesc(u0); axis image; axis off; colormap(gray);

imwrite(u0,'Eye.jpg');