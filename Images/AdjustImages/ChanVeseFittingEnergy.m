%% Matlab code to implement Chan-Vese active contours without edges model 
clear all
close all

%%%----------------------------------------------------------------- 
%              INITIALIZATION OF CONTOUR  
%-----------------------------------------------------------------

% make image to explain Chan-Vese fitting energy.
M = 256;
N = 256;

% initialize contour as a single circle
x=1:M;
y=1:N;
[Qx,Qy]=ndgrid(x,y);
x0=128;
y0=128;
r0=120;
Phi00 = -sqrt((Qx-x0).^2+(Qy-y0).^2)+r0;
Phi0 = Phi00(1:M,1:N); 

u0 = ones(M,N);
figure(1)
imagesc(u0); axis off; colormap(gray); axis equal;
h1 = impoly;
h2 = imellipse;
u0 = u0 + (1-createMask(h1)) + (1-createMask(h2));
u0(u0==2) = 1;
u0(u0==3) = 40;

figure(2)
image(uint8(u0)); axis off; colormap(gray); axis equal;
hold on
contour(Phi0,[0,0],'r'); 
title('$F_1(C)> 0$, $F_2(C) \approx 0$, Fitting $> 0$','Interpreter','latex','FontSize',16)

figure(3)
image(uint8(u0)); axis off; colormap(gray); axis equal;
hold on
contour(Phi0,[100,100],'r'); 
title('$F_1(C)\approx 0$, $F_2(C)> 0$, Fitting $> 0$','Interpreter','latex','FontSize',16)

figure(4)
image(uint8(u0)); axis off; colormap(gray); axis equal;
hold on
contour(Phi0,[50,50],'r');
title('$F_1(C)>0$, $F_2(C)> 0$, Fitting $> 0$','Interpreter','latex','FontSize',16)


%----------------------------------------------- 
%           PARAMETERS  
%-----------------------------------------------

% coefficient of the TV norm (needs to be adapted for each image) 
lambda1=1;
lambda2=1;
mu=5000;
%  space discretization 
h=1.;
%  number of iterations (depends on the image) 
IterMax=10;
%  needed to regularize TV at the origin 
eps=0.000001;
% regularization of delta function
epsilon=1.;
delta = @(phi) (epsilon/pi)*(1/(phi^2+epsilon^2));
% regularization of heavy side function
H = @(phi) 0.5*(1+2*atan(phi/epsilon)/pi);

%-----------------------------------------------------------
%     BEGIN ITERATIONS IN ITER 
%-----------------------------------------------------------
Phi=Phi0;
Iter=1;
Energy(1)=0;

% carry out segmentation until difference in energy is small
for Iter = 1:IterMax
%while (Iter==1) || (norm(Energy(Iter)-Energy(Iter-1))>1e4) || (Iter>IterMax) 
    
    Iter=Iter+1
    
    % compute the mean inside and outside contour
    vPhi=Phi(:);
    vu=u0(:);
    C1=mean(vu(vPhi>=0));
    C2=mean(vu(vPhi<0));
    Phitmp=Phi;
    
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

            co=1.+(mu/(h*h))*(co1+co2+co3+co4);

            div=delta(Phi(i,j))*(co1*Phi(i+1,j)+co2*Phi(i-1,j)+...
                co3*Phi(i,j+1)+co4*Phi(i,j-1));

            Phi(i,j)=(delta(Phi(i,j))./co)*((mu/h^2)*div-...
                lambda1*(u0(i,j)-C1)^2+lambda2*(u0(i,j)-C2)^2);
        end
    end

    %------------ FREE BOUNDARY CONDITIONS IN PHI -------------------
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
    
    figure(16)
    image(uint8(u0)); axis image; axis off; colormap(gray);
    title('Segmentation')
    hold on
    contour(Phi,[0,0],'r')
    hold off
    %%% Compute the discrete energy at each iteration
    en=0.0;  
    for i=2:M-1
        for j=2:N-1 
            Phix=(Phi(i+1,j)-Phi(i,j))/h;
            Phiy=(Phi(i,j+1)-Phi(i,j))/h;
            fid1=(Phi0(i,j)-C1)*(Phi0(i,j)-C1);
            fid2=(Phi0(i,j)-C2)*(Phi0(i,j)-C2);
            en=en+mu*delta(Phi(i,j))*sqrt(eps*eps+Phix*Phix+Phiy*Phiy)+...
                lambda1*fid1*H(Phi(i,j))+lambda2*fid2*(1-H(Phi(i,j)));
        end
    end
    %%% END computation of energy 
    Energy(Iter)=en;
end 

disp('Total number of iterations = ')
disp(Iter)

disp('Approximation of energy = ')
disp(Energy(end))
figure(4)
image(uint8(u0)); axis image; axis off; colormap(gray); axis equal;
title('$F_1(C)\approx 0$, $F_2(C) \approx 0$, Fitting $\approx 0$','Interpreter','latex','FontSize',16)
hold on
contour(Phi,[0,0],'r')



