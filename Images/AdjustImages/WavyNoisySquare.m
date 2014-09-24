clear all
close all
M = 256;
N = 256;
%  space discretization 
h = 1.;

% create initial binary image of circle.
R = 80;
cx = M/2; cy = N/2;
x = 1:M; y = 1:N;
[X,Y] = ndgrid(x,y);

u = zeros(M,N);
u(cx-R:cx+R,cy-R:cy+R) = 1;

% left side of image.
u(cx-R+1:32:cx+R,cy-R:cy-R+1)=0;
u(cx-R+2:32:cx+R,cy-R:cy-R+2)=0;
u(cx-R+3:32:cx+R,cy-R:cy-R+3)=0;
u(cx-R+4:32:cx+R,cy-R:cy-R+4)=0;
u(cx-R+5:32:cx+R,cy-R:cy-R+5)=0;
u(cx-R+6:32:cx+R,cy-R:cy-R+6)=0;
u(cx-R+7:32:cx+R,cy-R:cy-R+7)=0;
u(cx-R+8:32:cx+R,cy-R:cy-R+8)=0;
u(cx-R+9:32:cx+R,cy-R:cy-R+9)=0;
u(cx-R+10:32:cx+R,cy-R:cy-R+10)=0;
u(cx-R+11:32:cx+R,cy-R:cy-R+11)=0;
u(cx-R+12:32:cx+R,cy-R:cy-R+12)=0;
u(cx-R+13:32:cx+R,cy-R:cy-R+13)=0;
u(cx-R+14:32:cx+R,cy-R:cy-R+14)=0;
u(cx-R+15:32:cx+R,cy-R:cy-R+15)=0;
u(cx-R+16:32:cx+R,cy-R:cy-R+16)=0;
u(cx-R+17:32:cx+R,cy-R:cy-R+15)=0;
u(cx-R+18:32:cx+R,cy-R:cy-R+14)=0;
u(cx-R+19:32:cx+R,cy-R:cy-R+13)=0;
u(cx-R+20:32:cx+R,cy-R:cy-R+12)=0;
u(cx-R+21:32:cx+R,cy-R:cy-R+11)=0;
u(cx-R+22:32:cx+R,cy-R:cy-R+10)=0;
u(cx-R+23:32:cx+R,cy-R:cy-R+9)=0;
u(cx-R+24:32:cx+R,cy-R:cy-R+8)=0;
u(cx-R+25:32:cx+R,cy-R:cy-R+7)=0;
u(cx-R+26:32:cx+R,cy-R:cy-R+6)=0;
u(cx-R+27:32:cx+R,cy-R:cy-R+5)=0;
u(cx-R+28:32:cx+R,cy-R:cy-R+4)=0;
u(cx-R+29:32:cx+R,cy-R:cy-R+3)=0;
u(cx-R+30:32:cx+R,cy-R:cy-R+2)=0;
u(cx-R+31:32:cx+R,cy-R:cy-R+1)=0;

% top of image.
u(cx-R-1:cx-R,cy-R+1:32:cy+R)=1;
u(cx-R-2:cx-R,cy-R+2:32:cy+R)=1;
u(cx-R-3:cx-R,cy-R+3:32:cy+R)=1;
u(cx-R-4:cx-R,cy-R+4:32:cy+R)=1;
u(cx-R-5:cx-R,cy-R+5:32:cy+R)=1;
u(cx-R-6:cx-R,cy-R+6:32:cy+R)=1;
u(cx-R-7:cx-R,cy-R+7:32:cy+R)=1;
u(cx-R-8:cx-R,cy-R+8:32:cy+R)=1;
u(cx-R-9:cx-R,cy-R+9:32:cy+R)=1;
u(cx-R-10:cx-R,cy-R+10:32:cy+R)=1;
u(cx-R-11:cx-R,cy-R+11:32:cy+R)=1;
u(cx-R-12:cx-R,cy-R+12:32:cy+R)=1;
u(cx-R-13:cx-R,cy-R+13:32:cy+R)=1;
u(cx-R-14:cx-R,cy-R+14:32:cy+R)=1;
u(cx-R-15:cx-R,cy-R+15:32:cy+R)=1;
u(cx-R-16:cx-R,cy-R+16:32:cy+R)=1;
u(cx-R-15:cx-R,cy-R+17:32:cy+R)=1;
u(cx-R-14:cx-R,cy-R+18:32:cy+R)=1;
u(cx-R-13:cx-R,cy-R+19:32:cy+R)=1;
u(cx-R-12:cx-R,cy-R+20:32:cy+R)=1;
u(cx-R-11:cx-R,cy-R+21:32:cy+R)=1;
u(cx-R-10:cx-R,cy-R+22:32:cy+R)=1;
u(cx-R-9:cx-R,cy-R+23:32:cy+R)=1;
u(cx-R-8:cx-R,cy-R+24:32:cy+R)=1;
u(cx-R-7:cx-R,cy-R+25:32:cy+R)=1;
u(cx-R-6:cx-R,cy-R+26:32:cy+R)=1;
u(cx-R-5:cx-R,cy-R+27:32:cy+R)=1;
u(cx-R-4:cx-R,cy-R+28:32:cy+R)=1;
u(cx-R-3:cx-R,cy-R+29:32:cy+R)=1;
u(cx-R-2:cx-R,cy-R+30:32:cy+R)=1;
u(cx-R-1:cx-R,cy-R+31:32:cy+R)=1;

% add noise to the image.
u = imnoise(u,'gaussian');

imwrite(u,'WavyNoisySquare.jpeg');