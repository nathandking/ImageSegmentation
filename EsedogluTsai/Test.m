%% Esedoglu-Tsai method
% Code to test any image  
clear all
close all
tic
%% Read and plot initial image
u0=imread('../Images/WatermarkFinger.jpg');
[M,N] = size(u0);
u0 = double(u0);

figure(1)
imagesc(u0); axis image; axis off; colormap(gray);
title('Initial Image','Interpreter','latex','FontSize',20)

%% Initial Guess of a Circle
umat = zeros(N);
R = 200;
cx = M/2; cy = N/2;
x = 1:M; y = 1:N;
[X,Y] = ndgrid(x,y);
[theta,rho] = cart2pol(X-cx,Y-cy);
umat(rho<=R) = 1;

%% Parameters

lambda=0.01;   % tunable parameter
h=1.;   %  space step size

dt = 0.5*h^2;   % time step size
k = dt;   % time step size for diffusion part

%% Create matrices for discretization

E = sparse(2:N,1:N-1,1,N,N); Imat = speye(N); 
A1D = E+E'-2*Imat; A1D(N,N-1) = 2; A1D(1,2) = 2; 
A2D = kron(A1D,Imat) + kron(Imat, A1D);
C = (lambda/sqrt(pi*k))*mean(u0(:));
Amat = (1+k*C)*speye(N^2) - A2D;
u = reshape(umat,N^2,1);

%%
for t = dt:dt:5*dt
    %-------------------------Diffusion------------------------
    time = 0;
    while (time<dt)
        % compute the mean inside and outside contour
        uvec = u(:);
        fvec = u0(:);
        C1 = mean(fvec(uvec >= 0.5));
        C2 = mean(fvec(uvec < 0.5));
    
        A = (lambda/sqrt(pi*k))*((C1-fvec).^2+(C2-fvec).^2);
        B = (lambda/sqrt(pi*k))*(C2-fvec).^2;
    
        u = Amat\(uvec+k*(C-A).*uvec+B);
        time = time+k;
    end
    %-------------------------Threshold------------------------
    u(u<=0.5) = 0;
    u(u>0.5) = 1;
    
    % plot segmenation
    figure(2);
    imagesc(reshape(u,N,N));  axis image; axis off; colormap(gray);
    title('Esedoglu-Tsai Segmentation','Interpreter','latex','FontSize',20)
end 
toc
