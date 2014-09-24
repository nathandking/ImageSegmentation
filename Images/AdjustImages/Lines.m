clear all
close all

M = 256;
N = 256;

u0=zeros(M,N);

figure(1)
imagesc(u0); axis image; axis off; colormap(gray);
h1 = imline;
h2 = imline;
h3 = imline;
h4 = imline;
h5 = imline;
h6 = imline;
h7 = imline;
h8 = imline;
h9 = imline;
h10 = imline;
h11 = imline;

umat = u0 + createMask(h1) + createMask(h2) + createMask(h3) +...
    createMask(h4) + createMask(h5)+ createMask(h6) + createMask(h7) + createMask(h8) +...
    createMask(h9) + createMask(h10) + createMask(h11);


figure(2)
imagesc(umat); axis image; axis off; colormap(gray);

imwrite(umat,'../Lines.jpg')