clear all
close all

K=imread('../Licence.jpg');
KK = imread('../BCLicence.jpg');
KK = rgb2gray(KK);
KK = KK(1:216,:);
K = rgb2gray(K);
size(KK)
size(K)

figure(1)
imagesc(K); colormap(gray);
uu0=double(K);
[M,N]=size(uu0);
uu0 = uu0/255;

u0 = zeros(N);
u0(1:M,1:N) = uu0;

u0 = imresize(u0,[256,256]);

ww0=double(KK);
[Mw,Nw]=size(ww0);
ww0 = ww0/255;

w0 = zeros(Nw);
w0(Nw-Mw+1:Nw,1:Nw) = ww0;

w0 = imresize(w0,[256,256]);


figure(2)
imagesc(u0); axis image; axis off; colormap(gray);
figure(3)
imagesc(w0); axis image; axis off; colormap(gray);


Im = u0+w0;
imagesc(Im); axis image; axis off; colormap(gray);
imwrite(Im,'../Licence256.jpg');