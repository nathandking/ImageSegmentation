clear all
close all

K=imread('../CameraMan256.jpg');

uu0=double(K);
[M,N]=size(uu0);
u0=uu0;

figure(1)
imagesc(u0); axis image; axis off; colormap(gray);
h = impoly;
umat = createMask(h);

imwrite(umat,'../CameraInitial256.jpg')