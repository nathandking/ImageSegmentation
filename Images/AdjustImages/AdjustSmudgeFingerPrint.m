clear all
close all

K=imread('../FingerPrint.gif');
figure(2)
imagesc(K); colormap(gray);
uu0=double(K);
[M,N]=size(uu0);
uu0 = uu0/190;

u0 = ones(M);
u0(1:M,1:N) = uu0;

figure(1)
imagesc(u0); axis image; axis off; colormap(gray);

imwrite(u0,'../SmudgeFinger.jpg');