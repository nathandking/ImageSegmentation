%% Chan-Vese active contours without edges model 
% Camera man image
clear all
close all
tic

%% Read and plot initial image
u0=imread('../Images/CameraMan256.jpg');
[M,N]=size(u0);
u0 = double(u0);

figure(1);
imagesc(u0); axis image; axis off; colormap(gray);
title('Initial Image','Interpreter','latex','FontSize',20)

%% Initial Guess of a Circle
x=1:M;
y=1:N;
[Qx,Qy]=ndgrid(x,y);
x0=125;
y0=125;
r0=10;
Phi00 = -sqrt((Qx-x0).^2+(Qy-y0).^2)+r0;
Phi0 = Phi00(1:M,1:N); 

%% Parameters

lambda=0.00025;   % tunable parameter
h=1.;   %  space step size
IterMax=4;   %  number of iterations
eps=0.000001;   %  needed to regularize TV at the origin 

% regularization of delta and heavyside function
epsilon=1.;
delta = @(phi) (epsilon/pi)*(1/(phi^2+epsilon^2));
H = @(phi) 0.5*(1+2*atan(phi/epsilon)/pi);

%% Begin Gauss-Seidel Iteration
Phi=Phi0;
Iter=1;

for Iter = 1:IterMax
    
    Iter
    
    % compute mean inside and outside contour
    vPhi=Phi(:);
    vu=u0(:);
    C1=mean(vu(vPhi>=0));
    C2=mean(vu(vPhi<0));
    
    %-----------computation of coefficients co1,co2,co3,co4---------
    for i=2:M-1,
        for j=2:N-1,

            Phix=(Phi(i+1,j)-Phi(i,j))/h;
            Phiy=(Phi(i,j+1)-Phi(i,j))/h;
            GradPhi=sqrt(eps*eps+Phix*Phix+Phiy*Phiy);
            co1=1./GradPhi;

            Phix=(Phi(i,j)-Phi(i-1,j))/h;
            Phiy=(Phi(i-1,j+1)-Phi(i-1,j))/h;
            GradPhi=sqrt(eps*eps+Phix*Phix+Phiy*Phiy);
            co2=1./GradPhi;

            Phix=(Phi(i+1,j)-Phi(i,j))/h;
            Phiy=(Phi(i,j+1)-Phi(i,j))/h;
            GradPhi=sqrt(eps*eps+Phix*Phix+Phiy*Phiy);
            co3=1./GradPhi;

            Phix=(Phi(i+1,j-1)-Phi(i,j-1))/h;
            Phiy=(Phi(i,j)-Phi(i,j-1))/h;
            GradPhi=sqrt(eps*eps+Phix*Phix+Phiy*Phiy);
            co4=1./GradPhi;

            co=1.+(1/(h*h))*(co1+co2+co3+co4);

            div=delta(Phi(i,j))*(co1*Phi(i+1,j)+co2*Phi(i-1,j)+...
                co3*Phi(i,j+1)+co4*Phi(i,j-1));

            Phi(i,j)=(delta(Phi(i,j))./co)*((1/h^2)*div-...
                lambda*((u0(i,j)-C1)^2-(u0(i,j)-C2)^2));
        end
    end

    % ------------ FREE BOUNDARY CONDITIONS IN PHI -------------------
	for i=2:M-1
        Phi(i,1)=Phi(i,2);
        Phi(i,N)=Phi(i,N-1);
    end

	for j=2:N-1
        Phi(1,j)=Phi(2,j);
        Phi(M,j)=Phi(M-1,j);
    end

    Phi(1,1)=Phi(2,2);
    Phi(1,N)=Phi(2,N-1); 
    Phi(M,1)=Phi(M-1,2);
    Phi(M,N)=Phi(M-1,N-1);
    % ----------------------------------------------------------------

    % plot binary image of segmentation.
    J(Phi<=0) = 0;
    J(Phi>0) = 1;
    J = reshape(J,M,N);
    figure(2); imagesc(J); colormap(gray); axis off; axis equal;
    title('Chan-Vese Segmentation','Interpreter','latex','FontSize',20)
end 
toc