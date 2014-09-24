%% Merriman-Bence-Osher Method for Mean Curvature Motion
% Wavy and noisy square image
clear all
close all

%% Read and plot image
umat = imread('../Images/WavyNoisySquare.jpeg');
umat = double(umat)/255;
[M,N] = size(umat);

figure(1)
imagesc(umat); colormap(gray); axis equal; axis off;

%% Parameters
 
h = 1.;  % space step size
dt = 20;   % time step size
t = 0:dt:4*dt;  % vector of time values
Tend = dt;    % final time
k = dt;      % time stepping for diffusion part

%% Form matrices for linear system solve.

E = sparse(2:N,1:N-1,1,N,N); Imat = speye(N); 
A1D = E+E'-2*Imat; A1D(N,N-1) = 2; A1D(1,2) = 2; 
A2D = kron(A1D,Imat) + kron(Imat, A1D);

Amat = speye(N^2) - 0.5*k/h^2*A2D;
u = reshape(umat,N^2,1);

%% MBO method
for q = 1:length(t)
    %-----------------------Diffusion----------------------------
    time = 0;
    while (time<Tend)
        u = Amat\(u+0.5*k/h^2*A2D*u);
        time = time+k;
    end
    %-----------------------Threshold----------------------------
    u(u<=0.5) = 0;
    u(u>0.5) = 1;
    
    % plot segmentation
    figure(2);
    imagesc(reshape(u,N,N)); colormap(gray); axis equal; axis off;
    drawnow
end